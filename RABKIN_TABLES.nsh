!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef RABKIN_TABLES_NSH
!define RABKIN_TABLES_NSH

Function RABKIN_TABLES_INSTALL
  SetOutPath "${ADMIN_PATH}\\RABKIN_TABLES"
  File /r "${SOURCE_PATH}\\RABKIN_TABLES\"
  CreateShortcut \
      "$DESKTOP\\${RABKIN_TABLES_LINK_NAME_1}.lnk" \
      "$OUTDIR\\RABKIN_TABLES.pps" \
      "" \
      "$OUTDIR\\RABKIN_TABLES.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "RABKIN_TABLES"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro RABKIN_TABLES_REMOVE un
Function ${un}RABKIN_TABLES_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "RABKIN_TABLES"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "${ADMIN_PATH}\\RABKIN_TABLES"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\${RABKIN_TABLES_LINK_NAME_1}.lnk"

    StrCpy $R0 "RABKIN_TABLES"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "RABKIN_TABLES" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro RABKIN_TABLES_REMOVE ""
!insertmacro RABKIN_TABLES_REMOVE "un."

Function RABKIN_TABLES_UPDATE
FunctionEnd

!insertmacro createInstallSection RABKIN_TABLES
!insertmacro createUninstallSection RABKIN_TABLES

!endif
