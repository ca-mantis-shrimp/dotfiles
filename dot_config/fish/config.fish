# Assumes $OP_SERVICE_ACCOUNT_TOKEN is set prior
set -gx ANTHROPIC_API_KEY $(op read op://Back-End/anthropic_api_key/credential)
set -gx TODOIST_API_KEY $(op read op://Back-End/todoist_api_key/credential)

fish_vi_key_bindings

starship init fish | source
