


Pyenv is to python, as nvm is to node, it allows us to finally control the python install in such a way that we can shift it around, without ever needing to puts around with the system path again.

However, since we need to place some new lines in our bash profile, it will be important that we do this BEFORE the file is loaded so we dont get an error when it tries to grab the files.

Also, we only want this running once, hence the file name:
``` bash
curl https://pyenv.run | bash

sudo apt update; sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
```
- here we are using the standard automation script that the project itself recommends
- It will download and install the program, but it wont run until you add the program itself to your path
- we also download or ensure the dependencies for building python are available and up-to-date so that we dont hit issues building python itself
