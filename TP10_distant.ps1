# ### **TP 10 : Test de rebond réseau (Connectivity)**

# * **Objectif :** Tester la communication du serveur vers l'extérieur.
# * **Énoncé :** Le script doit vérifier si le serveur distant parvient à joindre `google.com` sur le port 443 (HTTPS) et afficher si le test a réussi ou échoué de manière claire.
# * **Indices :** `Test-NetConnection`, `-ComputerName`, `-Port`.

$computerName = "google.com"
$port = 443
$result = Test-NetConnection -ComputerName $computerName -Port $port
if ($result.TcpTestSucceeded) {
    Write-Host "Le test de connexion vers $computerName sur le port $port a réussi." -ForegroundColor Green
} else {
    Write-Host "Le test de connexion vers $computerName sur le port $port a échoué." -ForegroundColor Red
}
