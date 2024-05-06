@Echo off
chcp 65001

set PATH=%programfiles(x86)%\\NSIS\\Bin;%PATH%

if not exist "out" mkdir "out"

makensis normphysadmin.nsi
timeout 1000

exit 0
