!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef NOZDRACHEV_NSH
!define NOZDRACHEV_NSH

Function NOZDRACHEV_INSTALL
  SetOutPath "${ADMIN_PATH}\\NOZDRACHEV"
  File /r "${SOURCE_PATH}\\NOZDRACHEV\"
  CreateShortcut \
      "$SMSTARTUP\\NOZDRACHEV.lnk" \
      "$OUTDIR\\NOZDRACHEV_START.exe"
  Exec '"$OUTDIR\\NOZDRACHEV_START.exe"'
  CreateShortcut \
      "$DESKTOP\\${NOZDRACHEV_LINK_NAME_1}.lnk" \
      "http://localhost:1029/pages/frameset_book.html" \
      "" \
      "$OUTDIR\\Dept1.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "NOZDRACHEV"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro NOZDRACHEV_REMOVE un
Function ${un}NOZDRACHEV_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "NOZDRACHEV"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "NOZDRACHEV_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\NOZDRACHEV"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\${NOZDRACHEV_LINK_NAME_1}.lnk"
    Delete "$SMSTARTUP\\NOZDRACHEV.lnk"

    StrCpy $R0 "NOZDRACHEV"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "NOZDRACHEV" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro NOZDRACHEV_REMOVE ""
!insertmacro NOZDRACHEV_REMOVE "un."

Function NOZDRACHEV_UPDATE
FunctionEnd

!insertmacro createInstallSection NOZDRACHEV
!insertmacro createUninstallSection NOZDRACHEV

!endif
