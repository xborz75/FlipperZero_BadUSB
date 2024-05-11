# Exécuter la commande netsh et stocker la sortie dans une variable
$output = netsh wlan show profile * key=CLEAR

# Chemin du répertoire du profil utilisateur actuel
$userProfileDirectory = $env:USERPROFILE

# Chemin du fichier de sortie
$outputFilePath = Join-Path -Path $userProfileDirectory -ChildPath "wlan_passwords.txt"

# Écrire la sortie dans un fichier
$output | Out-File -FilePath $outputFilePath -Encoding utf8

# Afficher la sortie à l'écran
Write-Output "Les informations WLAN ont été enregistrées dans le fichier : $outputFilePath"
