!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef BPRAT_NSH
!define BPRAT_NSH

Function BPRAT_INSTALL
  SetOutPath "${ADMIN_PATH}\\BPRAT"
  File /r "${SOURCE_PATH}\\BPRAT\"
  CreateShortcut \
      "$DESKTOP\\BPRAT.lnk" \
      "$OUTDIR\\BPRAT_START.exe" \
      "-fullscreen" \
      ""

  Push $R0
  Push $R1
  StrCpy $R0 "BPRAT"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro BPRAT_REMOVE un
Function ${un}BPRAT_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "BPRAT"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "BPRAT_START.exe"
    Call ${un}killProcess

    RMDIR /r "${ADMIN_PATH}\\BPRAT"
    Delete "$DESKTOP\\BPRAT.lnk"

    StrCpy $R0 "BPRAT"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "BPRAT" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro BPRAT_REMOVE ""
!insertmacro BPRAT_REMOVE "un."

Function BPRAT_UPDATE
FunctionEnd

!insertmacro createInstallSection BPRAT
!insertmacro createUninstallSection BPRAT

!endif
