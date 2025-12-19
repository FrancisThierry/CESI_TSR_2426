# Cours : Le Registre Windows et PowerShell###1. Qu'est-ce que le Registre Windows ?Le Registre est une **base de données hiérarchique** qui stocke les paramètres de configuration du système d'exploitation, des composants matériels et des applications.

Considérez-le comme le "cerveau" des réglages de Windows. Il est organisé en cinq branches principales (appelées **Hives**) :

* **HKEY_LOCAL_MACHINE (HKLM) :** Paramètres s'appliquant à tout l'ordinateur (matériel, logiciels installés).
* **HKEY_CURRENT_USER (HKCU) :** Paramètres spécifiques à l'utilisateur actuellement connecté (fond d'écran, préférences d'applications).
* **HKEY_CLASSES_ROOT :** Informations sur les types de fichiers (associations d'extensions).

---

###2. Le concept de "Drive" en PowerShellL'une des forces de PowerShell est qu'il traite le Registre comme un **lecteur de disque** (comme `C:`). Vous pouvez naviguer dedans avec les mêmes commandes que pour vos dossiers :

* `HKLM:` correspond à HKEY_LOCAL_MACHINE.
* `HKCU:` correspond à HKEY_CURRENT_USER.

---

###3. Comment lire les clés de registre ?En PowerShell, on distingue deux choses : la **Clé** (le dossier) et la **Valeur** (la donnée à l'intérieur).

####A. Lister les clés (Dossiers)Pour voir les sous-clés d'un emplacement :

```powershell
Get-ChildItem -Path "HKCU:\Software"

```

####B. Lire une valeur spécifiquePour lire une donnée précise, on utilise `Get-ItemProperty`.
*Exemple : Savoir si le mode sombre est activé pour l'utilisateur :*

```powershell
$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
Get-ItemProperty -Path $path -Name "AppsUseLightTheme"

```

####C. Extraire uniquement la donnéePour obtenir juste la valeur (0 ou 1) sans le nom de la propriété :

```powershell
Get-ItemPropertyValue -Path $path -Name "AppsUseLightTheme"

```

---

###4. Modifier ou Créer (Précautions)> **Attention :** Une erreur dans le registre peut rendre le système instable. Faites toujours une sauvegarde avant de modifier.

* **Créer une clé :** `New-Item -Path "HKCU:\Software\MonApplication"`
* **Ajouter une valeur :** ```powershell
Set-ItemProperty -Path "HKCU:\Software\MonApplication" -Name "Version" -Value "1.0"
```


```



---

###5. Exercice pratique : Analyse de sécurité**Objectif :** Créer un mini-script de santé qui vérifie si l'utilisateur a désactivé le consentement de l'UAC (Contrôle de compte d'utilisateur).

**Consigne :**

1. Allez lire la clé dans `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System`.
2. Vérifiez la valeur nommée `EnableLUA`.
3. Si la valeur est `1`, affichez "UAC Activé (Sécurisé)" en vert. Sinon, affichez un avertissement en rouge.

