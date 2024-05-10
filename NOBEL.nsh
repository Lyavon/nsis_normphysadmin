!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef NOBEL_NSH
!define NOBEL_NSH

Function NOBEL_INSTALL
  SetOutPath "${ADMIN_PATH}\\NOBEL"
  File /r "${SOURCE_PATH}\\NOBEL\"
  CreateShortcut \
      "$SMSTARTUP\\NOBEL.lnk" \
      "$OUTDIR\\NOBEL_START.exe"
  Exec '"$OUTDIR\\NOBEL_START.exe"'
  CreateShortcut \
      "$DESKTOP\\${NOBEL_LINK_NAME_1}.lnk" \
      "http://localhost:1025/"

  Push $R0
  Push $R1
  StrCpy $R0 "NOBEL"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro NOBEL_REMOVE un
Function ${un}NOBEL_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "NOBEL"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "NOBEL_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\NOBEL"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\${NOBEL_LINK_NAME_1}.lnk"
    Delete "$SMSTARTUP\\NOBEL.lnk"

    StrCpy $R0 "NOBEL"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "NOBEL" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro NOBEL_REMOVE ""
!insertmacro NOBEL_REMOVE "un."

Function NOBEL_UPDATE
FunctionEnd

!insertmacro createInstallSection NOBEL
!insertmacro createUninstallSection NOBEL

!endif
