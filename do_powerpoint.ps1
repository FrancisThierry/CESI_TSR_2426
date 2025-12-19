# 1. Initialisation de l'application PowerPoint
$objPPT = New-Object -ComObject PowerPoint.Application
$objPPT.Visible = -1  # 

# 2. Création de la présentation
$presentation = $objPPT.Presentations.Add()

# --- Diapositive 1 : Titre ---
$slide1 = $presentation.Slides.Add(1, 1) # 1 = ppLayoutTitle
$slide1.Shapes.Item(1).TextFrame.TextRange.Text = "Migration vers PowerShell 7"
$slide1.Shapes.Item(2).TextFrame.TextRange.Text = "De Windows PowerShell à l'ère Cross-Platform"

# --- Diapositive 2 : Comparaison ---
$slide2 = $presentation.Slides.Add(2, 2) # 2 = ppLayoutText
$slide2.Shapes.Item(1).TextFrame.TextRange.Text = "Architecture .NET"
$slide2.Shapes.Item(2).TextFrame.TextRange.Text = "- PowerShell 5.1 : .NET Framework (Windows uniquement)`n- PowerShell 7 : .NET Core (Multiplateforme)"

# --- Diapositive 3 : Les Modules ---
$slide3 = $presentation.Slides.Add(3, 2)
$slide3.Shapes.Item(1).TextFrame.TextRange.Text = "Fin des Snap-ins"
$slide3.Shapes.Item(2).TextFrame.TextRange.Text = "- Abandon de Add-PSSnapin`n- Standardisation des Modules (.psm1)`n- Couche de compatibilité Windows PowerShell"

Write-Host "Le PowerPoint a été généré avec succès !" -ForegroundColor Green

# Définir le chemin d'enregistrement (Bureau)
# $path = "$HOME\Desktop\MonCoursPowerShell.pptx"

# 32 correspond au format standard .pptx
$presentation.SaveAs("C:\Temp\MonCoursPowerShell.pptx", 32)

# Enregistrer la présentation
# $presentation.SaveAs($path)

# Optionnel : Fermer PowerPoint après l'enregistrement
# $objPPT.Quit()

Write-Host "Le fichier a été enregistré ici : $path" -ForegroundColor Cyan