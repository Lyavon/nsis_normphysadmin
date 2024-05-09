!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef INUTRITION_NSH
!define INUTRITION_NSH

Function INUTRITION_INSTALL
  SetOutPath "${ADMIN_PATH}\\INUTRITION"
  File /r "${SOURCE_PATH}\\INUTRITION\"
  CreateShortcut \
      "$DESKTOP\\17_iNutrition.lnk" \
      "$OUTDIR\\iNutrition.exe" \
      "" \
      "$OUTDIR\\iNutrition.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "INUTRITION"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro INUTRITION_REMOVE un
Function ${un}INUTRITION_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "INUTRITION"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "iNutrition.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\INUTRITION"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\17_iNutrition.lnk"

    StrCpy $R0 "INUTRITION"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "INUTRITION" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro INUTRITION_REMOVE ""
!insertmacro INUTRITION_REMOVE "un."

Function INUTRITION_UPDATE
FunctionEnd

!insertmacro createInstallSection INUTRITION
!insertmacro createUninstallSection INUTRITION

!endif
