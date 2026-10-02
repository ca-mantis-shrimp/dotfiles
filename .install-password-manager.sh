!/bin/sh

# Pulled from https://developer.1password.com/docs/cli/get-started/

# exit immediately if password-manager-binary is already in $PATH
type op >/dev/null 2>&1 && exit

case "$(uname -s)" in
	Alpine)
		echo https://downloads.1password.com/linux/alpinelinux/stable/ >> /etc/apk/repositories
		wget https://downloads.1password.com/linux/keys/alpinelinux/support@1password.com-61ddfc31.rsa.pub -P /etc/apk/keys
		apk update && apk add 1password-cli
		;;
	Ubuntu)
		curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
			sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
			echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
			sudo tee /etc/apt/sources.list.d/1password.list && \
			sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/ && \
			curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
			sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
			sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 && \
			curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
			sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg && \
			sudo apt update && sudo apt install 1password-cli
					;;
				Linux)
					ARCH="<choose between 386/amd64/arm/arm64>" && \
						wget "https://cache.agilebits.com/dist/1P/op2/pkg/v2.30.3/op_linux_${ARCH}_v2.30.3.zip" -O op.zip && \
						unzip -d op op.zip && \
						sudo mv op/op /usr/local/bin/ && \
						rm -r op.zip op && \
						sudo groupadd -f onepassword-cli && \
						sudo chgrp onepassword-cli /usr/local/bin/op && \
						sudo chmod g+s /usr/local/bin/op
											*)
											echo "unsupported OS"
											exit 1
											;;
									esac
