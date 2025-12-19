
1. La structure des fichiersUn module nécessite au minimum un dossier et un fichier portant le même nom.

* **Dossier :** `MonModule`
* **Fichier de script :** `MonModule.psm1` (l'extension **.psm1** est cruciale).

2. Écrire le contenu du module (`.psm1`)Ouvrez votre fichier `.psm1` et placez-y vos fonctions. Par convention, on utilise souvent une fonction d'exportation pour choisir ce qui sera visible par l'utilisateur final.

```powershell
# MonModule.psm1

function Get-Hello {
    param($Nom)
    return "Bonjour $Nom, bienvenue dans mon module !"
}

function Invoke-SecretCalcul {
    # Cette fonction pourrait être interne (privée)
    return 2 + 2
}

# On exporte uniquement les fonctions que l'on veut rendre publiques
Export-ModuleMember -Function Get-Hello

```

---

3. Créer le Manifeste (`.psd1`)Le manifeste est un fichier de métadonnées (version, auteur, description). Il est fortement recommandé car il permet à PowerShell de "découvrir" votre module plus efficacement.

Utilisez la commande suivante pour le générer :

```powershell
New-ModuleManifest -Path ".\MonModule\MonModule.psd1" `
                   -RootModule "MonModule.psm1" `
                   -ModuleVersion "1.0.0" `
                   -Author "Votre Nom" `
                   -Description "Module de gestion interactive"

```

---

4. Où placer le module ?Pour que PowerShell trouve votre module automatiquement sans taper le chemin complet, vous devez le placer dans l'un des dossiers de la variable `$env:PSModulePath`.

Les emplacements standards sont :

* **Utilisateur actuel :** `Documents\PowerShell\Modules\`
* **Tous les utilisateurs :** `C:\Program Files\PowerShell\Modules\`

---

5. Charger et utiliser le moduleUne fois le dossier placé au bon endroit, vous pouvez l'utiliser :

```powershell
# Vérifier si le module est détecté
Get-Module -ListAvailable MonModule

# Charger le module
Import-Module MonModule -Force

# Utiliser la fonction
Get-Hello -Nom "Gemini"

```

---

Astuce : Pourquoi utiliser un module plutôt qu'un script ?
| Caractéristique | Script (.ps1) | Module (.psm1 / .psd1) |
| --- | --- | --- |
| **Chargement** | Manuel via le chemin | Automatique (Auto-loading) |
| **Partage** | Copie de fichiers isolés | Paquet structuré et versionné |
| **Portée** | Pollue souvent l'espace global | Encapsulation (fonctions privées) |
| **Aide** | `Get-Help ./script.ps1` | `Get-Help Get-Hello` (intégré) |

---

###Exercice rapide :Essayez de transformer votre script **"Devine le nombre"** en module.

1. Mettez la logique du jeu dans une fonction `Start-GuessGame`.
2. Créez le dossier `GuessGame` et le fichier `GuessGame.psm1`.
3. Importez-le et lancez la partie simplement en tapant `Start-GuessGame`.
