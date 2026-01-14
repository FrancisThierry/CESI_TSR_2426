# TP 1 : Inventaire (Adapté pour VMware)

Get-Disk | Where-Object { $_.FriendlyName -match "VMware" -or $_.FriendlyName -match "Virtual" } | 
    Select-Object Number, 
                  FriendlyName, 
                  @{Name="Size(GB)"; Expression={ [Math]::Round($_.Size / 1GB, 2) }} | 
    Format-Table -AutoSize