#!/bin/sh

if command -v win32yank.exe >/dev/null 2>/dev/null; then
    win32yank.exe -o --lf
else
    powershell.exe Get-Clipboard | tr -d '\r' | sed -z '$ s/\n$//'
fi