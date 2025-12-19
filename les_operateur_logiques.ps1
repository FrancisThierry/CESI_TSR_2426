# Exemples d'utilisation des opérateurs logiques

# Exemple 1 : -and
$a = 5
$b = 10
$c = 15

if ($a -gt 10 -and $b -gt 15 -and $c -gt 20) {
    Write-Host "Tous les conditions sont vraies"
}

# Exemple 2 : -or
if ($a -lt 10 -or $b -lt 15 -or $c -lt 20) {
    Write-Host "Au moins une des conditions est vraie"
}

# Exemple 3 : -not
if (-not ($a -gt 10 -and $b -gt 15 -and $c -gt 20)) {
    Write-Host "Au moins une des conditions n'est pas vraie"
}
