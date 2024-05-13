!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef IP_10_NSH
!define IP_10_NSH

Function IP_10_INSTALL
  ${IfNot} ${FileExists} "C:\\Windows\\SysWOW64\\Macromed\\Shockwave 8\\UNWISE.exe"
  ${AndIfNot} ${FileExists} "C:\\Windows\\System32\\Macromed\\Shockwave 8\\UNWISE.exe"
    SetOutPath "$TEMP"
    File "${SOURCE_PATH}\\IP_10\\shockwave.exe"
    ExecWait "shockwave.exe"
    Delete "shockwave.exe"
  ${EndIf}
  SetOutPath "${ADMIN_PATH}\\IP_10"
  File /r "${SOURCE_PATH}\\IP_10\\IP_10\"
  CreateShortcut \
      "$SMSTARTUP\\IP_10.lnk" \
      "$OUTDIR\\IP_10_START.exe"
  Exec '"$OUTDIR\\IP_10_START.exe"'
  CreateShortcut \
      "$DESKTOP\\15_IP.lnk" \
      "http://localhost:1032/" \
      "" \
      "$OUTDIR\\IP.ico"
   MessageBox \
       MB_OK \
       "Internet Explorer is required for IP-10.$\r$\nIt can be enabled in:$\r$\nControl panel -> Windows features"

  Push $R0
  Push $R1
  StrCpy $R0 "IP_10"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro IP_10_REMOVE un
Function ${un}IP_10_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "IP_10"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "IP_10_START.exe"
    Call ${un}killProcess

    ${If} ${FileExists} "C:\\Windows\\SysWOW64\\Macromed\\Shockwave 8\\UNWISE.exe"
      ExecWait "C:\\Windows\\SysWOW64\\Macromed\\Shockwave 8\\UNWISE.exe"
    ${ElseIf} ${FileExists} "C:\\Windows\\System32\\Macromed\\Shockwave 8\\UNWISE.exe"
      ExecWait "C:\\Windows\\System32\\Macromed\\Shockwave 8\\UNWISE.exe"
    ${Else}
    ${EndIf}

    StrCpy $R0 "${ADMIN_PATH}\\IP_10"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\15_IP.lnk"
    Delete "$SMSTARTUP\\IP_10.lnk"

    StrCpy $R0 "IP_10"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "IP_10" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro IP_10_REMOVE ""
!insertmacro IP_10_REMOVE "un."

Function IP_10_UPDATE
FunctionEnd

!insertmacro createInstallSection IP_10
!insertmacro createUninstallSection IP_10

!endif
