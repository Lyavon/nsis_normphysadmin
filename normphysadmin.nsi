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
!include ".\12LEAD.nsh"
!include ".\PHYSIOLOGY.nsh"
!include ".\BREATH_CYCLE.nsh"

!include ".\HCT_ENG.nsh"
!include ".\HCT_RUS.nsh"
!include ".\PHYSIO_EX.nsh"
!include ".\IP_10.nsh"
!include ".\INUTRITION.nsh"
!include ".\FINK.nsh"
!include ".\KIDNEY_ENG.nsh"
!include ".\KIDNEY_RUS.nsh"
!include ".\PHYSIOLOGY_OF_BEHAVIOR.nsh"
!include ".\ATLAS.nsh"
!include ".\LUSHER.nsh"
!include ".\HAEMODYNAMICS.nsh"
!include ".\DEPARTMENT.nsh"
!include ".\HEALTH_WAY.nsh"
!include ".\MODERN_PHYSIOL_LECTURES.nsh"
!include ".\NOZDRACHEV.nsh"
!include ".\SPO2.nsh"

!include ".\SOUNDS_HZ.nsh"
!include ".\SHEFFIELD.nsh"
!include ".\NOBEL.nsh"
!include ".\SMOKING.nsh"
!include ".\BPRAT.nsh"
!include ".\NERVE.nsh"
!include ".\MECINHEM.nsh"



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
!insertmacro createUiBoilerplateCode 12LEAD
!insertmacro createUiBoilerplateCode PHYSIOLOGY
!insertmacro createUiBoilerplateCode BREATH_CYCLE

!insertmacro createUiBoilerplateCode HCT_ENG
!insertmacro createUiBoilerplateCode HCT_RUS
!insertmacro createUiBoilerplateCode PHYSIO_EX
!insertmacro createUiBoilerplateCode IP_10
!insertmacro createUiBoilerplateCode FINK
!insertmacro createUiBoilerplateCode INUTRITION
!insertmacro createUiBoilerplateCode KIDNEY_ENG
!insertmacro createUiBoilerplateCode KIDNEY_RUS
!insertmacro createUiBoilerplateCode PHYSIOLOGY_OF_BEHAVIOR
!insertmacro createUiBoilerplateCode ATLAS
!insertmacro createUiBoilerplateCode LUSHER
!insertmacro createUiBoilerplateCode HAEMODYNAMICS
!insertmacro createUiBoilerplateCode DEPARTMENT
!insertmacro createUiBoilerplateCode HEALTH_WAY
!insertmacro createUiBoilerplateCode MODERN_PHYSIOL_LECTURES
!insertmacro createUiBoilerplateCode NOZDRACHEV
!insertmacro createUiBoilerplateCode SPO2

!insertmacro createUiBoilerplateCode SOUNDS_HZ
!insertmacro createUiBoilerplateCode SHEFFIELD
!insertmacro createUiBoilerplateCode NOBEL
!insertmacro createUiBoilerplateCode SMOKING
!insertmacro createUiBoilerplateCode BPRAT
!insertmacro createUiBoilerplateCode NERVE
!insertmacro createUiBoilerplateCode MECINHEM


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
  !insertmacro invertHWND 12LEAD
  !insertmacro invertHWND PHYSIOLOGY
  !insertmacro invertHWND BREATH_CYCLE

  !insertmacro invertHWND HCT_ENG
  !insertmacro invertHWND HCT_RUS
  !insertmacro invertHWND PHYSIO_EX
  !insertmacro invertHWND IP_10
  !insertmacro invertHWND FINK
  !insertmacro invertHWND INUTRITION
  !insertmacro invertHWND KIDNEY_ENG
  !insertmacro invertHWND KIDNEY_RUS
  !insertmacro invertHWND PHYSIOLOGY_OF_BEHAVIOR
  !insertmacro invertHWND ATLAS
  !insertmacro invertHWND LUSHER
  !insertmacro invertHWND HAEMODYNAMICS
  !insertmacro invertHWND DEPARTMENT
  !insertmacro invertHWND HEALTH_WAY
  !insertmacro invertHWND MODERN_PHYSIOL_LECTURES
  !insertmacro invertHWND NOZDRACHEV
  !insertmacro invertHWND SPO2

  !insertmacro invertHWND SOUNDS_HZ
  !insertmacro invertHWND SHEFFIELD
  !insertmacro invertHWND NOBEL
  !insertmacro invertHWND SMOKING
  !insertmacro invertHWND BPRAT
  !insertmacro invertHWND NERVE
  !insertmacro invertHWND MECINHEM
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
  !insertmacro createCheckBox 0% 71u 12LEAD "08_12Lead"
  !insertmacro createCheckBox 0% 81u PHYSIOLOGY "09_Physiology"
  !insertmacro createCheckBox 0% 91u BREATH_CYCLE "10_Дыхательный_цикл..."

  !insertmacro createCheckBox 0% 111u HCT_ENG "12_Hematocrit"
  !insertmacro createCheckBox 0% 121u HCT_RUS "13_Гематокрит"
  !insertmacro createCheckBox 0% 131u PHYSIO_EX "14_PhysioEx"
  !insertmacro createCheckBox 34% 0u IP_10 "15_IP"
  !insertmacro createCheckBox 34% 11u FINK "16_FINK"
  !insertmacro createCheckBox 34% 21u INUTRITION "17_iNutrition"
  !insertmacro createCheckBox 34% 31u KIDNEY_ENG "18_Kidney"
  !insertmacro createCheckBox 34% 41u KIDNEY_RUS "19_Почка"
  !insertmacro createCheckBox 34% 51u PHYSIOLOGY_OF_BEHAVIOR "20_Suppl...Behavior"
  !insertmacro createCheckBox 34% 61u ATLAS "21_Норм_Физиология"
  !insertmacro createCheckBox 34% 71u LUSHER "22_Тест_Люшера"
  !insertmacro createCheckBox 34% 81u HAEMODYNAMICS "23_Гемодинамика"
  !insertmacro createCheckBox 34% 91u DEPARTMENT "24_О_кафедре"
  !insertmacro createCheckBox 34% 101u HEALTH_WAY "25_Путь_в_страну..."
  !insertmacro createCheckBox 34% 111u MODERN_PHYSIOL_LECTURES "26_Современный_Курс..."
  !insertmacro createCheckBox 34% 121u NOZDRACHEV "27_Учебник_Орлова..."
  !insertmacro createCheckBox 34% 131u SPO2 "28_SpO2_Assistant"

  !insertmacro createCheckBox 67% 61u SOUNDS_HZ "SoundsHz"
  !insertmacro createCheckBox 67% 71u SHEFFIELD "Sheffield Biosciences"
  !insertmacro createCheckBox 67% 81u NOBEL "Нобелевские лауреаты"
  !insertmacro createCheckBox 67% 91u SMOKING "Курение"
  !insertmacro createCheckBox 67% 101u BPRAT "BPRAT"
  !insertmacro createCheckBox 67% 111u NERVE "NERVE"
  !insertmacro createCheckBox 67% 121u MECINHEM "Mechanisms_in_hematology"

  nsDialogs::Show
FunctionEnd

Section cleanup
  SetOutPath "$PROGRAMFILES"
  EnumRegKey $0 ${ADMIN_REGISTRY_ROOT} ${ADMIN_REGISTRY_PATH} 0
  ${If} $0 == ""
    DeleteRegKey /ifempty ${ADMIN_REGISTRY_ROOT} ${ADMIN_REGISTRY_PATH}
    RMDir /r "${ADMIN_PATH}"
  ${EndIf}
SectionEnd

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English
