# ### **TP 9 : Analyse des erreurs critiques du journal d'évènements**

# * **Objectif :** Anticiper les pannes système.
# * **Énoncé :** Interrogez le journal d'évènements "System". Affichez les 5 dernières erreurs (Type: Error) enregistrées, avec l'heure, la source de l'erreur et le message d'explication.
# * **Indices :** `Get-EventLog`, `-LogName System`, `-EntryType Error`, `-Newest 5`.
Get-EventLog -LogName System -EntryType Error -Newest 5 | 
    Select-Object TimeGenerated, Source, Message | 
    Format-Table -AutoSize