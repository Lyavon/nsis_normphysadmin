!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef KIDNEY_RUS_NSH
!define KIDNEY_RUS_NSH

Function KIDNEY_RUS_INSTALL
  SetOutPath "${ADMIN_PATH}\\KIDNEY_RUS"
  File /r "${SOURCE_PATH}\\KIDNEY_RUS\"
  CreateShortcut \
      "$DESKTOP\\${KIDNEY_RUS_LINK_NAME_1}.lnk" \
      "$OUTDIR\\run.bat" \
      "" \
      "$OUTDIR\\Kidney.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "KIDNEY_RUS"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro KIDNEY_RUS_REMOVE un
Function ${un}KIDNEY_RUS_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "KIDNEY_RUS"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    RMDIR /r "${ADMIN_PATH}\\KIDNEY_RUS"
    Delete "$DESKTOP\\${KIDNEY_RUS_LINK_NAME_1}.lnk"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "KIDNEY_RUS" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro KIDNEY_RUS_REMOVE ""
!insertmacro KIDNEY_RUS_REMOVE "un."

Function KIDNEY_RUS_UPDATE
FunctionEnd

!insertmacro createInstallSection KIDNEY_RUS
!insertmacro createUninstallSection KIDNEY_RUS

!endif
