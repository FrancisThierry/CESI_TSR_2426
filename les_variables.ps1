# Exemple d'utilisation de variable en powershell
$nom = "Jean"
$age = 25
$age = $age + 1
Write-Host "Bonjour, je m'appelle $nom et j'ai $age ans."


# Afficher le contenu de C:\temp puis de C:\Temp\MonDossier
# Afficher au début de chaque liste Ici se trouve le dossier : <chemin>
$path = "C:\"
$folder = "Temp"
$path = $path + $folder
Write-Host "Ici se trouve le dossier : $path"
Get-ChildItem $path | Select-Object Name -First 5
$path = "C:\Temp\MonDossier"
Write-Host "Ici se trouve le dossier : $path"
Get-ChildItem $path | Select-Object Name -First 5




# On définit un bloc de code (entre accolades)
$monBloc = { Get-ChildItem | Sort-Object LastWriteTime -Descending | Select-Object -First 5 }

Invoke-Command -ScriptBlock $monBloc

# Modification de la valeur d'une variable
$age = 26
Write-Host "Bonjour, je m'appelle $nom et j'ai $age ans."
