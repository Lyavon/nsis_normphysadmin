!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef BreathCycle_NSH
!define BreathCycle_NSH

Function BreathCycle_INSTALL
  SetOutPath "${ADMIN_PATH}\\BreathCycle"
  File /r "${SOURCE_PATH}\\BreathCycle\"
  CreateShortcut \
      "$DESKTOP\\${BreathCycle_LINK_NAME_1}.lnk" \
      "$OUTDIR\\BreathCycle.ppsx" \
      "" \
      "$OUTDIR\\BreathCycle.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "BreathCycle"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro BreathCycle_REMOVE un
Function ${un}BreathCycle_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "BreathCycle"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    RMDIR /r "${ADMIN_PATH}\\BreathCycle"
    Delete "$DESKTOP\\${BreathCycle_LINK_NAME_1}.lnk"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "BreathCycle" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro BreathCycle_REMOVE ""
!insertmacro BreathCycle_REMOVE "un."

Function BreathCycle_UPDATE
FunctionEnd

!insertmacro createInstallSection BreathCycle
!insertmacro createUninstallSection BreathCycle

!endif
