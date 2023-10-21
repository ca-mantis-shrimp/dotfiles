$Env:SHELL=pwsh

{{- if ne .chezmoi.hostname "USMINDARBURGES1" }}
$Env:OPENAI_API_KEY= op read op://Back-End/openai_api_key/credential
{{- end }}

$Env:TODOIST_API_KEY = op read op://Back-End/todoist_api_key/credential

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