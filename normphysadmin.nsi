!include ".\constants.nsh"

Name "NormPhysAdmin_${ADMIN_VERSION}"
OutFile "out\\NormPhysAdmin_${ADMIN_VERSION}.exe"
Unicode true
InstallButtonText "Apply"

RequestExecutionLevel admin
#SetCompressor /SOLID lzma

!include "MUI2.nsh"
!include "nsDialogs.nsh"
!include "LogicLib.nsh"
!include ".\registry.nsh"

!include ".\PHYSIOL2.nsh"
!include ".\NMJ.nsh"
!include ".\TWITCH.nsh"
!include ".\PRAT.nsh"
!include ".\EYE_TESTS.nsh"
!include ".\RABKIN_TABLES.nsh"

!include ".\PHYSIOLOGY.nsh"
!include ".\BREATH_CYCLE.nsh"

!include ".\FINK.nsh"

!include ".\KIDNEY_ENG.nsh"
!include ".\KIDNEY_RUS.nsh"

!include ".\LUSHER.nsh"
; !include ".\haemodynamics.nsh"
!include ".\DEPARTMENT.nsh"
!include ".\HEALTH_WAY.nsh"

!include ".\BPRAT.nsh"
!include ".\NERVE.nsh"



; $R0 - name to use
; $R1 - checkbox HWND
Function setCheckboxStateByRegistry
  Push $R2

  Call regStatus
  Pop $R2
  ${If} $R2 == "installed"
  ${OrIf} $R2 == "install"
    ${NSD_SetState} $R1 ${BST_CHECKED}
  ${Else}
    ${NSD_SetState} $R1 ${BST_UNCHECKED}
  ${EndIf}

  Pop $R2
FunctionEnd

; $R0 - name to use
Function invertRegistryValue
  Push $R1

  Call regStatus
  Pop $R1
  ${If} $R1 == "installed"
    StrCpy $R1 "remove"
  ${ElseIf} $R1 == "install"
    StrCpy $R1 ""
  ${ElseIf} $R1 == "remove"
    StrCpy $R1 "installed"
  ${Else}
    StrCpy $R1 "install"
  ${EndIf}
  Call setRegStatus

  Pop $R1
FunctionEnd


!macro createClickedCallback internalName
Function ${internalName}_Clicked
  Push $R0
  StrCpy $R0 ${internalName}
  Call invertRegistryValue
  Pop $R0
FunctionEnd
!macroend

!macro createUiBoilerplateCode internalName
Var ${internalName}_HWND
!insertmacro createClickedCallback ${internalName}
!macroend

!insertmacro createUiBoilerplateCode PHYSIOL2
!insertmacro createUiBoilerplateCode NMJ
!insertmacro createUiBoilerplateCode TWITCH
!insertmacro createUiBoilerplateCode PRAT
!insertmacro createUiBoilerplateCode EYE_TESTS
!insertmacro createUiBoilerplateCode RABKIN_TABLES
; !insertmacro createUiBoilerplateCode HEARTSND
; !insertmacro createUiBoilerplateCode 12Lead
!insertmacro createUiBoilerplateCode PHYSIOLOGY
!insertmacro createUiBoilerplateCode BREATH_CYCLE
;
; !insertmacro createUiBoilerplateCode HCT_ENG
; !insertmacro createUiBoilerplateCode HCT_RUS
; !insertmacro createUiBoilerplateCode PhysioEx
; !insertmacro createUiBoilerplateCode IP
!insertmacro createUiBoilerplateCode FINK
; !insertmacro createUiBoilerplateCode iNutrition
!insertmacro createUiBoilerplateCode KIDNEY_ENG
!insertmacro createUiBoilerplateCode KIDNEY_RUS
; !insertmacro createUiBoilerplateCode PHYSIOLOGY_OF_BEHAVIOR
!insertmacro createUiBoilerplateCode LUSHER
; !insertmacro createUiBoilerplateCode HAEMODYNAMICS
!insertmacro createUiBoilerplateCode DEPARTMENT
!insertmacro createUiBoilerplateCode HEALTH_WAY
; !insertmacro createUiBoilerplateCode Modern_Physiol_Lectures
; !insertmacro createUiBoilerplateCode Orlov_Nozdrachev
;
; !insertmacro createUiBoilerplateCode Electronic_Atlas
; !insertmacro createUiBoilerplateCode SpO2
; !insertmacro createUiBoilerplateCode SoundsHz
; !insertmacro createUiBoilerplateCode Sheffield
; !insertmacro createUiBoilerplateCode Nobel
; !insertmacro createUiBoilerplateCode Smoking
!insertmacro createUiBoilerplateCode BPRAT
!insertmacro createUiBoilerplateCode NERVE
; !insertmacro createUiBoilerplateCode MECINHEM


