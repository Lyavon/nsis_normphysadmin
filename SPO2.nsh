!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef SPO2_NSH
!define SPO2_NSH

Function SPO2_INSTALL
  Push $R0
  Push $R1

  SetOutPath "$TEMP"
  File "${SOURCE_PATH}\\SPO2\\vcredist_x86.exe"
  ExecWait '"$TEMP\\vcredist_x86.exe" /Q'
  Delete "$TEMP\\vcredist_x86"

  SetOutPath "$TEMP\\VCP"
  File /r "${SOURCE_PATH}\\SPO2\\CP210x_VCP\"
  ExecWait "installslabvcp.bat"
  SetOutPath "$TEMP"
  StrCpy $R0 "$TEMP\\VCP"
  Call removeDirectory
  
  SetOutPath "${ADMIN_PATH}\\SPO2"
  File /r "${SOURCE_PATH}\\SPO2\\SPO2\"
  ExecWait 'regSvr32 "$OUTDIR\\50KReview\\Step\\MSCHRT20.OCX"'
  CreateShortcut \
      "$DESKTOP\\28_SpO2_Assistant.lnk" \
      "$OUTDIR\\SpO2.exe" \
      "" \
      "$OUTDIR\\Ico_blood.ico"

  StrCpy $R0 "SPO2"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro SPO2_REMOVE un
Function ${un}SPO2_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "SPO2"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "SpO2.exe"
    Call ${un}killProcess

    ExecWait "MsiExec.exe /X{7299052b-02a4-4627-81f2-1818da5d550d} /quiet /qn"
    ExecWait 'regSvr32 /u "${ADMIN_PATH}\\SPO2\\50KReview\\Step\\MSCHRT20.OCX"'

    SetOutPath "$TEMP"
    File "${SOURCE_PATH}\\SPO2\\CP210x_VCP\\deleteslabvcp.bat"
    ExecWait "$OUTDIR\\deleteslabvcp.bat"
    Delete "$OUTDIR\\deleteslabvcp.bat"

    StrCpy $R0 "${ADMIN_PATH}\\SPO2"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\28_SpO2_Assistant.lnk"

    StrCpy $R0 "SPO2"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "SPO2" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro SPO2_REMOVE ""
!insertmacro SPO2_REMOVE "un."

Function SPO2_UPDATE
FunctionEnd

!insertmacro createInstallSection SPO2
!insertmacro createUninstallSection SPO2

!endif
