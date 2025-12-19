#Cours : Migration de PowerShell 5.1 vers PowerShell 7Ce cours détaille les principes fondamentaux du passage de l'architecture "Legacy" (Windows PowerShell) à l'architecture moderne et multiplateforme (PowerShell 7).

---

##1. La rupture technologique : .NET Framework vs .NET CoreLa différence majeure réside dans le moteur d'exécution. Windows PowerShell 5.1 s'appuie sur le **.NET Framework**, ce qui le limite strictement à l'écosystème Windows. PowerShell 7 repose sur **.NET Core** (ou simplement .NET 6/8), un moteur léger, modulaire et compatible avec Linux et macOS.

```mermaid
graph TD
    A[PowerShell] --> B(Windows PowerShell 5.1)
    A --> C(PowerShell 7+)
    
    B --> B1[.NET Framework]
    B1 --> B2[Windows Uniquement]
    
    C --> C1[.NET Core / .NET]
    C1 --> C2[Windows, Linux, macOS]
    
    style B fill:#f9f,stroke:#333,stroke-width:2px
    style C fill:#00ff00,stroke:#333,stroke-width:2px

```

---

##2. L'abandon des Snap-ins au profit des ModulesDans les versions 1.0 et 2.0, PowerShell utilisait des **Snap-ins** (fichiers .dll enregistrés dans le registre Windows). Depuis la version 3.0, et de manière obligatoire en version 7, le format standard est le **Module**.

Les Snap-ins ne sont pas compatibles avec PowerShell 7 car la commande `Add-PSSnapin` n'existe plus dans cette édition.

```mermaid
graph LR
    subgraph "Ancien (PS 1.0 / 2.0)"
    S[Snap-in .dll] --> R[Registre Windows]
    R --> cmd1[Add-PSSnapin]
    end

    subgraph "Moderne (PS 3.0+ / PS 7)"
    M[Module .psm1 / .psd1] --> P[Dossier PSModulePath]
    P --> cmd2[Import-Module]
    end

```

---

##3. Stratégies de MigrationPour transformer un script utilisant de vieux Snap-ins, il existe trois approches graduelles :

###A. Remplacement directVérifier si l'éditeur a publié une version "Module" du Snap-in (ex: VMware PowerCLI ou Exchange Online).

###B. Couche de compatibilité WindowsSi aucun module PS7 n'existe, on utilise la fonction d'interopérabilité qui lance une session Windows PowerShell 5.1 en arrière-plan.

```powershell
Import-Module MonVieuxModule -UseWindowsPowerShell

```

###C. Remoting ImpliciteExécuter le code directement sur un serveur distant qui possède encore les bibliothèques d'origine.

```mermaid
sequenceDiagram
    participant PS7 as PowerShell 7 (Client)
    participant PS5 as WinPS 5.1 (Serveur)
    
    PS7->>PS5: New-PSSession
    PS7->>PS5: Invoke-Command { Add-PSSnapin... }
    PS5-->>PS7: Retourne les objets (désérialisés)

```

---

##4. Tableau de correspondance
| Fonctionnalité | Windows PowerShell (v5.1) | PowerShell 7 (Core) |
| --- | --- | --- |
| **Exécutable** | `powershell.exe` | `pwsh.exe` |
| **Variable `$PSEdition**` | `Desktop` | `Core` |
| **Extension** | `Add-PSSnapin` | `Import-Module` |
| **Plateformes** | Windows uniquement | Cross-plateforme |

---

