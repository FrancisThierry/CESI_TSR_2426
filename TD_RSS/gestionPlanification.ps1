. .\scheduller-function.ps1
$taskName = "Tache_Generation_PPT_RSS"
$scriptPath = "C:\projets\CESI_TSR_2426\TD_RSS\gestionPpt.ps1"
Add-Scheduller -scriptPath $scriptPath -taskName $taskName