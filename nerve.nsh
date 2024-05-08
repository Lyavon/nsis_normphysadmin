!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef NERVE_NSH
!define NERVE_NSH

Function NERVE_INSTALL
  SetOutPath "${ADMIN_PATH}\\NERVE"
  File /r "${SOURCE_PATH}\\NERVE\"
  CreateShortcut \
      "$DESKTOP\\NERVE.lnk" \
      "$OUTDIR\\run.bat" \
      "" \
      ""

  Push $R0
  Push $R1
  StrCpy $R0 "NERVE"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro NERVE_REMOVE un
Function ${un}NERVE_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "NERVE"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    RMDIR /r "${ADMIN_PATH}\\NERVE"
    Delete "$DESKTOP\\NERVE.lnk"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "NERVE" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro NERVE_REMOVE ""
!insertmacro NERVE_REMOVE "un."

Function NERVE_UPDATE
FunctionEnd

!insertmacro createInstallSection NERVE
!insertmacro createUninstallSection NERVE

!endif
