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
!include ".\HEARTSND.nsh"

!include ".\PHYSIOLOGY.nsh"
!include ".\BREATH_CYCLE.nsh"

!include ".\HCT_ENG.nsh"
!include ".\HCT_RUS.nsh"
!include ".\INUTRITION.nsh"
!include ".\FINK.nsh"

!include ".\KIDNEY_ENG.nsh"
!include ".\KIDNEY_RUS.nsh"

!include ".\LUSHER.nsh"
; !include ".\haemodynamics.nsh"
!include ".\DEPARTMENT.nsh"
!include ".\HEALTH_WAY.nsh"

!include ".\SPO2.nsh"

!include ".\SOUNDS_HZ.nsh"
!include ".\SHEFFIELD.nsh"

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
!insertmacro createUiBoilerplateCode HEARTSND
; !insertmacro createUiBoilerplateCode 12Lead
!insertmacro createUiBoilerplateCode PHYSIOLOGY
!insertmacro createUiBoilerplateCode BREATH_CYCLE

!insertmacro createUiBoilerplateCode HCT_ENG
!insertmacro createUiBoilerplateCode HCT_RUS
; !insertmacro createUiBoilerplateCode PhysioEx
; !insertmacro createUiBoilerplateCode IP
!insertmacro createUiBoilerplateCode FINK
!insertmacro createUiBoilerplateCode INUTRITION
!insertmacro createUiBoilerplateCode KIDNEY_ENG
!insertmacro createUiBoilerplateCode KIDNEY_RUS
; !insertmacro createUiBoilerplateCode PHYSIOLOGY_OF_BEHAVIOR
; !insertmacro createUiBoilerplateCode Electronic_Atlas
!insertmacro createUiBoilerplateCode LUSHER
; !insertmacro createUiBoilerplateCode HAEMODYNAMICS
!insertmacro createUiBoilerplateCode DEPARTMENT
!insertmacro createUiBoilerplateCode HEALTH_WAY
; !insertmacro createUiBoilerplateCode Modern_Physiol_Lectures
; !insertmacro createUiBoilerplateCode Orlov_Nozdrachev
!insertmacro createUiBoilerplateCode SPO2


!insertmacro createUiBoilerplateCode SOUNDS_HZ
!insertmacro createUiBoilerplateCode SHEFFIELD
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
  !insertmacro invertHWND HEARTSND
  ; !insertmacro invertHWND 12Lead
  !insertmacro invertHWND PHYSIOLOGY
  !insertmacro invertHWND BREATH_CYCLE

  !insertmacro invertHWND HCT_ENG
  !insertmacro invertHWND HCT_RUS
  ; !insertmacro invertHWND PhysioEx
  ; !insertmacro invertHWND IP
  !insertmacro invertHWND FINK
  !insertmacro invertHWND INUTRITION
  !insertmacro invertHWND KIDNEY_ENG
  !insertmacro invertHWND KIDNEY_RUS
  ; !insertmacro invertHWND PHYSIOLOGY_OF_BEHAVIOR
  !insertmacro invertHWND LUSHER
  ; !insertmacro invertHWND Electronic_Atlas
  ; !insertmacro invertHWND HAEMODYNAMICS
  !insertmacro invertHWND DEPARTMENT
  !insertmacro invertHWND HEALTH_WAY
  ; !insertmacro invertHWND Modern_Physiol_Lectures
  ; !insertmacro invertHWND Orlov_Nozdrachev
  !insertmacro invertHWND SPO2
  ;
  !insertmacro invertHWND SOUNDS_HZ
  !insertmacro invertHWND SHEFFIELD
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
  !insertmacro createCheckBox 0% 61u HEARTSND "07_Heart_Sounds"
  ; !insertmacro createCheckBox 0% 71u 12Lead "08_12Lead"
  !insertmacro createCheckBox 0% 81u PHYSIOLOGY "09_Physiology"
  !insertmacro createCheckBox 0% 91u BREATH_CYCLE "10_Дыхательный_цикл..."

  !insertmacro createCheckBox 0% 111u HCT_ENG "12_Hematocrit"
  !insertmacro createCheckBox 0% 121u HCT_RUS "13_Гематокрит"
  ; !insertmacro createCheckBox 0% 131u PhysioEx "14_PhysioEx"
  ; !insertmacro createCheckBox 34% 0u IP "15_IP"
  !insertmacro createCheckBox 34% 11u FINK "16_FINK"
  !insertmacro createCheckBox 34% 21u INUTRITION "17_iNutrition"
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
  !insertmacro createCheckBox 34% 131u SPO2 "28_SpO2_Assistant"
  ;
  !insertmacro createCheckBox 67% 61u SOUNDS_HZ "SoundsHz"
  !insertmacro createCheckBox 67% 71u SHEFFIELD "Sheffield Biosciences"
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
