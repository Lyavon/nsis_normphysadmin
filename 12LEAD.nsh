!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef 12LEAD_NSH
!define 12LEAD_NSH

Function 12LEAD_INSTALL
  SetOutPath "${ADMIN_PATH}\\12LEAD"
  File /r "${SOURCE_PATH}\\12LEAD\"
  CreateShortcut \
      "$SMSTARTUP\\12LEAD.lnk" \
      "$OUTDIR\\12LEAD_START.exe"
  Exec '"$OUTDIR\\12LEAD_START.exe"'
  CreateShortcut \
      "$DESKTOP\\08_12Lead.lnk" \
      "http://localhost:1027/" \
      "" \
      "$OUTDIR\\12Lead.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "12LEAD"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro 12LEAD_REMOVE un
Function ${un}12LEAD_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "12LEAD"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "12LEAD_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\12LEAD"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\08_12Lead.lnk"
    Delete "$SMSTARTUP\\12LEAD.lnk"

    StrCpy $R0 "12LEAD"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "12LEAD" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro 12LEAD_REMOVE ""
!insertmacro 12LEAD_REMOVE "un."

Function 12LEAD_UPDATE
FunctionEnd

!insertmacro createInstallSection 12LEAD
!insertmacro createUninstallSection 12LEAD

!endif
