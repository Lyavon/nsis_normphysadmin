!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef PHYSIOL2_NSH
!define PHYSIOL2_NSH

Function PHYSIOL2_INSTALL
  SetOutPath "${ADMIN_PATH}\\PHYSIOL2"
  File /r "${SOURCE_PATH}\\PHYSIOL2\"
  CreateShortcut \
      "$DESKTOP\\01_PHYSIOL2.lnk" \
      "$OUTDIR\\PHYSIOL2_START.exe" \
      "-fullscreen" \
      "$OUTDIR\\Physiol2.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "PHYSIOL2"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro PHYSIOL2_REMOVE un
Function ${un}PHYSIOL2_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "PHYSIOL2"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "PHYSIOL2_START.exe"
    Call ${un}killProcess

    RMDIR /r "${ADMIN_PATH}\\PHYSIOL2"
    Delete "$DESKTOP\\01_PHYSIOL2.lnk"

    StrCpy $R0 "PHYSIOL2"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "PHYSIOL2" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro PHYSIOL2_REMOVE ""
!insertmacro PHYSIOL2_REMOVE "un."

Function PHYSIOL2_UPDATE
FunctionEnd

!insertmacro createInstallSection PHYSIOL2
!insertmacro createUninstallSection PHYSIOL2

!endif
