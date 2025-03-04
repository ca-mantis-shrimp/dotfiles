# Assumes that the local .env file holds OP service account token
export (envsubst < ~/.env)
# Assumes $OP_SERVICE_ACCOUNT_TOKEN is set prior
set -gx ANTHROPIC_API_KEY $(op read op://Back-End/anthropic_api_key/credential)
set -gx TODOIST_API_KEY $(op read op://Back-End/todoist_api_key/credential)

switch (cat /etc/hostname) 
case USSFODARBURGES3
	set -gx SNOW_MIRROR_DADBOD = $(op read op://work/SNOWMIRROR/dadbod)
end
	

fish_vi_key_bindings

starship init fish | source

# Finally, start your splash screen!
nerdfetch
