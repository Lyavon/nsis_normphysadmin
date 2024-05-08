!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef TWITCH_NSH
!define TWITCH_NSH

Function TWITCH_INSTALL
  SetOutPath "${ADMIN_PATH}\\TWITCH"
  File /r "${SOURCE_PATH}\\TWITCH\"
  CreateShortcut \
      "$DESKTOP\\03_TWITCH.lnk" \
      "$OUTDIR\\TWITCH_START.exe" \
      "-fullscreen" \
      "$OUTDIR\\twitch1.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "TWITCH"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro TWITCH_REMOVE un
Function ${un}TWITCH_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "TWITCH"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "TWITCH_START.exe"
    Call ${un}killProcess

    RMDIR /r "${ADMIN_PATH}\\TWITCH"
    Delete "$DESKTOP\\03_TWITCH.lnk"

    StrCpy $R0 "TWITCH"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "TWITCH" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro TWITCH_REMOVE ""
!insertmacro TWITCH_REMOVE "un."

Function TWITCH_UPDATE
FunctionEnd

!insertmacro createInstallSection TWITCH
!insertmacro createUninstallSection TWITCH

!endif
