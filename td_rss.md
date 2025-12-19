# TD : Système de Veille, Reporting et Archivage (Script PowerShell & SQLite)

**Objectif :** Créer une chaîne de traitement automatisée dans un script unique (`VeilleRSS.ps1`) allant de la collecte de données à leur archivage, en passant par le stockage SQL et la génération PowerPoint.

### Liste des flux

https://www.lemonde.fr/le-monde-et-vous/article/2025/07/14/les-flux-rss-du-monde-fr_5498778_3237.html

---

## Partie 1 : Fonctions du Script Unique

Au lieu d'un module, vous allez définir quatre fonctions principales au début de votre script :

### 1.1 Extraction et Analyse (`Get-MediaFeed`)

* **Source :** Utiliser le flux RSS du Monde.fr.
* **Traitement :** Extraire les **10 premiers flux**.
* **Analyse :** Nettoyer les balises HTML des descriptions et calculer le **nombre de mots**.
* **Sortie :** Retourner un objet personnalisé (`PSCustomObject`).

### 1.2 Persistance SQLite (`Save-ToDatabase`)

* **Initialisation :** Vérifier l'existence d'un fichier `veille.db`. Si absent, créer la table `FluxRSS` (Colonnes : Id, Titre, Date, Mots, Lien).
* **Action :** Insérer les 10 entrées récupérées.
* **Technique :** Utiliser les types .NET `System.Data.SQLite` ou `Microsoft.Data.Sqlite` directement dans le script.

### 1.3 Génération PowerPoint (`New-DailyReport`)

* **Automatisation COM :** Piloter PowerPoint pour créer une présentation de 10 slides (1 slide par article).
* **Contenu :** Titre de l'article et résumé (nombre de mots).
* **Nettoyage :** Assurer la fermeture des processus PowerPoint en fin d'exécution.

### 1.4 Archivage (`Invoke-Archiving`)

* **Logique :** Analyser un dossier "Exports".
* **Action :** Déplacer les rapports de plus de **30 jours** vers un dossier "Archive".

---

## Partie 2 : Le Corps du Script (Orchestration)

Le bas de votre fichier `.ps1` doit contenir la logique d'exécution séquentielle :

1. **Déclaration des variables :** Chemins vers la base de données, les dossiers d'export et l'URL du flux.
2. **Collecte :** Appeler `Get-MediaFeed`.
3. **Stockage :** Transmettre les résultats à `Save-ToDatabase`.
4. **Affichage Console :** Utiliser `Format-Table` pour afficher un résumé (Titre, Mots, Date) à l'écran.
5. **Génération :** Lancer `New-DailyReport` pour créer le fichier `.pptx` du jour.
6. **Maintenance :** Exécuter `Invoke-Archiving`.

---

## Partie 3 : Déploiement et Planification

* **Gestion des Dépendances :** Ajouter un bloc au début du script pour vérifier si le driver SQLite est présent, sinon l'installer via `Install-Package` ou charger la DLL.
* **Planification :** Créer une commande PowerShell permettant d'enregistrer ce script dans le **Planificateur de tâches Windows** pour une exécution quotidienne à **08:00**.

---
