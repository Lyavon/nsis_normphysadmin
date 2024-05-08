!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef NMJ_NSH
!define NMJ_NSH

Function NMJ_INSTALL
  SetOutPath "${ADMIN_PATH}\\NMJ"
  File /r "${SOURCE_PATH}\\NMJ\"
  CreateShortcut \
      "$DESKTOP\\02_NMJ.lnk" \
      "$OUTDIR\\run.bat" \
      "" \
      "$OUTDIR\\Nerve2.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "NMJ"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro NMJ_REMOVE un
Function ${un}NMJ_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "NMJ"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    RMDIR /r "${ADMIN_PATH}\\NMJ"
    Delete "$DESKTOP\\02_NMJ.lnk"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "NMJ" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro NMJ_REMOVE ""
!insertmacro NMJ_REMOVE "un."

Function NMJ_UPDATE
FunctionEnd

!insertmacro createInstallSection NMJ
!insertmacro createUninstallSection NMJ

!endif
