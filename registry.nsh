!include ".\constants.nsh"

!ifndef REGISTRY_NSH
!define REGISTRY_NSH

; Delete application subkey from registry.
;
; Parameters:
; $R0 - App name.
!macro regDelete un
Function ${un}regDelete
    MessageBox MB_OK "regDelete: ${ADMIN_REGISTRY_ROOT} ${ADMIN_REGISTRY_PATH}\$R0"
    DeleteRegKey ${ADMIN_REGISTRY_ROOT} "${ADMIN_REGISTRY_PATH}\$R0"
FunctionEnd
!macroend
!insertmacro regDelete ""
!insertmacro regDelete "un."

; Query application value from registry.
;
; Parameters:
; $R0 - App name.
; $R1 - String name.
;
; Result: Value / "" on stack.
!macro regString un
Function ${un}regString
  Push $R0
  ReadRegStr $R0 ${ADMIN_REGISTRY_ROOT} "${ADMIN_REGISTRY_PATH}\$R0" "$R1" 
  Exch $R0
FunctionEnd
!macroend
!insertmacro regString ""
!insertmacro regString "un."

; Set application value in registry.
;
; Parameters:
; $R0 - App name.
; $R1 - String name.
; $R2 - String.
!macro setRegString un
Function ${un}setRegString
  WriteRegStr ${ADMIN_REGISTRY_ROOT} "${ADMIN_REGISTRY_PATH}\$R0" $R1 $R2
FunctionEnd
!macroend
!insertmacro setRegString ""
!insertmacro setRegString "un."

; Query application status from registry.
;
; Parameters:
; $R0 - App name.
;
; Result: Status / "" on stack.
!macro regStatus un
Function ${un}regStatus
  Push $R1
  StrCpy $R1 "Status"
  Call ${un}regString
  Exch
  Pop $R1
FunctionEnd
!macroend
!insertmacro regStatus ""
!insertmacro regStatus "un."

; Set application status in registry.
;
; Parameters:
; $R0 - App name.
; $R1 - App status.
!macro setRegStatus un
Function ${un}setRegStatus
  ${If} $R1 != ""
    Push $R2
    StrCpy $R2 $R1
    StrCpy $R1 "Status"
    Call ${un}setRegString
    StrCpy $R1 $R2
    Pop $R2
  ${Else}
    Call ${un}regDelete
  ${EndIf}
FunctionEnd
!macroend
!insertmacro setRegStatus ""
!insertmacro setRegStatus "un."

; Query application version from registry.
;
; Parameters:
; $R0 - App name.
;
; Result: Version / "" on stack.
!macro regVersion un
Function ${un}regVersion
  Push $R1
  StrCpy $R1 "Version"
  Call ${un}regString
  Exch
  Pop $R1
FunctionEnd
!macroend
!insertmacro regVersion ""
!insertmacro regVersion "un."

; Set application version in registry.
;
; Parameters:
; $R0 - App name.
; $R1 - App version.
!macro setRegVersion un
Function ${un}setRegVersion
  Push $R2
  StrCpy $R2 $R1
  StrCpy $R1 "Version"
  Call ${un}setRegString
  StrCpy $R1 $R2
  Pop $R2
FunctionEnd
!macroend
!insertmacro setRegVersion ""
!insertmacro setRegVersion "un."

!endif
