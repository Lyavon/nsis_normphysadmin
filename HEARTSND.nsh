!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef HEARTSND_NSH
!define HEARTSND_NSH

Function HEARTSND_INSTALL
  SetOutPath "${ADMIN_PATH}\\HEARTSND"
  File /r "${SOURCE_PATH}\\HEARTSND\"
  CreateShortcut \
      "$DESKTOP\\07_Heart_Sounds.lnk" \
      "$OUTDIR\\HRTSND32.exe" \
      "" \
      "$OUTDIR\\HEARTSND.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "HEARTSND"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro HEARTSND_REMOVE un
Function ${un}HEARTSND_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "HEARTSND"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "HRTSND32.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\HEARTSND"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\07_Heart_Sounds.lnk"

    StrCpy $R0 "HEARTSND"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "HEARTSND" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro HEARTSND_REMOVE ""
!insertmacro HEARTSND_REMOVE "un."

Function HEARTSND_UPDATE
FunctionEnd

!insertmacro createInstallSection HEARTSND
!insertmacro createUninstallSection HEARTSND

!endif
