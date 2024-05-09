!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef BREATH_CYCLE_NSH
!define BREATH_CYCLE_NSH

Function BREATH_CYCLE_INSTALL
  SetOutPath "${ADMIN_PATH}\\BREATH_CYCLE"
  File /r "${SOURCE_PATH}\\BREATH_CYCLE\"
  CreateShortcut \
      "$DESKTOP\\${BREATH_CYCLE_LINK_NAME_1}.lnk" \
      "$OUTDIR\\BREATH_CYCLE.ppsx" \
      "" \
      "$OUTDIR\\BREATH_CYCLE.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "BREATH_CYCLE"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro BREATH_CYCLE_REMOVE un
Function ${un}BREATH_CYCLE_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "BREATH_CYCLE"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "${ADMIN_PATH}\\BREATH_CYCLE"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\${BREATH_CYCLE_LINK_NAME_1}.lnk"

    StrCpy $R0 "BREATH_CYCLE"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "BREATH_CYCLE" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro BREATH_CYCLE_REMOVE ""
!insertmacro BREATH_CYCLE_REMOVE "un."

Function BREATH_CYCLE_UPDATE
FunctionEnd

!insertmacro createInstallSection BREATH_CYCLE
!insertmacro createUninstallSection BREATH_CYCLE

!endif
