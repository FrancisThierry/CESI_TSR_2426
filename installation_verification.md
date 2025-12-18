###Installation de PowerShell via la ligne de commandePour installer proprement la version la plus récente de PowerShell (v7+), utilisez l'une des deux méthodes suivantes :

**Via Winget (Recommandé) :**

```powershell
winget install --id Microsoft.Powershell --source winget

```

**Via le script d'installation MSI direct :**

```powershell
iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI"

```

---

###Gestion des versions####Identifier la version en cours d'utilisationCette commande affiche un tableau contenant la version précise du moteur PowerShell actif.

```powershell
$PSVersionTable.PSVersion

```

####Localiser les exécutables installésPour différencier Windows PowerShell (5.1) et PowerShell Core (7.x) :

```powershell
# Localise PowerShell 7 (pwsh.exe)
where.exe pwsh

# Localise Windows PowerShell 5.1 (powershell.exe)
where.exe powershell

```

####Mettre à jour PowerShell```powershell
winget upgrade --id Microsoft.Powershell

```

---

###Suppression d'une version spécifiqueLa suppression manuelle des chemins dans `$env:PSModulePath` est déconseillée car elle ne désinstalle pas l'application, mais casse le lien avec les bibliothèques. Pour supprimer proprement PowerShell 7 :

**Via Winget :**

```powershell
winget uninstall --id Microsoft.Powershell

```

**Via PowerShell (si installé par MSI) :**

```powershell
Get-Package -Name "PowerShell" | Uninstall-Package

```

---

###Comparaison des environnements| Fonction | Windows PowerShell | PowerShell (Core) |
| --- | --- | --- |
| **Version** | 5.1 | 7.x (actuelle) |
| **Exécutable** | `powershell.exe` | `pwsh.exe` |
| **Fondation** | .NET Framework | .NET 6/7/8/9 |
| **Plateformes** | Windows uniquement | Windows, Linux, macOS |

