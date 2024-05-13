!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef ATLAS_NSH
!define ATLAS_NSH

Function ATLAS_INSTALL
  SetOutPath "${ADMIN_PATH}\\ATLAS"
  File /r "${SOURCE_PATH}\\ATLAS\"

  SetOutPath "$TEMP"
  File "${SOURCE_PATH}\\7z.exe"
  File "${SOURCE_PATH}\\7z.dll"
  ExecWait '"7z.exe" x -o"${ADMIN_PATH}\\ATLAS\\www" "$EXEDIR\\ATLAS.zip"'
  Delete "$OUTDIR\\7zip.exe"
  Delete "$OUTDIR\\7zip.dll"

  SetOutPath "${ADMIN_PATH}\\ATLAS"
  CreateShortcut \
      "$SMSTARTUP\\ATLAS.lnk" \
      "$OUTDIR\\ATLAS_START.exe"
  Exec '"$OUTDIR\\ATLAS_START.exe"'
  CreateShortcut \
      "$DESKTOP\\${ATLAS_LINK_NAME_1}.lnk" \
      "http://localhost:1031/" \
      "" \
      "$OUTDIR\\Logo_NormPhys_ru.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "ATLAS"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro ATLAS_REMOVE un
Function ${un}ATLAS_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "ATLAS"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "ATLAS_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\ATLAS"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\${ATLAS_LINK_NAME_1}.lnk"
    Delete "$SMSTARTUP\\ATLAS.lnk"

    StrCpy $R0 "ATLAS"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "ATLAS" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro ATLAS_REMOVE ""
!insertmacro ATLAS_REMOVE "un."

Function ATLAS_UPDATE
FunctionEnd

!insertmacro createInstallSection ATLAS
!insertmacro createUninstallSection ATLAS

!endif
