!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef LUSHER_NSH
!define LUSHER_NSH

Function LUSHER_INSTALL
  SetOutPath "${ADMIN_PATH}\\LUSHER"
  File /r "${SOURCE_PATH}\\LUSHER\"
  CreateShortcut \
      "$DESKTOP\\${LUSHER_LINK_NAME_1}.lnk" \
      "$OUTDIR\\run.bat" \
      "" \
      "$OUTDIR\\Lusher1.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "LUSHER"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro LUSHER_REMOVE un
Function ${un}LUSHER_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "LUSHER"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    RMDIR /r "${ADMIN_PATH}\\LUSHER"
    Delete "$DESKTOP\\${LUSHER_LINK_NAME_1}.lnk"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "LUSHER" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro LUSHER_REMOVE ""
!insertmacro LUSHER_REMOVE "un."

Function LUSHER_UPDATE
FunctionEnd

!insertmacro createInstallSection LUSHER
!insertmacro createUninstallSection LUSHER

!endif
