!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef HCT_RUS_NSH
!define HCT_RUS_NSH

Function HCT_RUS_INSTALL
  SetOutPath "${ADMIN_PATH}\\HCT_RUS"
  File /r "${SOURCE_PATH}\\HCT_RUS\"
  CreateShortcut \
      "$DESKTOP\\${HCT_RUS_LINK_NAME_1}.lnk" \
      "$OUTDIR\\HCT_RUS_START.exe" \
      "startpage.swf" \
      "$OUTDIR\\HCT.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "HCT_RUS"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro HCT_RUS_REMOVE un
Function ${un}HCT_RUS_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "HCT_RUS"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "HCT_RUS_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\HCT_RUS"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\${HCT_RUS_LINK_NAME_1}.lnk"

    StrCpy $R0 "HCT_RUS"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "HCT_RUS" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro HCT_RUS_REMOVE ""
!insertmacro HCT_RUS_REMOVE "un."

Function HCT_RUS_UPDATE
FunctionEnd

!insertmacro createInstallSection HCT_RUS
!insertmacro createUninstallSection HCT_RUS

!endif
