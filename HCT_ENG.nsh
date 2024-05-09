!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef HCT_ENG_NSH
!define HCT_ENG_NSH

Function HCT_ENG_INSTALL
  SetOutPath "${ADMIN_PATH}\\HCT_ENG"
  File /r "${SOURCE_PATH}\\HCT_ENG\"
  CreateShortcut \
      "$DESKTOP\\12_Hematocrit.lnk" \
      "$OUTDIR\\HCT_ENG_START.exe" \
      "startpage.swf" \
      "$OUTDIR\\HCT.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "HCT_ENG"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro HCT_ENG_REMOVE un
Function ${un}HCT_ENG_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "HCT_ENG"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "HCT_ENG_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\HCT_ENG"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\12_Hematocrit.lnk"

    StrCpy $R0 "HCT_ENG"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "HCT_ENG" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro HCT_ENG_REMOVE ""
!insertmacro HCT_ENG_REMOVE "un."

Function HCT_ENG_UPDATE
FunctionEnd

!insertmacro createInstallSection HCT_ENG
!insertmacro createUninstallSection HCT_ENG

!endif
