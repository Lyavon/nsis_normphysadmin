!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef PRAT_NSH
!define PRAT_NSH

Function PRAT_INSTALL
  SetOutPath "${ADMIN_PATH}\\PRAT"
  File /r "${SOURCE_PATH}\\PRAT\"
  CreateShortcut \
      "$DESKTOP\\04_PRAT.lnk" \
      "$OUTDIR\\PRAT_START.exe" \
      "-fullscreen" \
      "$OUTDIR\\BP.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "PRAT"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro PRAT_REMOVE un
Function ${un}PRAT_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "PRAT"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "PRAT_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\PRAT"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\04_PRAT.lnk"

    StrCpy $R0 "PRAT"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "PRAT" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro PRAT_REMOVE ""
!insertmacro PRAT_REMOVE "un."

Function PRAT_UPDATE
FunctionEnd

!insertmacro createInstallSection PRAT
!insertmacro createUninstallSection PRAT

!endif
