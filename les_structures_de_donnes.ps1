# Déclaration et ajout
$monTableau = @{
    Nom    = "Doe"
    Prenom = "John"
    Age    = 30
}

# Ajouter dynamiquement
$monTableau["Ville"] = "Paris"

# Exemple d'utilisation : Parcourir les clés
foreach ($cle in $monTableau.Keys) {
    Write-Host "$cle : $($monTableau[$cle])"
}



###2. Les Piles (Stacks)Une pile suit le principe **LIFO** (*Last In, First Out*). Le dernier élément ajouté est le premier à sortir.


$maPile = New-Object System.Collections.Stack
$maPile.Push("Étape 1 : Connexion")
$maPile.Push("Étape 2 : Analyse")
$maPile.Push("Étape 3 : Export")

# Regarder le dernier élément sans l'enlever
$dernier = $maPile.Peek() 
# Retourne "Étape 3 : Export"
Write-Host "Dernier élément dans la pile : $dernier"

# Retirer l'élément supérieur
$monElement = $maPile.Pop() # Retourne "Étape 3 : Export"

write-Host "Traitement de $monElement"

###3. Les Files d'attente (Queues)*Note : Dans votre exemple, "Fichiers" a été confondu avec la structure "File" (Queue).*
Une file suit le principe **FIFO** (*First In, First Out*). Idéal pour gérer des listes de tâches.


$maFile = New-Object System.Collections.Queue
$maFile.Enqueue("Ticket #001")
$maFile.Enqueue("Ticket #002")

# Traitement du premier élément arrivé
$traitement = $maFile.Dequeue() # Retourne "Ticket #001"
Write-Host "Traitement de $traitement"


###4. Les ClassesLes classes permettent de structurer des objets complexes avec des propriétés et des méthodes.


class Personne {
    [string]$Nom
    [string]$Prenom

    # Constructeur
    Personne([string]$n, [string]$p) {
        $this.Nom = $n
        $this.Prenom = $p
    }

    # Méthode
    [string]SePresenter() {
        return "Bonjour, je m'appelle $($this.Prenom) $($this.Nom)."
    }
}

$monObjet = [Personne]::new("John", "Doe")
$monObjet.SePresenter()



###5. Les Interfaces (Classes de base)PowerShell ne possède pas le mot-clé interface. Pour obtenir un comportement similaire, on utilise une **classe de base abstraite** ou on importe du code C#.


# Simulation d'interface via une classe de base
class Employe {
    [string] $Poste
    hidden [string] GetSalaire() { throw "Méthode non implémentée" }
}

class Developpeur : Employe {
    [string] GetSalaire() { return "5000€" }
}

$dev = [Developpeur]::new()
$dev.Poste = "Fullstack"
$dev.GetSalaire()


###6. Les Enums (Énumérations)Les énumérations permettent de définir un ensemble de constantes nommées.
enum JoursSemaine {
    Lundi
    Mardi
    Mercredi
    Jeudi
    Vendredi
    Samedi
    Dimanche
}

[JoursSemaine]::Lundi # Retourne "Lundi"
[JoursSemaine]::Vendredi # Retourne "Vendredi"

###7. Les Tuples (Paires de valeurs)Les tuples permettent de regrouper plusieurs valeurs dans une seule structure.
$monTuple = [Tuple[string, int]]::new("Alice", 28)
$nom = $monTuple.Item1 # "Alice"
$age = $monTuple.Item2 # 28
Write-Host "Nom : $nom, Age : $age"

###8. Les Graphes (Graphs)Les graphes sont des structures de données complexes composées de nœuds et d'arêtes. PowerShell ne dispose pas d'une implémentation native, mais on peut utiliser des bibliothèques externes ou créer des classes personnalisées pour les représenter.
class Noeud {
    [string]$Nom
    [Noeud[]]$Voisins
}   
$noeudA = [Noeud]::new()
$noeudA.Nom = "A"
$noeudB = [Noeud]::new()
$noeudB.Nom = "B"
$noeudC = [Noeud]::new()
$noeudC.Nom = "C"
$noeudA.Voisins = @($noeudB, $noeudC)   
$noeudB.Voisins = @($noeudC)    
$noeudC.Voisins = @($noeudA, $noeudB)       
Write-Host "Noeud $($noeudA.Nom) a pour voisins : " + ($noeudA.Voisins | ForEach-Object { $_.Nom } -join ", ")
###1. Les Tableaux Associatifs (Dictionnaires)Les tableaux associatifs, ou dictionnaires, permettent de stocker des paires clé-valeur pour un accès rapide aux données.
$monDictionnaire = @{}
$monDictionnaire["Nom"] = "Doe"
$monDictionnaire["Prenom"] = "John"
$monDictionnaire["Age"] = 30
Write-Host "Nom : $($monDictionnaire["Nom"]), Prénom : $($monDictionnaire["Prenom"]), Age : $($monDictionnaire["Age"])"