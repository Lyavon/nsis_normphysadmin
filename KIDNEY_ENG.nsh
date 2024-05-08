!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef KIDNEY_ENG_NSH
!define KIDNEY_ENG_NSH

Function KIDNEY_ENG_INSTALL
  SetOutPath "${ADMIN_PATH}\\KIDNEY_ENG"
  File /r "${SOURCE_PATH}\\KIDNEY_ENG\"
  CreateShortcut \
      "$DESKTOP\\18_Kidney.lnk" \
      "$OUTDIR\\KIDNEY_ENG_START.exe" \
      "-fullscreen" \
      "$OUTDIR\\Kidney.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "KIDNEY_ENG"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro KIDNEY_ENG_REMOVE un
Function ${un}KIDNEY_ENG_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "KIDNEY_ENG"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "KIDNEY_ENG_START.exe"
    Call ${un}killProcess

    RMDIR /r "${ADMIN_PATH}\\KIDNEY_ENG"
    Delete "$DESKTOP\\18_Kidney.lnk"

    StrCpy $R0 "KIDNEY_ENG"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "KIDNEY_ENG" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro KIDNEY_ENG_REMOVE ""
!insertmacro KIDNEY_ENG_REMOVE "un."

Function KIDNEY_ENG_UPDATE
FunctionEnd

!insertmacro createInstallSection KIDNEY_ENG
!insertmacro createUninstallSection KIDNEY_ENG

!endif
