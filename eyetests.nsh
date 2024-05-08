!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef EyeTests_NSH
!define EyeTests_NSH

Function EyeTests_INSTALL
  SetOutPath "${ADMIN_PATH}\\EyeTests"
  File /r "${SOURCE_PATH}\\EyeTests\"
  CreateShortcut \
      "$DESKTOP\\05_EyeTests.lnk" \
      "$OUTDIR\\run.bat" \
      "" \
      "$OUTDIR\\Lines2.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "EyeTests"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 ${EyeTests_VERSION}
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro EyeTests_REMOVE un
Function ${un}EyeTests_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "EyeTests"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    RMDIR /r "${ADMIN_PATH}\\EyeTests"
    Delete "$DESKTOP\\05_EyeTests.lnk"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "EyeTests" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro EyeTests_REMOVE ""
!insertmacro EyeTests_REMOVE "un."

Function EyeTests_UPDATE
FunctionEnd

!insertmacro createInstallSection EyeTests
!insertmacro createUninstallSection EyeTests

!endif
