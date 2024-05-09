!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef MECINHEM_NSH
!define MECINHEM_NSH

Function MECINHEM_INSTALL
  Push $R0
  Push $R1

  SetOutPath "${ADMIN_PATH}\\MECINHEM"
  File /r "${SOURCE_PATH}\\MECINHEM\"
  CreateShortcut \
      "$DESKTOP\\Mechanisms_in_hematology.lnk" \
      "$OUTDIR\\MECINHEM.exe" \
      "" \
      ""

  StrCpy $R0 "MECINHEM"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro MECINHEM_REMOVE un
Function ${un}MECINHEM_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "MECINHEM"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "MECINHEM.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\MECINHEM"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\Mechanisms_in_hematology.lnk"

    StrCpy $R0 "MECINHEM"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "MECINHEM" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro MECINHEM_REMOVE ""
!insertmacro MECINHEM_REMOVE "un."

Function MECINHEM_UPDATE
FunctionEnd

!insertmacro createInstallSection MECINHEM
!insertmacro createUninstallSection MECINHEM

!endif
