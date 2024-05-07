!include ".\constants_ansi.nsh"
!include ".\constants_unicode.nsh"

!ifndef REGISTRY_NSH
!define REGISTRY_NSH

; Query application value from registry.
;
; Parameters:
; $R0 - App name.
; $R1 - String name.
;
; Result: Value / "" on stack.
Function regString
  Push $R0
  ReadRegStr $R0 ${ADMIN_REGISTRY_ROOT} "${ADMIN_REGISTRY_PATH}\$R0" "$R1" 
  Exch $R0
FunctionEnd

; Set application value in registry.
;
; Parameters:
; $R0 - App name.
; $R1 - String name.
; $R2 - String.
Function setRegString
  WriteRegStr ${ADMIN_REGISTRY_ROOT} "${ADMIN_REGISTRY_PATH}\$R0" $R1 $R2
FunctionEnd

; Query application status from registry.
;
; Parameters:
; $R0 - App name
;
; Result: Status / "" on stack.
Function regStatus
  Push $R1
  StrCpy $R1 "Status"
  Call regString
  Exch
  Pop $R1
FunctionEnd

; Set application status in registry.
;
; Parameters:
; $R0 - App name
; $R1 - App status
Function setRegStatus
  ${If} $R1 != ""
    Push $R2
    StrCpy $R2 $R1
    StrCpy $R1 "Status"
    Call setRegString
    StrCpy $R1 $R2
    Pop $R2
  ${Else}
    DeleteRegKey ${ADMIN_REGISTRY_ROOT} "${ADMIN_REGISTRY_PATH}\$R0"
  ${EndIf}
FunctionEnd

; Query application version from registry.
;
; Parameters:
; $R0 - App name
;
; Result: Version / "" on stack.
Function regVersion
  Push $R1
  StrCpy $R1 "Version"
  Call regString
  Exch
  Pop $R1
FunctionEnd

; Set application version in registry.
;
; Parameters:
; $R0 - App name
; $R1 - App version
Function setRegVersion
  Push $R2
  StrCpy $R2 $R1
  StrCpy $R1 "Version"
  Call setRegString
  StrCpy $R1 $R2
  Pop $R2
FunctionEnd

!endif
