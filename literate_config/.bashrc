. "$HOME/.cargo/env"

eval "$(starship init bash)"

export PATH="/home/$USER/.local/share/bob/nvim-bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"