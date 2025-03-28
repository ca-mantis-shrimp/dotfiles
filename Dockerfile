FROM archlinux:latest

ARG op_service_account
ENV OP_SERVICE_ACCOUNT_TOKEN $op_service_account

COPY ./ /root/.local/share/chezmoi
RUN pacman -Sy --noconfirm neovim chezmoi git curl rust starship nodejs

RUN chezmoi init
