eval "$(starship init bash)"

export PATH="/home/$USER/.local/share/bob/nvim-bin:$PATH"

export OPENAI_API_KEY = "{{ onepasswordRead "op://Personal/openai_api_key/notesPlain" }}"

. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"