Var InvertButton_HWND

!macro invertHWND internalName
  Push $R0
  ${NSD_GetChecked} $${internalName}_HWND $R0
  ${If} $R0 == ${BST_CHECKED}
    ${NSD_SetState} $${internalName}_HWND ${BST_UNCHECKED}
  ${Else}
    ${NSD_SetState} $${internalName}_HWND ${BST_CHECKED}
  ${EndIf}
  StrCpy $R0 ${internalName}
  Call invertRegistryValue
  Pop $R0
!macroend

Function InvertButton_Clicked
  !insertmacro invertHWND PHYSIOL2
  !insertmacro invertHWND NMJ
  !insertmacro invertHWND TWITCH
  !insertmacro invertHWND PRAT
  !insertmacro invertHWND EYE_TESTS
  !insertmacro invertHWND RABKIN_TABLES
  ; !insertmacro invertHWND HEARTSND
  ; !insertmacro invertHWND 12Lead
  !insertmacro invertHWND PHYSIOLOGY
  !insertmacro invertHWND BREATH_CYCLE
  ;
  ; !insertmacro invertHWND HCT_ENG
  ; !insertmacro invertHWND HCT_RUS
  ; !insertmacro invertHWND PhysioEx
  ; !insertmacro invertHWND IP
  !insertmacro invertHWND FINK
  ; !insertmacro invertHWND iNutrition
  !insertmacro invertHWND KIDNEY_ENG
  !insertmacro invertHWND KIDNEY_RUS
  ; !insertmacro invertHWND PHYSIOLOGY_OF_BEHAVIOR
  !insertmacro invertHWND LUSHER
  ; !insertmacro invertHWND HAEMODYNAMICS
  !insertmacro invertHWND DEPARTMENT
  !insertmacro invertHWND HEALTH_WAY
  ; !insertmacro invertHWND Modern_Physiol_Lectures
  ; !insertmacro invertHWND Orlov_Nozdrachev
  ;
  ; !insertmacro invertHWND Electronic_Atlas
  ; !insertmacro invertHWND SpO2
  ; !insertmacro invertHWND SoundsHz
  ; !insertmacro invertHWND Sheffield
  ; !insertmacro invertHWND Nobel
  ; !insertmacro invertHWND Smoking
  !insertmacro invertHWND BPRAT
  !insertmacro invertHWND NERVE
  ; !insertmacro invertHWND MECINHEM
FunctionEnd



Page custom AdminEnter "" " Physiology Programs" /ENABLECANCEL

!macro createCheckBox x y internalName uiName
  Push $R0
  Push $R1
  ${NSD_CreateCheckBox} ${x} ${y} 33% 10u ${uiName}
  Pop $R1
  ${NSD_OnClick} $R1 ${internalName}_Clicked
  StrCpy $R0 ${internalName}
  Call setCheckboxStateByRegistry
  StrCpy $${internalName}_HWND $R1
  Pop $R1
  Pop $R0
!macroend

