# 1. Simplification : On installe uniquement le module PSSQLite qui contient tout le nécessaire
function Install-SqliteModule {
    process {
        if (-not (Get-Module -ListAvailable -Name PSSQLite)) {
            Write-Host "Installation du module PSSQLite..." -ForegroundColor Green
            # Utilisation de -AllowClobber pour éviter les conflits avec des restes de NuGet
            Install-Module -Name PSSQLite -Scope CurrentUser -Force -AllowClobber
        }
        else {
            Write-Host "Le module PSSQLite est déjà installé." -ForegroundColor Green
        }
    }
}

# 2. Correction de la récupération (Gestion des objets SQLite et PSCustomObject)
function Get-ListRssFromDatabase {
    param (
        [Parameter(Mandatory = $true)]
        [string]$database
    )

    begin {
        Import-Module PSSQLite
        Write-Host "Récupération des flux depuis la base..." -ForegroundColor Yellow
    }

    process {
        try {
            # Invoke-SQLiteQuery renvoie déjà une collection d'objets si on ne précise rien
            $resultats = Invoke-SQLiteQuery -DataSource $database -Query "SELECT * FROM FluxRSS"
            
            # On transforme chaque ligne en PSCustomObject propre
            $rssItemsObjects = foreach ($item in $resultats) {
                [PSCustomObject]@{
                    Titre       = $item.Titre
                    Date        = $item.DatePub # Déjà au format string dans la DB
                    Description = if ($item.Description) { $item.Description.Trim() } else { "" }
                    Mots        = $item.Mots
                    Lien        = $item.Lien
                }
            }
            return $rssItemsObjects
        }
        catch {
            Write-Host "Erreur : $($_.Exception.Message)" -ForegroundColor Red
        } 
    }
}

# 3. Correction de l'insertion (Paramètres et conversion XML -> Texte)
function Add-Feed {
    param (
        [Parameter(Mandatory = $true)]
        [PSCustomObject]$article, 
        [Parameter(Mandatory = $true)]
        [string]$database
    )
    
    # $query = "INSERT INTO FluxRSS (Titre, DatePub, Description, Mots, Lien) 
    #           VALUES (@titre, @date, @desc, @mots, @lien)
    #           WHERE NOT EXISTS (SELECT 1 FROM FluxRSS WHERE Titre = @titre)"

    $query = "INSERT INTO FluxRSS (Titre, DatePub, Description, Mots, Lien) 
              VALUES (@titre, @date, @desc, @mots, @lien)
              "
    
    # Correction majeure : conversion des éléments XML en String et paramètre -QueryParameters
    $params = @{
        titre = $article.Titre.ToString()
        # On sécurise la date pour éviter l'erreur de pipeline Get-Date
        date  = (Get-Date $article.Date.ToString()).ToString("yyyy-MM-dd HH:mm:ss")
        desc  = if ($article.Description) { $article.Description.ToString() } else { "" }
        mots  = $article.Mots
        lien  = $article.Lien.ToString()
    }
    
    # Note: Le nom du paramètre est souvent -QueryParameters dans PSSQLite
    Invoke-SQLiteQuery -DataSource $database -Query $query -SqlParameters $params
    
    Write-Host "Article ajouté : $($article.Titre)" -ForegroundColor Gray
}

# 4. Correction de la création de table (Initialisation de $query)
function Set-CreateTable {
    param (
        [Parameter(Mandatory = $true)]
        [string]$database
    )

    process {
        Import-Module PSSQLite
        Write-Host "Vérification de la table FluxRSS..." -ForegroundColor Yellow
        
        # On définit la variable proprement (ne pas utiliser += sur une variable vide)
        $query = @"
CREATE TABLE IF NOT EXISTS FluxRSS (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Titre TEXT NOT NULL,
    DatePub TEXT NOT NULL,
    Description TEXT,
    Mots INTEGER NOT NULL,
    Lien TEXT NOT NULL
);
"@
        Invoke-SQLiteQuery -DataSource $database -Query $query
    }

    end {
        Write-Host "Base de données prête." -ForegroundColor Green
    }
}