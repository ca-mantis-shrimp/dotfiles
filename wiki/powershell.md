

# PowerShell

PowerShell will look largely the same as bash, only with a few variations on the commands for PowerShell
``` ps1
$prompt = ""
function Invoke-Starship-PreCommand {
$current_location = $executionContext.SessionState.Path.CurrentLocation
if ($current_location.Provider.Name -eq "FileSystem") {
$ansi_escape = [char]27
$provider_path = $current_location.ProviderPath -replace "\\", "/"
$prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
}
$host.ui.Write($prompt)
}
Invoke-Expression (&starship init powershell)

$Env:OPENAI_API_KEY = op op://Back-End/openai_api_key/notesPlain" }}
$Env:TODOIST_API_KEY = op read op://Back-End/TODOIST_API_KEY/credential

```
- This first function was pulled directly from the [Shell Integration Page of Wezterm](https://wezfurlong.org/wezterm/shell-integration.html) to allow us to hook into starship prompt and provide OSC 7 codes.
    - Functions like this advise the terminal on the working directory
- Again, we are just invoking the startship prompt
    - Therefore, we just need to be sure it is installed on the machine before we put this configuration file in here

This config file has less manual work than the bash file because windows in general believes less in managing system configuration through the shell.
Instead they often opt to change configuration through dedicated GUI programs or other discrete tools that need to be setup before the shell is even started, however, once you are done, there is less manual wiring required to get the application running than in the bash shell.
