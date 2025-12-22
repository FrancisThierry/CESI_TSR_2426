
. .\file_function.ps1
$source = "C:\Temp"
$destinationPath = "C:\Temp\Archive"
Write-Host "Archivage du fichier $source vers $destinationPath" -ForegroundColor Cyan

$daysOld = 7
Write-Host "Recherche des fichiers plus anciens que $daysOld jours dans $source" -ForegroundColor Cyan
$oldFiles = Get-FileMoreThanDaysOld -directoryPath $source -daysOld $daysOld
foreach ($file in $oldFiles) {
    Write-Host "Fichier trouvé : $($file.FullName), Dernière modification : $($file.LastWriteTime)" -ForegroundColor Yellow
    Move-Archive-File -sourcePath $file.FullName -archiveDir $destinationPath
}