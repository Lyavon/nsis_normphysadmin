!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef PHYSIOLOGY_NSH
!define PHYSIOLOGY_NSH

Function PHYSIOLOGY_INSTALL
  SetOutPath "${ADMIN_PATH}\\PHYSIOLOGY"
  File /r "${SOURCE_PATH}\\PHYSIOLOGY\"
  CreateShortcut \
      "$DESKTOP\\09_Physiology.lnk" \
      "$OUTDIR\\Physiology.exe" \
      "" \
      "$OUTDIR\\Physiology.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "PHYSIOLOGY"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro PHYSIOLOGY_REMOVE un
Function ${un}PHYSIOLOGY_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "PHYSIOLOGY"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "Physiology.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\PHYSIOLOGY"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\09_Physiology.lnk"

    StrCpy $R0 "PHYSIOLOGY"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "PHYSIOLOGY" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro PHYSIOLOGY_REMOVE ""
!insertmacro PHYSIOLOGY_REMOVE "un."

Function PHYSIOLOGY_UPDATE
FunctionEnd

!insertmacro createInstallSection PHYSIOLOGY
!insertmacro createUninstallSection PHYSIOLOGY

!endif
