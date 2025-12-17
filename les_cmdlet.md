## Les cmdlet

###1. Sélectionner et transformer les données : `Select-Object`Alors que `Where-Object` filtre les lignes (les objets), `Select-Object` permet de choisir quelles colonnes (les propriétés) on souhaite afficher.

* **Exemple :** Afficher uniquement le nom et la taille des fichiers texte.
`Get-ChildItem -Path C:\ -Filter *.txt | Select-Object -Property Name, Length`

###2. Agir sur chaque élément : `ForEach-Object`Ce cmdlet est le moteur de l'automatisation. Il permet d'exécuter un bloc de commande pour chaque objet reçu dans le pipeline.

* **Exemple :** Renommer tous les fichiers `.txt` en ajoutant un préfixe "Backup_".
`Get-ChildItem -Filter *.txt | ForEach-Object { Rename-Item $_.FullName -NewName ("Backup_" + $_.Name) }`

###3. Exporter les résultats : `Export-Csv` et `Out-File`PowerShell permet de sauvegarder très facilement le résultat de vos commandes dans des fichiers structurés.

* **Exemple :** Exporter la liste des fichiers de plus de 1 Mo vers un fichier CSV.
`Get-ChildItem | Where-Object {$_.Length -gt 1mb} | Export-Csv -Path "./rapport.csv" -NoTypeInformation`

---

###Comprendre le fonctionnement interne : Le PipelineLe schéma suivant illustre comment les données circulent d'une commande à l'autre. Contrairement au Bash (Linux) qui fait circuler du texte, PowerShell fait circuler des **objets complets**.

| Concept | Description |
| --- | --- |
| **Entrée** | Le premier cmdlet génère une collection d'objets (ex: des fichiers). |
| **Le Pipe (`|`)** | Il sert de connecteur, envoyant l'objet entier au cmdlet suivant. |
| **Traitement** | Le cmdlet suivant peut filtrer, trier ou modifier ces objets sans perdre leurs propriétés. |

---

###Autres cmdlets utiles pour la gestion systèmeVoici un tableau récapitulatif pour élargir votre boîte à outils :

| Cmdlet | Utilité | Exemple d'usage |
| --- | --- | --- |
| `Get-Service` | Liste les services du système | `Get-Service |
| `Stop-Process` | Arrête un processus en cours | `Stop-Process -Name "Notepad"` |
| `Get-Content` | Lit le contenu d'un fichier | `Get-Content -Path "config.txt" -TotalCount 10` |
| `Copy-Item` | Copie des fichiers ou dossiers | `Copy-Item -Path "./source.txt" -Destination "./backup/"` |

---

###Astuce : L'auto-découverteSi vous cherchez un cmdlet pour une action précise, utilisez `Get-Command` avec des caractères génériques :

* `Get-Command *Service*` : Pour trouver tout ce qui touche aux services.
* `Get-Help Get-Service -Examples` : Pour voir comment utiliser un cmdlet spécifique avec des cas concrets.