Function AdminEnter
  !insertmacro MUI_HEADER_TEXT "${ADMIN_HEADER_TEXT}" "${ADMIN_HEADER_SUBTEXT}"

  nsDialogs::Create 1018
  Pop $0
  ${If} $0 == error
    Abort
  ${EndIf}

  ${NSD_CreateButton} 67% 131u 33% 10u "Invert Selection"
  Pop $InvertButton_HWND
  ${NSD_OnClick} $InvertButton_HWND InvertButton_Clicked

  !insertmacro createCheckBox 0% 0u PHYSIOL2 "01_PHYSIOL2"
  !insertmacro createCheckBox 0% 11u NMJ "02_NMJ"
  !insertmacro createCheckBox 0% 21u TWITCH "03_TWITCH"
  !insertmacro createCheckBox 0% 31u PRAT "04_PRAT"
  !insertmacro createCheckBox 0% 41u EYE_TESTS "05_EyeTests"
  !insertmacro createCheckBox 0% 51u RABKIN_TABLES "06_Таблицы_Рабкина"
  ; !insertmacro createCheckBox 0% 61u HEARTSND "07_Heart_Sounds"
  ; !insertmacro createCheckBox 0% 71u 12Lead "08_12Lead"
  !insertmacro createCheckBox 0% 81u PHYSIOLOGY "09_Physiology"
  !insertmacro createCheckBox 0% 91u BREATH_CYCLE "10_Дыхательный_цикл..."
  ;
  ; !insertmacro createCheckBox 0% 111u HCT_ENG "12_Hematocrit"
  ; !insertmacro createCheckBox 0% 121u HCT_RUS "13_Гематокрит"
  ; !insertmacro createCheckBox 0% 131u PhysioEx "14_PhysioEx"
  ; !insertmacro createCheckBox 34% 0u IP "15_IP"
  !insertmacro createCheckBox 34% 11u FINK "16_FINK"
  ; !insertmacro createCheckBox 34% 21u iNutrition "17_iNutrition"
  !insertmacro createCheckBox 34% 31u KIDNEY_ENG "18_Kidney"
  !insertmacro createCheckBox 34% 41u KIDNEY_RUS "19_Почка"
  ; !insertmacro createCheckBox 34% 51u PHYSIOLOGY_OF_BEHAVIOR "20_Suppl...Behavior"
  ; !insertmacro createCheckBox 34% 61u Electronic_Atlas "21_Норм_Физиология"
  !insertmacro createCheckBox 34% 71u LUSHER "22_Тест_Люшера"
  ; !insertmacro createCheckBox 34% 81u HAEMODYNAMICS "23_Гемодинамика"
  !insertmacro createCheckBox 34% 91u DEPARTMENT "24_О_кафедре"
  !insertmacro createCheckBox 34% 101u HEALTH_WAY "25_Путь_в_страну..."
  ; !insertmacro createCheckBox 34% 111u Modern_Physiol_Lectures "26_Современный_Курс..."
  ; !insertmacro createCheckBox 34% 121u Orlov_Nozdrachev "27_Учебник_Орлова..."
  ; !insertmacro createCheckBox 34% 1311u SpO2 "28_SpO2_Assistant"
  ;
  ; !insertmacro createCheckBox 67% 61u SoundsHz "SoundsHz"
  ; !insertmacro createCheckBox 67% 71u Sheffield "Sheffield Biosciences"
  ; !insertmacro createCheckBox 67% 81u Nobel "Нобелевские лауреаты"
  ; !insertmacro createCheckBox 67% 91u Smoking "Курение"
  !insertmacro createCheckBox 67% 101u BPRAT "BPRAT"
  !insertmacro createCheckBox 67% 111u NERVE "NERVE"
  ; !insertmacro createCheckBox 67% 121u MECINHEM "Mechanisms_in_hematology"

  nsDialogs::Show
FunctionEnd



!macro shttpsRequired_doesRegistryContainIntall internalName
  StrCpy $R0 ${internalName}
  Call regStatus
  Pop $R0
  ${If} $R0 == "install"
  ${OrIf} $R0 == "installed"
    StrCpy $R1 "true"
  ${EndIf}
!macroend

; stack - "true"/ ""
Function shttpsRequired
  Push $R1
  Push $R0
  StrCpy $R0 ""

  !insertmacro shttpsRequired_doesRegistryContainIntall 12Lead
  !insertmacro shttpsRequired_doesRegistryContainIntall IP
  !insertmacro shttpsRequired_doesRegistryContainIntall HAEMODYNAMICS
  !insertmacro shttpsRequired_doesRegistryContainIntall Electronic_Atlas
  !insertmacro shttpsRequired_doesRegistryContainIntall Modern_Physiol_Lectures
  !insertmacro shttpsRequired_doesRegistryContainIntall Orlov_Nozdrachev
  !insertmacro shttpsRequired_doesRegistryContainIntall Nobel
  !insertmacro shttpsRequired_doesRegistryContainIntall Smoking

  Pop $R0
  Exch $R1
