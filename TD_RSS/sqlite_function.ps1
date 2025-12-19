function Install-SqliteLibrary {
    begin {
        Write-Host "Vérification et installation de la bibliothèque SQLite si nécessaire..." -ForegroundColor Yellow
    }

    process {
        # Vérifie si le fournisseur SQLite est disponible, sinon l'installe pour l'utilisateur actuel
        if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
            Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
        }

        if (-not (Get-Module -ListAvailable Microsoft.Data.Sqlite)) {
            # Installation de la bibliothèque dans le scope utilisateur
            Write-Host "Installation de la bibliothèque Microsoft.Data.Sqlite..." -ForegroundColor Green
            Install-Package -Name Microsoft.Data.Sqlite -Source nuget.org -Scope CurrentUser -Force
        }
    }

    end {
        Write-Host "Vérification et installation de la bibliothèque SQLite terminées." -ForegroundColor Green
    }
}

function Set-SqlLibrary {
    begin {
        Write-Host "Chargement de la bibliothèque SQLite..." -ForegroundColor Yellow
    }

    process {
        # Import-Module Microsoft.Data.Sqlite -Force
        # 1. On cherche où le paquet a été installé (souvent dans Program Files ou Documents)
        $package = Get-Package -Name Microsoft.Data.Sqlite

        # 2. On charge la DLL en mémoire
        # Note : Le chemin peut varier légèrement selon la version, on utilise un joker (*)
        Add-Type -Path "$($package.Source)\lib\netstandard2.0\Microsoft.Data.Sqlite.dll"
    }

    end {
        Write-Host "Bibliothèque SQLite chargée." -ForegroundColor Green
    }
}

function Install-SqliteModule{

    process {
        if (-not (Get-Module -ListAvailable -Name PSSQLite)) {
            Write-Host "Installation du module SQLite..." -ForegroundColor Green
            Install-Module -Name PSSQLite -Scope CurrentUser -Force -AllowClobber
        }
        else {
            Write-Host "Le module SQLite est déjà installé." -ForegroundColor Green
        }
    }
}

function Get-ListRssFromDatabase {
    param (
        [string]$db 
    )

    begin {
        Import-Module PSSQLite
        Write-Host "Récupération de la liste des flux RSS depuis la base de données..." -ForegroundColor Yellow
    }

    process {
        try {
            $resultat = Invoke-SQLiteQuery -DataSource $db -Query "SELECT * FROM FluxRSS"
            $rssItems = $resultat.Rows
            foreach ($item in $rssItems) {
                Write-Host "ID: $($item.Id), Titre: $($item.Titre), Date: $($item.DatePub), Mots-clés: $($item.MotsCles), Lien: $($item.Lien)"
            }
        }
        catch {
            Write-Host "Une erreur s'est produite $_.Exception.Message." -ForegroundColor Red
        }   

    }
    end {
        Write-Host "Récupération terminée." -ForegroundColor Green
        return $rssItems
    }
}

function Add-Feed {
    param (
        [string]$db,
        [string]$titre,
        [string]$datePub,
        [string]$motsCles,
        [string]$lien
    )
    $query = "INSERT INTO FluxRSS (Titre, DatePub, MotsCles, Lien) VALUES ('{0}', '{1}', '{2}', '{3}')" -f $titre, $datePub, $motsCles, $lien
    Invoke-SQLiteQuery -DataSource $db -Query $query
    Write-Host "Flux RSS ajouté à la base de données." -ForegroundColor Green}