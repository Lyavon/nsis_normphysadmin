; constants.nsh contains global constants that define how installer looks
; and behaves (version, icons, colors, registry etc).

!include ".\constants_unicode.nsh"

!ifndef CONSTANTS_NSH
!define CONSTANTS_NSH

!define ADMIN_VERSION 1
!define ADMIN_REGISTRY_ROOT HKLM
!define ADMIN_REGISTRY_PATH "Software\NormPhysAdmin"

!define ADMIN_PATH "$PROGRAMFILES\\NormPhysAdmin"
!define SOURCE_PATH ".\\soft"

!define MUI_INSTFILESPAGE_COLORS "DDDDDD 222222"
!define MUI_ICON "icon.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header_icon.bmp"

!define PHYSIOL2
!define PHYSIOL2_VERSION 1
!define PHYSIOL2_UI_NAME "01_PHYSIOL2"

!define NMJ
!define NMJ_VERSION 1
!define NMJ_UI_NAME "02_NMJ"

!define TWITCH
!define TWITCH_VERSION 1
!define TWITCH_UI_NAME "03_TWITCH"

!define PRAT
!define PRAT_VERSION 1
!define PRAT_UI_NAME "04_PRAT"

!endif
