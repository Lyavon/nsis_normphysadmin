!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef EYE_TESTS_NSH
!define EYE_TESTS_NSH

Function EYE_TESTS_INSTALL
  SetOutPath "${ADMIN_PATH}\\EYE_TESTS"
  File /r "${SOURCE_PATH}\\EYE_TESTS\"
  CreateShortcut \
      "$DESKTOP\\05_EyeTests.lnk" \
      "$OUTDIR\\EYE_TESTS_START.exe" \
      "-fullscreen" \
      "$OUTDIR\\Lines2.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "EYE_TESTS"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro EYE_TESTS_REMOVE un
Function ${un}EYE_TESTS_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "EYE_TESTS"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "EYE_TESTS_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\EYE_TESTS"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\05_EyeTests.lnk"

    StrCpy $R0 "EYE_TESTS"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "EYE_TESTS" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro EYE_TESTS_REMOVE ""
!insertmacro EYE_TESTS_REMOVE "un."

Function EYE_TESTS_UPDATE
FunctionEnd

!insertmacro createInstallSection EYE_TESTS
!insertmacro createUninstallSection EYE_TESTS

!endif
