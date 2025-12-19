# 1. Chargement des fonctions
. ./rss_function.ps1
. ./sqlite_function.ps1

# 2. Configuration des variables
$rssPath = "https://www.lemonde.fr/rss/une.xml"
$db = "C:\database\veille.db"

# 3. Préparation de l'environnement (Installation et création table)
Install-SqliteModule
Set-CreateTable -database $db

# 4. Collecte des données (On garde les OBJETS bruts, sans Format-Table)
$articles = Get-Rss -Url $rssPath

# 5. Visualisation console (Optionnel, juste pour vérifier)
$articles | Format-Table Titre, Mots, Date -AutoSize

# 6. Insertion dans la base de données avec vérification de doublons
Write-Host "Insertion des articles en base de données..." -ForegroundColor Cyan

foreach ($article in $articles) {
    # On prépare le titre (on force en string au cas où c'est un XmlElement)
    $titreNettoye = $article.Titre.ToString()

    # Requête pour vérifier l'existence
    $queryCheck = "SELECT COUNT(*) as Count FROM FluxRSS WHERE Titre = @titre"
    $checkParams = @{ titre = $titreNettoye }
    
    $exists = Invoke-SQLiteQuery -DataSource $db -Query $queryCheck -SqlParameters $checkParams

    if ($exists.Count -eq 0) {
        # Le titre n'existe pas, on peut ajouter
        Add-Feed -db $db -article $article
    } else {
        # Le titre existe déjà, on informe l'utilisateur
        Write-Host "Saut : L'article existe déjà : $($titreNettoye)" -ForegroundColor DarkGray
    }
}

# 7. Récupération et affichage final depuis la base
# Write-Host "`nContenu actuel de la base de données :" -ForegroundColor Yellow
# $donneesEnBase = Get-ListRssFromDatabase -db $db
# $donneesEnBase | Format-Table -AutoSize