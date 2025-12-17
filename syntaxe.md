
### Syntaxe des cmdlets

Les cmdlets PowerShell suivent une structure normalisée appelée **Verbe-Nom**. Cette conception permet de deviner facilement le nom d'une commande.

#### Structure d'une commande

Une ligne de commande PowerShell se décompose en trois éléments distincts :

* **Le Verbe** : Indique l'action à accomplir. PowerShell utilise une liste de verbes approuvés (ex: `Get` pour récupérer, `Set` pour modifier, `New` pour créer).
* **Le Nom (Noun)** : Indique la ressource sur laquelle l'action s'exerce (ex: `Service`, `Process`, `ChildItem`). Le verbe et le nom sont toujours séparés par un trait d'union (`-`).
* **Les Paramètres et Valeurs** : Ce ne sont pas une "commande" en soi, mais des arguments qui précisent le comportement du cmdlet. Un **paramètre** commence toujours par un tiret (ex: `-Path`), et il est généralement suivi d'une **valeur** (ex: `C:\`).

---

#### Exemple détaillé

Prenons le cmdlet : `Get-ChildItem -Path C:\ -Filter *.txt`

| Élément | Type | Description |
| --- | --- | --- |
| **Get** | **Verbe** | L'action de récupérer quelque chose. |
| **ChildItem** | **Nom** | L'objet (ici, les fichiers et dossiers). |
| **-Path** | **Paramètre** | Spécifie l'endroit où chercher. |
| **C:\** | **Valeur** | L'argument transmis au paramètre `-Path`. |
| **-Filter** | **Paramètre** | Spécifie une condition de recherche. |
| ***.txt** | **Valeur** | L'argument transmis au paramètre `-Filter`. |

> **Note importante :** L'ensemble de la ligne (le cmdlet + les paramètres) est ce qu'on appelle une **instruction** ou une **commande**. Contrairement à votre texte initial, on ne dit pas que les paramètres *sont* la commande, mais qu'ils la *composent*.

#### Pourquoi cette syntaxe est-elle utile ?

Grâce à cette structure constante, vous pouvez utiliser la touche **Tab** pour l'auto-complétion :

1. Tapez `Get-Chi` + **Tab** → PowerShell complète le cmdlet.
2. Tapez un espace et `-` + **Tab** → PowerShell fait défiler les paramètres disponibles.

