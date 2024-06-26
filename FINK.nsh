!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef FINK_NSH
!define FINK_NSH

Function FINK_INSTALL
  SetOutPath "${ADMIN_PATH}\\FINK"
  File /r "${SOURCE_PATH}\\FINK\"
  CreateShortcut \
      "$DESKTOP\\16_FINK.lnk" \
      "$OUTDIR\\FINK_START.exe" \
      "-fullscreen" \
      "$OUTDIR\\Ico_GIT.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "FINK"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro FINK_REMOVE un
Function ${un}FINK_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "FINK"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "FINK_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\FINK"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\16_FINK.lnk"

    StrCpy $R0 "FINK"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "FINK" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro FINK_REMOVE ""
!insertmacro FINK_REMOVE "un."

Function FINK_UPDATE
FunctionEnd

!insertmacro createInstallSection FINK
!insertmacro createUninstallSection FINK

!endif
