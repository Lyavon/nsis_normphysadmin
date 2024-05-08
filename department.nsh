!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef DEPARTMENT_NSH
!define DEPARTMENT_NSH

Function DEPARTMENT_INSTALL
  SetOutPath "${ADMIN_PATH}\\DEPARTMENT"
  File /r "${SOURCE_PATH}\\DEPARTMENT\"
  CreateShortcut \
      "$DESKTOP\\${DEPARTMENT_LINK_NAME_1}.lnk" \
      "$OUTDIR\\${DEPARTMENT_TARGET_NAME_1}" \
      "" \
      "$OUTDIR\\Rosanov1.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "DEPARTMENT"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro DEPARTMENT_REMOVE un
Function ${un}DEPARTMENT_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "DEPARTMENT"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    RMDIR /r "${ADMIN_PATH}\\DEPARTMENT"
    Delete "$DESKTOP\\${DEPARTMENT_LINK_NAME_1}.lnk"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "DEPARTMENT" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro DEPARTMENT_REMOVE ""
!insertmacro DEPARTMENT_REMOVE "un."

Function DEPARTMENT_UPDATE
FunctionEnd

!insertmacro createInstallSection DEPARTMENT
!insertmacro createUninstallSection DEPARTMENT

!endif
