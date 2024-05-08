!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef RabkinTables_NSH
!define RabkinTables_NSH

Function RabkinTables_INSTALL
  SetOutPath "${ADMIN_PATH}\\RabkinTables"
  File /r "${SOURCE_PATH}\\RabkinTables\"
  CreateShortcut \
      "$DESKTOP\\${RabkinTables_LINK_NAME_1}.lnk" \
      "$OUTDIR\\RabkinTables.pps" \
      "" \
      "$OUTDIR\\RabkinTables.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "RabkinTables"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro RabkinTables_REMOVE un
Function ${un}RabkinTables_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "RabkinTables"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    RMDIR /r "${ADMIN_PATH}\\RabkinTables"
    Delete "$DESKTOP\\${RabkinTables_LINK_NAME_1}.lnk"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "RabkinTables" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro RabkinTables_REMOVE ""
!insertmacro RabkinTables_REMOVE "un."

Function RabkinTables_UPDATE
FunctionEnd

!insertmacro createInstallSection RabkinTables
!insertmacro createUninstallSection RabkinTables

!endif
