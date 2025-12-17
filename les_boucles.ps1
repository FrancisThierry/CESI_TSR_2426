# Exemple 1 : Boucle for
for ($i = 0; $i -lt 10; $i++) {
    Write-Host "Tour n° $i"
}

# Exemple 2 : Boucle while
$i = 0
while ($i -lt 10) {
    Write-Host "Tour n° $i"
    $i++
}

# Exemple 3 : Boucle foreach
$array = @(1, 2, 3, 4, 5)
foreach ($element in $array) {
    Write-Host "Element : $element"
}

# Exemple 4 : Boucle do...while
$i = 0
do {
    Write-Host "Tour n° $i"
    $i++
} while ($i -lt 10)


# Exemple 5 : Boucle imbriqué avec un tableau associatif
$table = @{
    "nom" = "Jean"
    "prenom" = "Pierre"
    "age" = 30
}
foreach ($key in $table.Keys) {
    Write-Host "$key : $($table[$key])"
}

# Exemple 6 : Boucle imbriqué avec un tableau de hachage
$hashTable = [hashtable]::new()
$hashTable["nom"] = "Jean"
$hashTable["prenom"] = "Pierre"
$hashTable["age"] = 30
foreach ($key in $hashTable.Keys) {
    Write-Host "$key : $($hashTable[$key])"
}
