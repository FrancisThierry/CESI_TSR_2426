# Exemple de conditions avec if, switch, else

# Condition avec if
$a = 5
if ($a -gt 10) {
    Write-Host "a est supérieur à 10"
} else {
    Write-Host "a est inférieur à 10"
}

# Condition avec switch
$b = "hello"
switch ($b) {
    "hello" { Write-Host "Bonjour" }
    "bonjour" { Write-Host "Bonne journée" }
    default { Write-Host "Je ne sais pas quoi dire" }
}

# Condition avec else
$c = 15
if ($c -lt 10) {
    Write-Host "c est inférieur à 10"
} elseif ($c -gt 20) {
    Write-Host "c est supérieur à 20"
} else {
    Write-Host "c est entre 10 et 20"
}

# Opérateur ternaire
$d = 12
$e = ($d -lt 10) ? "inférieur" : "supérieur"
Write-Host "d est $e à 10"

# Tester le type d'une variable
$f = "bonjour"
Write-Host ("$f est de type " + $f.GetType().Name)

Write-Host "Opérateurs de comparaison :"
Write-Host "-lt (inférieur) : " + ($a -lt $b)
Write-Host "-le (inférieur ou égal) : " + ($a -le $b)
Write-Host "-gt (supérieur) : " + ($a -gt $b)
Write-Host "-ge (supérieur ou égal) : " + ($a -ge $b)
Write-Host "-eq (égal) : " + ($a -eq $b)
Write-Host "-ne (différent) : " + ($a -ne $b)
Write-Host "-like (contient) : " + ($f -like "*jour*")
Write-Host "-notlike (ne contient pas) : " + ($f -notlike "*jour*")
Write-Host "-match (correspond) : " + ($f -match "bonjour")
Write-Host "-notmatch (ne correspond pas) : " + ($f -notmatch "bonjour")
Write-Host "-contains (contient) : " + ($f -contains "bonjour")
Write-Host "-notcontains (ne contient pas) : " + ($f -notcontains "bonjour")
Write-Host "-in (est dans) : " + ($f -in @("bonjour", "bonsoir"))
Write-Host "-notin (n'est pas dans) : " + ($f -notin @("bonjour", "bonsoir"))
