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
      "$OUTDIR\\run.bat" \
      "" \
      "$OUTDIR\\Ico_GIT.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "FINK"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 ${FINK_VERSION}
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
    RMDIR /r "${ADMIN_PATH}\\FINK"
    Delete "$DESKTOP\\16_FINK.lnk"
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
