!include ".\constants.nsh"
!include ".\utils_unicode.nsh"
!include ".\registry.nsh"

!ifndef UTILS_NSH
!define UTILS_NSH

!macro createInstallSection internalName
Section ${internalName}
  Push $R0
  Push $R1

  StrCpy $R0 ${internalName}
  Call regStatus
  Pop $R1

  ${If} $R1 == "install"
    Call ${internalName}_INSTALL
  ${ElseIf} $R1 == "remove"
    Call ${internalName}_REMOVE
  ${ElseIf} $R1 == "update"
    Call ${internalName}_UPDATE
  ${EndIf}

  Pop $R1
  Pop $R0
SectionEnd
!macroend

!macro createUninstallSection internalName
Section un.${internalName}
  Push $R0
  Push $R1

  StrCpy $R0 ${internalName}
  Call un.regStatus
  Pop $R1
  ${If} $R1 == "remove"
    Call un.${internalName}_REMOVE
  ${EndIf}

  Pop $R1
  Pop $R0
SectionEnd
!macroend

; Kill process by its name.
;
; Parameters: 
; $R0 - Process name.
!macro killProcess un
Function ${un}killProcess
  ExecWait '"C:\Windows\System32\taskkill.exe" /IM $R0 /F /T'
  Sleep 300
FunctionEnd
!macroend
!insertmacro killProcess ""
!insertmacro killProcess "un."

; Delete recursively either now or on reboot.
;
; Parameters:
; $R0 - Full path to directory.
!macro removeDirectory un
Function ${un}removeDirectory
  ClearErrors
  RMDir /r "$R0"
  ${IF} ${Errors}
    RMDir /r /REBOOTOK "$R0"
  ${EndIf}
FunctionEnd
!macroend
!insertmacro removeDirectory ""
!insertmacro removeDirectory "un."

!endif
