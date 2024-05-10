!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef HAEMODYNAMICS_NSH
!define HAEMODYNAMICS_NSH

Function HAEMODYNAMICS_INSTALL
  SetOutPath "${ADMIN_PATH}\\HAEMODYNAMICS"
  File /r ".\\soft\\HAEMODYNAMICS\"
  CreateShortcut \
      "$SMSTARTUP\\HAEMODYNAMICS.lnk" \
      "$OUTDIR\\HAEMODYNAMICS_START.exe"
  Exec '"$OUTDIR\\HAEMODYNAMICS_START.exe"'
  CreateShortcut \
      "$DESKTOP\\${HAEMODYNAMICS_LINK_NAME_1}.lnk" \
      "http://localhost:1028/" \
      "" \
      "$OUTDIR\\Icon.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "HAEMODYNAMICS"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro HAEMODYNAMICS_REMOVE un
Function ${un}HAEMODYNAMICS_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "HAEMODYNAMICS"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "HAEMODYNAMICS_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\HAEMODYNAMICS"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\${HAEMODYNAMICS_LINK_NAME_1}.lnk"
    Delete "$SMSTARTUP\\HAEMODYNAMICS.lnk"

    StrCpy $R0 "HAEMODYNAMICS"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "HAEMODYNAMICS" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro HAEMODYNAMICS_REMOVE ""
!insertmacro HAEMODYNAMICS_REMOVE "un."

Function HAEMODYNAMICS_UPDATE
FunctionEnd

!insertmacro createInstallSection HAEMODYNAMICS
!insertmacro createUninstallSection HAEMODYNAMICS

!endif
