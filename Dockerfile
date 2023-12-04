FROM alpine:latest

ARG op_service_account
ENV OP_SERVICE_ACCOUNT_TOKEN $op_service_account

COPY ./ /root/.local/share/chezmoi
RUN apk add neovim chezmoi git curl build-base rust starship nodejs

RUN echo https://downloads.1password.com/linux/alpinelinux/stable/ >> /etc/apk/repositories && \
  wget https://downloads.1password.com/linux/keys/alpinelinux/support@1password.com-61ddfc31.rsa.pub -P /etc/apk/keys && \
  apk update && apk add 1password-cli

RUN chezmoi init --apply && \
  nvim --headless -c "+Lazy! sync" -c "TSUpdateSync" -c "qall" 