FunctionEnd

Section shttps
  Call shttpsRequired
  Pop $R0
  ${If} $R0 == "true"
    StrCpy $R0 "shttps"
    Call regStatus
    Pop $R0
    ${If} $R0 != "installed"
      SetOutPath "$PROGRAMFILES\\NormPhys\\shttps"
      File /r ".\\soft\\shttps\"
      CreateShortcut \
          "$SMSTARTUP\\shttps.lnk" \
          "$OUTDIR\\http.exe"
      StrCpy $R0 "shttps"
      StrCpy $R1 "installed"
      Call setRegStatus
      Exec "http.exe"
    ${EndIf}
  ${Else}
    StrCpy $R0 "shttps"
    Call regStatus
    Pop $R0
    ${If} $R0 != ""
      ExecWait '"C:\Windows\System32\taskkill.exe" /IM http.exe'
      SetOutPath "$PROGRAMFILES\\NormPhys"
      RMDir /r "$OUTDIR\\shttps"
      Delete "$SMSTARTUP\\shttps.lnk"
      StrCpy $R0 "shttps"
      StrCpy $R1 ""
      Call setRegStatus
    ${EndIf}
  ${EndIf}
SectionEnd
;
; Section HEARTSND
;   StrCpy $R0 "HEARTSND"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\HEARTSND"
;     File /r ".\\soft\\HEARTSND\"
;     CreateShortcut \
;         "$DESKTOP\\07_Heart_Sounds.lnk" \
;         "$OUTDIR\\HRTSND32.exe" \
;         "" \
;         "$OUTDIR\\HEARTSND.ico"
;     StrCpy $R0 "HEARTSND"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys"
;     RMDir /r "$OUTDIR\\HEARTSND"
;     Delete "$DESKTOP\\07_Heart_Sounds.lnk"
;     StrCpy $R0 "HEARTSND"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section 12Lead
;   StrCpy $R0 "12Lead"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\12Lead"
;     File /r ".\\soft\\12Lead\"
;     CreateShortcut \
;         "$DESKTOP\\08_12Lead.lnk" \
;         "http://localhost:1025/12Lead/12Lead.htm" \
;         "" \
;         "$OUTDIR\\12Lead.ico"
;     StrCpy $R0 "12Lead"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
;     RMDir /r "$OUTDIR\\12Lead"
;     Delete "$DESKTOP\\08_12Lead.lnk"
;     StrCpy $R0 "12Lead"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section HCT_ENG
;   StrCpy $R0 "HCT_ENG"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\HCT_ENG"
;     File /r ".\\soft\\HCT_ENG\"
;     CreateShortcut \
;         "$DESKTOP\\12_Hematocrit.lnk" \
;         "$OUTDIR\\SWFPlayer.exe" \
;         "startpage.swf" \
;         "$OUTDIR\\HCT.ico"
;     StrCpy $R0 "HCT_ENG"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys"
;     RMDir /r "$OUTDIR\\HCT_ENG"
;     Delete "$DESKTOP\\12_Hematocrit.lnk"
;     StrCpy $R0 "HCT_ENG"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section HCT_RUS
;   StrCpy $R0 "HCT_RUS"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\HCT_RUS"
;     File /r ".\\soft\\HCT_RUS\"
;     CreateShortcut \
;         "$DESKTOP\\13_Гематокрит.lnk" \
;         "$OUTDIR\\SWFPlayer.exe" \
;         "startpage.swf" \
;         "$OUTDIR\\HCT.ico"
;     StrCpy $R0 "HCT_RUS"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys"
;     RMDir /r "$OUTDIR\\HCT_RUS"
;     Delete "$DESKTOP\\13_Гематокрит.lnk"
;     StrCpy $R0 "HCT_RUS"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section PhysioEx
;   StrCpy $R0 "PhysioEx"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\PhysioEx"
;     File /r ".\\soft\\PhysioEx\"
;     CreateShortcut \
;         "$DESKTOP\\14_PhysioEx.lnk" \
;         "$OUTDIR\SWFPlayer.exe" \
;         "_files\main.swf" \
;         "$OUTDIR\\icon.ico"
;     StrCpy $R0 "PhysioEx"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys"
;     RMDir /r "$OUTDIR\\PhysioEx"
;     Delete "$DESKTOP\\14_PhysioEx.lnk"
;     StrCpy $R0 "PhysioEx"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section IP
;   StrCpy $R0 "IP"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     ${IfNot} ${FileExists} "C:\\Windows\\SysWOW64\\Macromed\\Shockwave 8\\UNWISE.exe"
;     ${AndIfNot} ${FileExists} "C:\\Windows\\System32\\Macromed\\Shockwave 8\\UNWISE.exe"
;       SetOutPath "$TEMP"
;       File ".\\soft\\shockwave.exe"
;       ExecWait "shockwave.exe"
;       Delete "shockwave.exe"
;     ${EndIf}
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\IP-10"
;     File /r ".\\soft\\IP-10\"
;     MessageBox MB_OK "Internet Explorer is required for IP-10.$\r$\nIt can be enabled in:$\r$\nControl panel -> Windows features"
;     CreateShortcut \
;         "$DESKTOP\\15_IP.lnk" \
;         "http://localhost:1025/IP-10/index.html" \
;         "" \
;         "$OUTDIR\\IP.ico"
;     StrCpy $R0 "IP"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     ${If} ${FileExists} "C:\\Windows\\SysWOW64\\Macromed\\Shockwave 8\\UNWISE.exe"
;       ExecWait "C:\\Windows\\SysWOW64\\Macromed\\Shockwave 8\\UNWISE.exe"
;     ${ElseIf} ${FileExists} "C:\\Windows\\System32\\Macromed\\Shockwave 8\\UNWISE.exe"
;       ExecWait "C:\\Windows\\System32\\Macromed\\Shockwave 8\\UNWISE.exe"
;     ${Else}
;     ${EndIf}
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
;     RMDir /r "$OUTDIR\\IP-10"
;     Delete "$DESKTOP\\15_IP.lnk"
;     StrCpy $R0 "IP"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section iNutrition
;   StrCpy $R0 "iNutrition"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\iNutrition\"
;     File /r ".\\soft\\iNutrition\"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\iNutrition"
;     CreateShortcut \
;         "$DESKTOP\\17_iNutrition.lnk" \
;         "$OUTDIR\\iNutrition.exe" \
;         "" \
;         "$OUTDIR\\iNutrition.ico"
;     StrCpy $R0 "iNutrition"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys"
;       ExecWait '"C:\Windows\System32\taskkill.exe" /IM iNutrition.exe'
;     RMDir /r "$OUTDIR\\iNutrition"
;     Delete "$DESKTOP\\17_iNutrition.lnk"
;     StrCpy $R0 "iNutrition"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section PHYSIOLOGY_OF_BEHAVIOR
;   StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\Physiology_of_Behavior"
;     File /r ".\\soft\\Physiology_OF_BEHAVIOR\"
;     CreateShortcut \
;         "$DESKTOP\\20_Supplement_to_the_Physiology_of_Behavior.lnk" \
;         "$OUTDIR\\NSANIM.exe" \
;         "" \
;         "$OUTDIR\\Ico_brain.ico"
;     StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys"
;     RMDir /r "$OUTDIR\\Physiology_of_Behavior"
;     Delete "$DESKTOP\\20_Supplement_to_the_Physiology_of_Behavior.lnk"
;     StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section Electronic_Atlas
;   StrCpy $R0 "Electronic_Atlas"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$TEMP"
;     File ".\\soft\\7z.exe"
;     File ".\\soft\\7z.dll"
;     ExecWait '7z.exe x -o"$PROGRAMFILES\\NormPhys\\shttps\\www\\electronic_atlas" "$EXEDIR\\electronic_atlas.zip"'
;     Delete "7zip.exe"
;     Delete "7zip.dll"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\electronic_atlas"
;     CreateShortcut \
;         "$DESKTOP\\21_Норм_Физиология.lnk" \
;         "http://localhost:1025/electronic_atlas/index.html" \
;         "" \
;         "$OUTDIR\\Logo_NormPhys_ru.ico"
;     StrCpy $R0 "Electronic_Atlas"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
;     RMDir /r "$OUTDIR\\electronic_atlas"
;     Delete "$DESKTOP\\21_Норм_Физиология.lnk"
;     StrCpy $R0 "Electronic_Atlas"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section HAEMODYNAMICS
;   StrCpy $R0 "HAEMODYNAMICS"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\Haemodynamics"
;     File /r ".\\soft\\Haemodynamics\"
;     CreateShortcut \
;         "$DESKTOP\\23_Гемодинамика.lnk" \
;         "http://localhost:1025/Haemodynamics/23_haemodynamics_start.html" \
;         "" \
;         "$OUTDIR\\Icon.ico"
;     StrCpy $R0 "HAEMODYNAMICS"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
;     RMDir /r "$OUTDIR\\HAEMODYNAMICS"
;     Delete "$DESKTOP\\23_Гемодинамика.lnk"
;     StrCpy $R0 "HAEMODYNAMICS"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
; SectionEnd
;
; Section Modern_Physiol_Lectures
;   StrCpy $R0 "Modern_Physiol_Lectures"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$TEMP"
;     File ".\\soft\\7z.exe"
;     File ".\\soft\\7z.dll"
;     ExecWait '7z.exe x -o"$PROGRAMFILES\\NormPhys\\shttps\\www\\Modern_Physiol_Lectures" "$EXEDIR\\Modern_Physiol_Lectures.zip"'
;     Delete "7zip.exe"
;     Delete "7zip.dll"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\Modern_Physiol_Lectures"
;     CreateShortcut \
;         "$DESKTOP\\26_Современный_курс_классической_физиологии.lnk" \
;         "http://localhost:1025/Modern_Physiol_Lectures/index.htm" \
;         "" \
;         "$OUTDIR\\Logo2.ico"
;     StrCpy $R0 "Modern_Physiol_Lectures"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
;     RMDir /r "$OUTDIR\\Modern_Physiol_Lectures"
;     Delete "$DESKTOP\\26_Современный_курс_классической_физиологии.lnk"
;     StrCpy $R0 "Modern_Physiol_Lectures"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section Orlov_Nozdrachev
;   StrCpy $R0 "Orlov_Nozdrachev"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\Nozdrachev"
;     File /r ".\\soft\\Nozdrachev\"
;     CreateShortcut \
;         "$DESKTOP\\27_Учебник_Орлова_и_Ноздрачева.lnk" \
;         "http://localhost:1025/Nozdrachev/pages/head.htm" \
;         "" \
;         "$OUTDIR\\Dept1.ico"
;     StrCpy $R0 "Orlov_Nozdrachev"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
;     RMDir /r "$OUTDIR\\Orlov_Nozdrachev"
;     Delete "$DESKTOP\\27_Учебник_Орлова_и_Ноздрачева.lnk"
;     StrCpy $R0 "Orlov_Nozdrachev"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section SpO2
;   StrCpy $R0 "SpO2"
;   Call regStatus
;   Pop $R0
;
;   ${If} $R0 == "install"
;     SetOutPath "$TEMP"
;     File ".\\soft\\SpO2\\vcredist_x86.exe"
;     ExecWait "$TEMP\\vcredist_x86.exe /Q"
;     Delete "$TEMP\\vcredist_x86.exe"
;     SetOutPath "$TEMP\\VCP"
;     File /r ".\\soft\\SpO2\\CP210x_VCP\"
;     ExecWait "installslabvcp.bat"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\SpO2"
;     RMDir /r "$TEMP\\VCP"
;     File /r ".\\soft\\SpO2\\SpO2\"
;     ExecWait 'regSvr32 "$OUTDIR\\50KReview\\Step\\MSCHRT20.OCX"'
;     CreateShortcut \
;         "$DESKTOP\\28_SpO2_Assistant.lnk" \
;         "$OUTDIR\\SpO2.exe" \
;         "" \
;         "$OUTDIR\\Ico_blood.ico"
;     StrCpy $R0 "SpO2"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$TEMP"
;     File ".\\soft\\SpO2\\CP210x_VCP\\deleteslabvcp.bat"
;     ExecWait "$OUTDIR\\deleteslabvcp.bat"
;     Delete "$OUTDIR\\deleteslabvcp.bat"
;     ExecWait "MsiExec.exe /X{7299052b-02a4-4627-81f2-1818da5d550d} /quiet /qn"
;     SetOutPath "$PROGRAMFILES\\NormPhys"
;     ExecWait 'regSvr32 /u "$OUTDIR\\SpO2\\50KReview\\Step\\MSCHRT20.OCX"'
;     RMDir /r "$OUTDIR\\SpO2"
;     StrCpy $R0 "SpO2"
;     StrCpy $R1 ""
;     Call setRegStatus
;     Delete "$DESKTOP\\28_SpO2_Assistant.lnk"
;   ${EndIf}
; SectionEnd
;
; Section SoundsHz
;   StrCpy $R0 "SoundsHz"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\SoundsHz"
;     File /r ".\\soft\\SoundsHz\"
;     CreateShortcut \
;         "$DESKTOP\\SoundsHz.lnk" \
;         "$OUTDIR\\SoundsHz.exe" \
;         "" \
;         "$OUTDIR\\sin.ico"
;     StrCpy $R0 "SoundsHz"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys"
;     RMDir /r "$OUTDIR\\SoundsHz"
;     Delete "$DESKTOP\\SoundsHz.lnk"
;     StrCpy $R0 "SoundsHz"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section Sheffield
;   StrCpy $R0 "Sheffield"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$DESKTOP\\Sheffield_Biosciences"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\Sheffield_Biosciences"
;     File /r ".\\soft\\Sheffield_Biosciences\"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Autonomic_Pharmacology.lnk" \
;         "$OUTDIR\\Autonomic_Pharmacology\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Blood_Coagulation.lnk" \
;         "$OUTDIR\\Blood_Coagulation\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Blood_Physiology.lnk" \
;         "$OUTDIR\\Blood_Physiology\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Cellular_Respiration.lnk" \
;         "$OUTDIR\\Cellular_Respiration\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Chest_Clinic.lnk" \
;         "$OUTDIR\\Chest_Clinic\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Circulatory_Vessels.lnk" \
;         "$OUTDIR\\Circulatory_Vessels\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Clinical_Aspects_of_Pain.lnk" \
;         "$OUTDIR\\Clinical_Aspects_of_Pain\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Epilepsy.lnk" \
;         "$OUTDIR\\Epilepsy\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Exercise_Physiology.lnk" \
;         "$OUTDIR\\Exercise_Physiology\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Experimental_Design.lnk" \
;         "$OUTDIR\\Experimental_Design\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Frog_Heart.lnk" \
;         "$OUTDIR\\Frog_Heart\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Guinea_Pig_Ileum.lnk" \
;         "$OUTDIR\\Guinea_Pig_Ileum\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Inflammation.lnk" \
;         "$OUTDIR\\Inflammation\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Insulin_Glucagon.lnk" \
;         "$OUTDIR\\Insulin_Glucagon\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Intestinal_Absorption.lnk" \
;         "$OUTDIR\\Intestinal_Absorption\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Intestinal_Motility.lnk" \
;         "$OUTDIR\\Intestinal_Motility\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Introduction_to_Endocrinology.lnk" \
;         "$OUTDIR\\Introduction_to_Endocrinology\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Langendorff_Heart.lnk" \
;         "$OUTDIR\\Langendorff_Heart\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Muscle_Physiology.lnk" \
;         "$OUTDIR\\Muscle_Physiology\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Nerve_Biophysics_Tutorials.lnk" \
;         "$OUTDIR\\Nerve_Biophysics_Tutorials\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Nerve_Physiology.lnk" \
;         "$OUTDIR\\Nerve_Physiology\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Neuromuscular_Junction.lnk" \
;         "$OUTDIR\\Neuromuscular_Junction\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Neuromuscular_Pharmacology.lnk" \
;         "$OUTDIR\\Neuromuscular_Pharmacology\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Nictitating_Membrane.lnk" \
;         "$OUTDIR\\Nictitating_Membrane\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Parathyroid_Glands.lnk" \
;         "$OUTDIR\\Parathyroid_Glands\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Rat_Blood_Pressure.lnk" \
;         "$OUTDIR\\Rat_Blood_Pressure\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Renal_Function_in_Humans.lnk" \
;         "$OUTDIR\\Renal_Function_in_Humans\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Respiratory_Pharmacology.lnk" \
;         "$OUTDIR\\Respiratory_Pharmacology\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Respiratory_Physiology.lnk" \
;         "$OUTDIR\\Respiratory_Physiology\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\The_Heart.lnk" \
;         "$OUTDIR\\The_Heart\\click_me.exe"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\Thyroid_Glands.lnk" \
;         "$OUTDIR\\Thyroid_Glands\\click_me.exe"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\Sheffield_Biosciences\\PKSIMS"
;     CreateShortcut \
;         "$DESKTOP\\Sheffield_Biosciences\\PKSIMS.lnk" \
;         "$OUTDIR\\RUN.bat"
;     StrCpy $R0 "Sheffield"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys"
;     RMDir /r "$OUTDIR\\Sheffield_Biosciences"
;     SetOutPath "$DESKTOP"
;     RMDir /r "$OUTDIR\\Sheffield_Biosciences"
;     StrCpy $R0 "Sheffield"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section Nobel
;   StrCpy $R0 "Nobel"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\Nobel"
;     File /r ".\\soft\\Nobel\"
;     CreateShortcut \
;         "$DESKTOP\\Все_нобелевские_лауреаты_по_медицине.lnk" \
;         "http://localhost:1025/Nobel/All Nobel Laureates in Medicine.htm"
;     StrCpy $R0 "Nobel"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
;     RMDir /r "$OUTDIR\\Nobel"
;     Delete "$DESKTOP\\Все_нобелевские_лауреаты_по_медицине.lnk"
;     StrCpy $R0 "Nobel"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section Smoking
;   StrCpy $R0 "Smoking"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\Smoking"
;     File /r ".\\soft\\Smoking\"
;     CreateShortcut \
;         "$DESKTOP\\Курение.lnk" \
;         "http://localhost:1025/Smoking/Содержание.htm"
;     StrCpy $R0 "Smoking"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
;     RMDir /r "$OUTDIR\\Smoking"
;     Delete "$DESKTOP\\Курение.lnk"
;     StrCpy $R0 "Smoking"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd
;
; Section MECINHEM
;   StrCpy $R0 "MECINHEM"
;   Call regStatus
;   Pop $R0
;   ${If} $R0 == "install"
;     SetOutPath "$PROGRAMFILES\\NormPhys\\Mechanisms_in_hematology"
;     File /r ".\\soft\\Mechanisms_in_hematology\"
;     CreateShortcut \
;         "$DESKTOP\\Mechanisms_in_hematology.lnk" \
;         "$OUTDIR\\MECINHEM.exe"
;     StrCpy $R0 "MECINHEM"
;     StrCpy $R1 "installed"
;     Call setRegStatus
;   ${ElseIf} $R0 == "remove"
;     SetOutPath "$PROGRAMFILES\\NormPhys"
;     RMDir /r "$OUTDIR\\Mechanisms_in_hematology"
;     Delete "$DESKTOP\\Mechanisms_in_hematology.lnk"
;     StrCpy $R0 "MECINHEM"
;     StrCpy $R1 ""
;     Call setRegStatus
;   ${EndIf}
; SectionEnd

Section cleanup
  SetOutPath "$PROGRAMFILES"
  EnumRegKey $0 ${ADMIN_REGISTRY_ROOT} ${ADMIN_REGISTRY_PATH} 0
  ${If} $0 == ""
    DeleteRegKey /ifempty ${ADMIN_REGISTRY_ROOT} ${ADMIN_REGISTRY_PATH}
    RMDir /r "$OUTDIR\\NormPhys"
  ${EndIf}
SectionEnd

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English
