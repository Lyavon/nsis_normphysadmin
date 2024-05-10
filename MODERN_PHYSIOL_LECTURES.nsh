!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef MODERN_PHYSIOL_LECTURES_NSH
!define MODERN_PHYSIOL_LECTURES_NSH

Function MODERN_PHYSIOL_LECTURES_INSTALL
  SetOutPath "${ADMIN_PATH}\\MODERN_PHYSIOL_LECTURES"
  File /r "${SOURCE_PATH}\\MODERN_PHYSIOL_LECTURES\"

  SetOutPath "$TEMP"
  File "${SOURCE_PATH}\\7z.exe"
  File "${SOURCE_PATH}\\7z.dll"
  ExecWait '"7z.exe" x -o"${ADMIN_PATH}\\MODERN_PHYSIOL_LECTURES\\www" "$EXEDIR\\MODERN_PHYSIOL_LECTURES.zip"'
  Delete "$OUTDIR\\7zip.exe"
  Delete "$OUTDIR\\7zip.dll"

  SetOutPath "${ADMIN_PATH}\\MODERN_PHYSIOL_LECTURES"
  CreateShortcut \
      "$SMSTARTUP\\MODERN_PHYSIOL_LECTURES.lnk" \
      "$OUTDIR\\MODERN_PHYSIOL_LECTURES_START.exe"
  Exec '"$OUTDIR\\MODERN_PHYSIOL_LECTURES_START.exe"'
  CreateShortcut \
      "$DESKTOP\\${MODERN_PHYSIOL_LECTURES_LINK_NAME_1}.lnk" \
      "http://localhost:1030/" \
      "" \
      "$OUTDIR\\Logo2.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "MODERN_PHYSIOL_LECTURES"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro MODERN_PHYSIOL_LECTURES_REMOVE un
Function ${un}MODERN_PHYSIOL_LECTURES_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "MODERN_PHYSIOL_LECTURES"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "MODERN_PHYSIOL_LECTURES_START.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\MODERN_PHYSIOL_LECTURES"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\${MODERN_PHYSIOL_LECTURES_LINK_NAME_1}.lnk"
    Delete "$SMSTARTUP\\MODERN_PHYSIOL_LECTURES.lnk"

    StrCpy $R0 "MODERN_PHYSIOL_LECTURES"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "MODERN_PHYSIOL_LECTURES" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro MODERN_PHYSIOL_LECTURES_REMOVE ""
!insertmacro MODERN_PHYSIOL_LECTURES_REMOVE "un."

Function MODERN_PHYSIOL_LECTURES_UPDATE
FunctionEnd

!insertmacro createInstallSection MODERN_PHYSIOL_LECTURES
!insertmacro createUninstallSection MODERN_PHYSIOL_LECTURES

!endif
