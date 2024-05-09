!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef HEALTH_WAY_NSH
!define HEALTH_WAY_NSH

Function HEALTH_WAY_INSTALL
  SetOutPath "${ADMIN_PATH}\\HEALTH_WAY"
  File /r "${SOURCE_PATH}\\HEALTH_WAY\"
  CreateShortcut \
      "$DESKTOP\\${HEALTH_WAY_LINK_NAME_1}.lnk" \
      "$OUTDIR\\Way.ppsx" \
      "" \
      "$OUTDIR\\Run1.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "HEALTH_WAY"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro HEALTH_WAY_REMOVE un
Function ${un}HEALTH_WAY_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "HEALTH_WAY"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "${ADMIN_PATH}\\HEALTH_WAY"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\${HEALTH_WAY_LINK_NAME_1}.lnk"

    StrCpy $R0 "HEALTH_WAY"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "HEALTH_WAY" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro HEALTH_WAY_REMOVE ""
!insertmacro HEALTH_WAY_REMOVE "un."

Function HEALTH_WAY_UPDATE
FunctionEnd

!insertmacro createInstallSection HEALTH_WAY
!insertmacro createUninstallSection HEALTH_WAY

!endif
