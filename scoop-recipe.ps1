Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install 7zip innounp dark sudo git
sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
~\scoop\apps\7zip\current\install-context.reg
git config --global credential.helper manager
~\scoop\apps\git\current\install-context.reg
