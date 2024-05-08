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

!endif
