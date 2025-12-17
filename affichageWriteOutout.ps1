Write-Output "Hello World"

Write-Output "2025-12-25", "2023-01-01", "2024-06-15"

# On les convertit et on les trie
Write-Output "2025-12-25", "2023-01-01", "2024-06-15" | Get-Date | Sort-Object| ForEach-Object {
    "La date formatée est : " + $_.ToString("dd/MM/yy")
}