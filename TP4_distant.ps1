### **TP 4 : Cartographie des services réseau**

#* **Objectif :** Lister les "portes d'entrée" ouvertes sur le serveur.
#* **Énoncé :** Listez toutes les connexions réseaux dont l'état est "Listen" (en écoute). Pour chaque connexion, affichez le port local et l'identifiant du processus (PID) associé.
#* **Indices :** `Get-NetTCPConnection`, paramètre `-State`.
Get-NetTCPConnection -State Listen | Select-Object LocalPort, OwningProcess | Format-Table