!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef SOUNDS_HZ_NSH
!define SOUNDS_HZ_NSH

Function SOUNDS_HZ_INSTALL
  SetOutPath "${ADMIN_PATH}\\SOUNDS_HZ"
  File /r "${SOURCE_PATH}\\SOUNDS_HZ\"
  CreateShortcut \
      "$DESKTOP\\SoundsHz.lnk" \
      "$OUTDIR\\SoundsHz.exe" \
      "" \
      "$OUTDIR\\sin.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "SOUNDS_HZ"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro SOUNDS_HZ_REMOVE un
Function ${un}SOUNDS_HZ_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "SOUNDS_HZ"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "SoundsHz.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\SOUNDS_HZ"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\SoundsHz.lnk"

    StrCpy $R0 "SOUNDS_HZ"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "SOUNDS_HZ" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro SOUNDS_HZ_REMOVE ""
!insertmacro SOUNDS_HZ_REMOVE "un."

Function SOUNDS_HZ_UPDATE
FunctionEnd

!insertmacro createInstallSection SOUNDS_HZ
!insertmacro createUninstallSection SOUNDS_HZ

!endif
