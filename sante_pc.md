
## 🛠️ TD : Audit de Santé Système via PowerShell

### 🎯 Objectif

Développer un script de diagnostic capable de collecter des métriques matérielles via les classes **CIM** (Common Information Model) et de générer un objet de reporting structuré.

---

### 📚 Étape 1 : Collecte des indicateurs bruts

Votre script doit interroger le système pour récupérer trois types de données fondamentales.

**Défis de collecte :**

1. **Alerte Disque :** Utilisez la classe `MSStorageDriver_FailurePredictStatus` (dans le namespace `root\wmi`) pour vérifier si une défaillance est imminente.
2. **État de la RAM :** À partir de `Win32_OperatingSystem`, calculez le pourcentage de mémoire vive disponible par rapport à la capacité totale.
3. **Charge CPU :** Récupérez la charge moyenne d'utilisation du processeur via `Win32_Processor`.

---

### ⚙️ Étape 2 : Consolidation et Calculs

Au lieu d'afficher les résultats un par un, vous devez les centraliser dans un **Tableau de bord** (Hashtable).

**Consignes de traitement :**

* **Formatage :** Convertissez les chiffres bruts en pourcentages lisibles en utilisant l'outil d'arrondi `[math]::Round()`.
* **Interprétation :** Traduisez les données techniques en statuts "Humains". Par exemple, si une erreur disque est détectée, la valeur associée doit être "CRITIQUE" au lieu de "True".

---

### 📊 Étape 3 : Génération du Rapport Final

Pour que vos données soient exploitables (tri, export CSV, etc.), vous devez convertir votre dictionnaire de résultats en un **[PSCustomObject]**.

**Structure du reporting attendue :**
À la fin de l'exécution, votre script doit produire un tableau comportant exactement les colonnes suivantes :

| Colonne | Description | Format attendu |
| --- | --- | --- |
| **Ordinateur** | Nom de la machine ciblée | Chaîne de caractères |
| **Sante_Disque** | État S.M.A.R.T du disque principal | "Sain" ou "CRITIQUE" |
| **RAM_Libre_Pct** | Pourcentage de mémoire vive restante | Nombre (ex: 45.5) |
| **Charge_CPU** | Utilisation moyenne du processeur | Pourcentage (ex: 12%) |
| **Statut_Batterie** | (Optionnel) Niveau de charge | "N/A" ou "XX%" |

---

### 🧪 Défi : Détection intelligente

Modifiez votre script pour que la colonne **Statut_Batterie** ne soit pas simplement vide sur un PC fixe, mais qu'elle affiche "Fixe" ou qu'elle ne soit calculée que si le composant `Win32_Battery` renvoie une instance valide.

---
