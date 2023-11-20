

As always, WSL makes it necessary to do these little things to get things working the way that we want so in order to get it all ready is the ability to work through the clipboard integration, allowing the work to be done through our terminal when needed

``` bash
#!/bin/sh

if command -v win32yank.exe >/dev/null 2>/dev/null; then
    win32yank.exe -o --lf
else
    powershell.exe Get-Clipboard | tr -d '\r' | sed -z '$ s/\n$//'
fi
```
1. First, we check to see if the very good win32yank executible is available 
2. If so, we paste using the unix style of new-line returns using the `lf` flags
3. else, we check that powershell is available and use the OOTB Get-Clipboard command
