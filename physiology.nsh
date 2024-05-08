!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef Physiology_NSH
!define Physiology_NSH

Function Physiology_INSTALL
  SetOutPath "${ADMIN_PATH}\\Physiology"
  File /r "${SOURCE_PATH}\\Physiology\"
  CreateShortcut \
      "$DESKTOP\\09_Physiology.lnk" \
      "$OUTDIR\\Physiology.exe" \
      "" \
      "$OUTDIR\\Physiology.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "Physiology"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro Physiology_REMOVE un
Function ${un}Physiology_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "Physiology"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    RMDIR /r "${ADMIN_PATH}\\Physiology"
    Delete "$DESKTOP\\09_Physiology.lnk"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "Physiology" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro Physiology_REMOVE ""
!insertmacro Physiology_REMOVE "un."

Function Physiology_UPDATE
FunctionEnd

!insertmacro createInstallSection Physiology
!insertmacro createUninstallSection Physiology

!endif
