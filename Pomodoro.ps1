# Set the duration of the timer in minutes
$duration = Read-Host "Enter the duration of the timer in minutes (default is 30)"
if (!$duration) { $duration = 30 }

# Convert minutes to seconds
$duration = [int]([float]$duration * 60)

# Get task name from user
$task = Read-Host "What task are you working on?"

# Initialize the progress bar
$bar = "[--------------------------------------------------]"
$progress = 0

# Start the timer
for ($i = $duration; $i -gt -1; $i--) {
    # Calculate the percentage completed
    $percentage = [Math]::Round(($duration - $i) / $duration * 100)

    # Update the progress bar
    $bar = "[" + "-".PadRight($percentage / 2, "-" ) + "".PadRight(50 - $percentage / 2, " ") + "]"

    # Print the progress bar
    Write-Host -NoNewline -BackgroundColor White -ForegroundColor Black "Progress: $bar $percentage%`r"

    # Wait for 1 second
    Start-Sleep -Milliseconds 1000
}

# Play sound
[System.Media.SystemSounds]::Asterisk.Play()

# Wait for key press
Write-Host "`nTask finished, press ENTER key to start a new session. CTRL + C to close the window"
$key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
if ($key.Character -eq "`r") {
    Write-Host "Starting a new Pomodoro session" -ForegroundColor White
    & $MyInvocation.MyCommand
} else {
    exit
}
