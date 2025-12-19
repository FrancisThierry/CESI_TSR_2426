
#TD : Jeu "Devine le nombre" (Version Interactive)**Objectif :** Créer un script fluide qui interagit avec l'utilisateur via la console en utilisant les meilleures pratiques de PowerShell.

##1. Initialisation (Le bloc `begin`)C'est ici que tu prépares le terrain avant que le jeu ne commence.

* Génère le nombre secret entre 1 et 100 avec `Get-Random`.
* Initialise ton compteur de tentatives à 0.
* Affiche un message de bienvenue coloré.

---

##2. La boucle de lecture (Le bloc `process`)Au lieu d'un simple script qui s'arrête, tu vas créer une boucle "tant que" (`while`) ou "faire jusqu'à" (`do...until`).

###Utilisation de "Read-Host" comme un Readline :Dans ta boucle, utilise la syntaxe suivante pour récupérer la saisie :

```powershell
$saisie = Read-Host "Entrez votre proposition "

```

###Logique à implémenter :1. **Incrémentation :** Ajoute 1 à ton compteur à chaque saisie.
2. **Conversion :** Assure-toi que la saisie est un nombre (en utilisant le *casting* `[int]`).
3. **Comparaison :**
* Si `$saisie -lt $nombreSecret` : Affiche "Plus grand !" en Jaune.
* Si `$saisie -gt $nombreSecret` : Affiche "Plus petit !" en Cyan.
* Si `$saisie -eq $nombreSecret` : Affiche "Bravo !" en Vert et arrête la boucle.



---

##3. Gestion des erreurs (Robustesse)Pour éviter que ton jeu ne plante si l'utilisateur appuie sur "Entrée" sans rien écrire ou tape des lettres, utilise un bloc `try/catch` :

```powershell
try {
    [int]$nombrePropose = $saisie
}
catch {
    Write-Host "Erreur : Veuillez entrer un nombre valide !" -ForegroundColor Red
    continue # Relance la boucle sans compter l'essai
}

```

---

##4. Bonus : Le récapitulatif (Le bloc `end`)Une fois que l'utilisateur a trouvé le nombre, le bloc `end` doit s'exécuter pour :

* Afficher le score final (nombre de tentatives).
* Proposer de rejouer ou quitter.

---

###Aide visuelle sur la boucle logique**Conseil de pro :** Pour rendre l'invite de commande encore plus "moderne", tu peux personnaliser le texte de `Read-Host` avec des symboles comme `[ ? ] Guess > `.

