!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef SMOKING_NSH
!define SMOKING_NSH

Function SMOKING_INSTALL
  SetOutPath "${ADMIN_PATH}\\SMOKING"
  File /r ".\\soft\\SMOKING\"
  CreateShortcut \
      "$SMSTARTUP\\SMOKING.lnk" \
      "$OUTDIR\\SMOKING_START.exe"
  Exec '"$OUTDIR\\SMOKING_START.exe"'
  CreateShortcut \
      "$DESKTOP\\${SMOKING_LINK_NAME_1}.lnk" \
      "http://localhost:1026/"

  Push $R0
  Push $R1
  StrCpy $R0 "SMOKING"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro SMOKING_REMOVE un
Function ${un}SMOKING_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "SMOKING"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "SMOKING_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\SMOKING"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\${SMOKING_LINK_NAME_1}.lnk"
    Delete "$SMSTARTUP\\SMOKING.lnk"

    StrCpy $R0 "SMOKING"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "SMOKING" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro SMOKING_REMOVE ""
!insertmacro SMOKING_REMOVE "un."

Function SMOKING_UPDATE
FunctionEnd

!insertmacro createInstallSection SMOKING
!insertmacro createUninstallSection SMOKING

!endif
