; constants_ansi.nsh contains global constants that define how installer looks
; and behaves (version, icons, colors, registry etc) in ANSI.

!ifndef CONSTANTS_ANSI_NSH
!define CONSTANTS_ANSI_NSH

!define ADMIN_VERSION 1
!define ADMIN_REGISTRY_ROOT HKLM
!define ADMIN_REGISTRY_PATH "Software\NormPhysAdmin"

!define MUI_INSTFILESPAGE_COLORS "DDDDDD 222222"
!define MUI_ICON "icon.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header_icon.bmp"

!endif
