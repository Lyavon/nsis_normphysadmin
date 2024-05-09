!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef PHYSIO_EX_NSH
!define PHYSIO_EX_NSH

Function PHYSIO_EX_INSTALL
  Push $R0
  Push $R1

  SetOutPath "${ADMIN_PATH}\\PHYSIO_EX"
  File /r "${SOURCE_PATH}\\PHYSIO_EX\"
  CreateShortcut \
      "$DESKTOP\\14_PhysioEx.lnk" \
      "$OUTDIR\\PHYSIO_EX_START.exe" \
      "_files\main.swf" \
      "$OUTDIR\\icon.ico"

  StrCpy $R0 "PHYSIO_EX"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro PHYSIO_EX_REMOVE un
Function ${un}PHYSIO_EX_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "PHYSIO_EX"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "PHYSIO_EX_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\PHYSIO_EX"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\14_PhysioEx.lnk"

    StrCpy $R0 "PHYSIO_EX"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "PHYSIO_EX" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro PHYSIO_EX_REMOVE ""
!insertmacro PHYSIO_EX_REMOVE "un."

Function PHYSIO_EX_UPDATE
FunctionEnd

!insertmacro createInstallSection PHYSIO_EX
!insertmacro createUninstallSection PHYSIO_EX

!endif
