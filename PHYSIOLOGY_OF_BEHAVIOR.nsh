!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef PHYSIOLOGY_OF_BEHAVIOR_NSH
!define PHYSIOLOGY_OF_BEHAVIOR_NSH

Function PHYSIOLOGY_OF_BEHAVIOR_INSTALL
  SetOutPath "${ADMIN_PATH}\\PHYSIOLOGY_OF_BEHAVIOR"
  File /r "${SOURCE_PATH}\\PHYSIOLOGY_OF_BEHAVIOR\"
  CreateShortcut \
      "$DESKTOP\\20_Supplement_to_the_Physiology_of_Behavior.lnk" \
      "$OUTDIR\\NSANIM.exe" \
      "" \
      "$OUTDIR\\Ico_brain.ico"

  Push $R0
  Push $R1
  StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro PHYSIOLOGY_OF_BEHAVIOR_REMOVE un
Function ${un}PHYSIOLOGY_OF_BEHAVIOR_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "NSANIM.exe"
    Call ${un}killProcess

    StrCpy $R0 "${ADMIN_PATH}\\PHYSIOLOGY_OF_BEHAVIOR"
    Call ${un}removeDirectory
    Delete "$DESKTOP\\20_Supplement_to_the_Physiology_of_Behavior.lnk"

    StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "PHYSIOLOGY_OF_BEHAVIOR" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro PHYSIOLOGY_OF_BEHAVIOR_REMOVE ""
!insertmacro PHYSIOLOGY_OF_BEHAVIOR_REMOVE "un."

Function PHYSIOLOGY_OF_BEHAVIOR_UPDATE
FunctionEnd

!insertmacro createInstallSection PHYSIOLOGY_OF_BEHAVIOR
!insertmacro createUninstallSection PHYSIOLOGY_OF_BEHAVIOR

!endif
