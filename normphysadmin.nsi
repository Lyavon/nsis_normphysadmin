!define version "1"
Name "NormPhysAdmin_${version}"
OutFile "out\\NormPhysAdmin_${version}.exe"
Unicode true
InstallButtonText "Apply"
RequestExecutionLevel admin
#SetCompressor /SOLID lzma

!include "MUI2.nsh"
!include "nsDialogs.nsh"
!include "LogicLib.nsh"

!define MUI_INSTFILESPAGE_COLORS "DDDDDD 222222"
!define MUI_ICON "icon.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header_icon.bmp"


; $R0 - name to use
; $R0 - result
Function registryStatus
  ReadRegStr $R0 HKCU "Software\NormPhysAdmin" $R0
FunctionEnd

; $R0 - name to use
; $R1 - status
Function setRegistryStatus
  ${If} $R1 == ""
    DeleteRegValue HKCU "Software\NormPhysAdmin" $R0
  ${Else}
    WriteRegStr HKCU "Software\NormPhysAdmin" $R0 $R1
  ${EndIf}
FunctionEnd

; $R0 - name to use
; $R1 - checkbox HWND
Function setCheckboxStateByRegistry
  Push $R0

  Call registryStatus
  ${If} $R0 == "installed"
    ${NSD_SetState} $R1 ${BST_CHECKED}
  ${ElseIf} $R0 == "install"
    ${NSD_SetState} $R1 ${BST_CHECKED}
  ${Else}
    ${NSD_SetState} $R1 ${BST_UNCHECKED}
  ${EndIf}

  Pop $R0
FunctionEnd

; $R0 - name to use
Function invertRegistryValue
  Push $R2
  Push $R1
  Push $R0

  StrCpy $R2 $R0 
  Call registryStatus
  ${If} $R0 == "installed"
    StrCpy $R1 "remove"
  ${ElseIf} $R0 == "install"
    StrCpy $R1 ""
  ${ElseIf} $R0 == "remove"
    StrCpy $R1 "installed"
  ${Else}
    StrCpy $R1 "install"
  ${EndIf}
  StrCpy $R0 $R2 
  Call setRegistryStatus

  Pop $R0
  Pop $R1
  Pop $R2
FunctionEnd

; R0 - "true"/ ""
Function shttpsRequired
  Push $R1
  StrCpy $R1 ""

  StrCpy $R0 "12Lead"
  Call registryStatus
  ${If} $R0 == "install"
  ${OrIf} $R0 == "installed"
    StrCpy $R1 "true"
  ${EndIf}

  StrCpy $R0 "IP"
  Call registryStatus
  ${If} $R0 == "install"
  ${OrIf} $R0 == "installed"
    StrCpy $R1 "true"
  ${EndIf}

  StrCpy $R0 "HAEMODYNAMICS"
  Call registryStatus
  ${If} $R0 == "install"
  ${OrIf} $R0 == "installed"
    StrCpy $R1 "true"
  ${EndIf}

  StrCpy $R0 "Electronic_Atlas"
  Call registryStatus
  ${If} $R0 == "install"
  ${OrIf} $R0 == "installed"
    StrCpy $R1 "true"
  ${EndIf}

  StrCpy $R0 "Modern_Physiol_Lectures"
  Call registryStatus
  ${If} $R0 == "install"
  ${OrIf} $R0 == "installed"
    StrCpy $R1 "true"
  ${EndIf}

  StrCpy $R0 "Orlov_Nozdrachev"
  Call registryStatus
  ${If} $R0 == "install"
  ${OrIf} $R0 == "installed"
    StrCpy $R1 "true"
  ${EndIf}

  StrCpy $R0 "Nobel"
  Call registryStatus
  ${If} $R0 == "install"
  ${OrIf} $R0 == "installed"
    StrCpy $R1 "true"
  ${EndIf}

  StrCpy $R0 "Smoking"
  Call registryStatus
  ${If} $R0 == "install"
  ${OrIf} $R0 == "installed"
    StrCpy $R1 "true"
  ${EndIf}

  StrCpy $R0 $R1

  Pop $R1
FunctionEnd

Var PHYSIOL2_HWND
Var NMJ_HWND
Var TWITCH_HWND
Var PRAT_HWND
Var EyeTests_HWND
Var RabkinTables_HWND
Var HEARTSND_HWND
Var 12Lead_HWND
Var Physiology_HWND
Var BreathCycle_HWND
Var HCT_ENG_HWND
Var HCT_RUS_HWND
Var PhysioEx_HWND
Var IP_HWND
Var FINK_HWND
Var iNutrition_HWND
Var KIDNEY_ENG_HWND
Var KIDNEY_RUS_HWND
Var PHYSIOLOGY_OF_BEHAVIOR_HWND
Var HAEMODYNAMICS_HWND
Var LUSHER_HWND
Var DEPARTMENT_HWND
Var HEALTH_WAY_HWND
Var Modern_Physiol_Lectures_HWND
Var Orlov_Nozdrachev_HWND

Var Electronic_Atlas_HWND
Var SpO2_HWND
Var SoundsHz_HWND
Var Sheffield_HWND
Var Nobel_HWND
Var Smoking_HWND
Var BPRAT_HWND
Var NERVE_HWND
Var MECINHEM_HWND

Var InvertButton_HWND

; $R0 - HWND
; $R1 - HWND CallBack
Function InvertHWND
  Push $R2

  ${NSD_GetChecked} $R0 $R2
  ${If} $R2 == ${BST_CHECKED}
    ${NSD_SetState} $R0 ${BST_UNCHECKED}
  ${Else}
    ${NSD_SetState} $R0 ${BST_CHECKED}
  ${EndIf}
  Call $R1

  Pop $R2
FunctionEnd

Function InvertButton_Clicked
  Push $R0
  Push $R1

  StrCpy $R0 $PHYSIOL2_HWND
  GetFunctionAddress $R1 PHYSIOL2_Clicked
  Call InvertHWND

  StrCpy $R0 $NMJ_HWND
  GetFunctionAddress $R1 NMJ_Clicked
  Call InvertHWND

  StrCpy $R0 $TWITCH_HWND
  GetFunctionAddress $R1 TWITCH_Clicked
  Call InvertHWND

  StrCpy $R0 $PRAT_HWND
  GetFunctionAddress $R1 PRAT_Clicked
  Call InvertHWND

  StrCpy $R0 $EyeTests_HWND
  GetFunctionAddress $R1 EyeTests_Clicked
  Call InvertHWND
  
  StrCpy $R0 $RabkinTables_HWND
  GetFunctionAddress $R1 RabkinTables_Clicked
  Call InvertHWND

  StrCpy $R0 $HEARTSND_HWND
  GetFunctionAddress $R1 HEARTSND_Clicked
  Call InvertHWND

  StrCpy $R0 $12Lead_HWND
  GetFunctionAddress $R1 12Lead_Clicked
  Call InvertHWND

  StrCpy $R0 $Physiology_HWND
  GetFunctionAddress $R1 Physiology_Clicked
  Call InvertHWND

  StrCpy $R0 $BreathCycle_HWND
  GetFunctionAddress $R1 BreathCycle_Clicked
  Call InvertHWND

  StrCpy $R0 $HCT_ENG_HWND
  GetFunctionAddress $R1 HCT_ENG_Clicked
  Call InvertHWND

  StrCpy $R0 $HCT_RUS_HWND
  GetFunctionAddress $R1 HCT_RUS_Clicked
  Call InvertHWND

  StrCpy $R0 $PhysioEx_HWND
  GetFunctionAddress $R1 PhysioEx_Clicked
  Call InvertHWND

  StrCpy $R0 $IP_HWND
  GetFunctionAddress $R1 IP_Clicked
  Call InvertHWND

  StrCpy $R0 $FINK_HWND
  GetFunctionAddress $R1 FINK_Clicked
  Call InvertHWND

  StrCpy $R0 $iNutrition_HWND
  GetFunctionAddress $R1 iNutrition_Clicked
  Call InvertHWND

  StrCpy $R0 $KIDNEY_ENG_HWND
  GetFunctionAddress $R1 KIDNEY_ENG_Clicked
  Call InvertHWND

  StrCpy $R0 $KIDNEY_RUS_HWND
  GetFunctionAddress $R1 KIDNEY_RUS_Clicked
  Call InvertHWND

  StrCpy $R0 $PHYSIOLOGY_OF_BEHAVIOR_HWND
  GetFunctionAddress $R1 PHYSIOLOGY_OF_BEHAVIOR_Clicked
  Call InvertHWND

  StrCpy $R0 $HAEMODYNAMICS_HWND
  GetFunctionAddress $R1 HAEMODYNAMICS_Clicked
  Call InvertHWND

  StrCpy $R0 $LUSHER_HWND
  GetFunctionAddress $R1 LUSHER_Clicked
  Call InvertHWND

  StrCpy $R0 $DEPARTMENT_HWND
  GetFunctionAddress $R1 DEPARTMENT_Clicked
  Call InvertHWND

  StrCpy $R0 $HEALTH_WAY_HWND
  GetFunctionAddress $R1 HEALTH_WAY_Clicked
  Call InvertHWND

  StrCpy $R0 $Modern_Physiol_Lectures_HWND
  GetFunctionAddress $R1 Modern_Physiol_Lectures_Clicked
  Call InvertHWND

  StrCpy $R0 $Orlov_Nozdrachev_HWND
  GetFunctionAddress $R1 Orlov_Nozdrachev_Clicked
  Call InvertHWND

  StrCpy $R0 $Electronic_Atlas_HWND
  GetFunctionAddress $R1 Electronic_Atlas_Clicked
  Call InvertHWND

  StrCpy $R0 $SpO2_HWND
  GetFunctionAddress $R1 SpO2_Clicked
  Call InvertHWND

  StrCpy $R0 $SoundsHz_HWND
  GetFunctionAddress $R1 SoundsHz_Clicked
  Call InvertHWND

  StrCpy $R0 $Sheffield_HWND
  GetFunctionAddress $R1 Sheffield_Clicked
  Call InvertHWND

  StrCpy $R0 $Nobel_HWND
  GetFunctionAddress $R1 Nobel_Clicked
  Call InvertHWND

  StrCpy $R0 $Smoking_HWND
  GetFunctionAddress $R1 Smoking_Clicked
  Call InvertHWND

  StrCpy $R0 $BPRAT_HWND
  GetFunctionAddress $R1 BPRAT_Clicked
  Call InvertHWND

  StrCpy $R0 $NERVE_HWND
  GetFunctionAddress $R1 NERVE_Clicked
  Call InvertHWND

  StrCpy $R0 $MECINHEM_HWND
  GetFunctionAddress $R1 MECINHEM_Clicked
  Call InvertHWND

  Pop $R1
  Pop $0
FunctionEnd



Page custom AdminEnter "" " Physiology Programs" /ENABLECANCEL

Function AdminEnter
!insertmacro MUI_HEADER_TEXT "Check options you want to keep on PC" "Электронный атлас и Современный курс классических лекций требуют наличие соответствующих архивов рядом"
  nsDialogs::Create 1018
  Pop $0
  ${If} $0 == error
    Abort
  ${EndIf}

  ${NSD_CreateButton} 67% 131u 33% 10u "Invert Selection"
  Pop $InvertButton_HWND
  ${NSD_OnClick} $InvertButton_HWND InvertButton_Clicked

  ${NSD_CreateCheckBox} 0 0 33% 10u "01_PHYSIOL2"
  Pop $PHYSIOL2_HWND
  StrCpy $R0 "PHYSIOL2"
  StrCpy $R1 $PHYSIOL2_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $PHYSIOL2_HWND PHYSIOL2_Clicked

  ${NSD_CreateCheckBox} 0 11u 33% 10u "02_NMJ"
  Pop $NMJ_HWND
  StrCpy $R0 "NMJ"
  StrCpy $R1 $NMJ_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $NMJ_HWND NMJ_Clicked

  ${NSD_CreateCheckBox} 0 21u 33% 10u "03_TWITCH"
  Pop $TWITCH_HWND
  StrCpy $R0 "TWITCH"
  StrCpy $R1 $TWITCH_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $TWITCH_HWND TWITCH_Clicked

  ${NSD_CreateCheckBox} 0 31u 33% 10u "04_PRAT"
  Pop $PRAT_HWND
  StrCpy $R0 "PRAT"
  StrCpy $R1 $PRAT_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $PRAT_HWND PRAT_Clicked

  ${NSD_CreateCheckBox} 0 41u 33% 10u "05_EyeTests"
  Pop $EyeTests_HWND
  StrCpy $R0 "EyeTests"
  StrCpy $R1 $EyeTests_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $EyeTests_HWND EyeTests_Clicked

  ${NSD_CreateCheckBox} 0 51u 33% 10u "06_Таблицы_Рабкина"
  Pop $RabkinTables_HWND
  StrCpy $R0 "RabkinTables"
  StrCpy $R1 $RabkinTables_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $RabkinTables_HWND RabkinTables_Clicked

  ${NSD_CreateCheckBox} 0 61u 33% 10u "07_Heart_Sounds"
  Pop $HEARTSND_HWND
  StrCpy $R0 "HEARTSND"
  StrCpy $R1 $HEARTSND_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $HEARTSND_HWND HEARTSND_Clicked

  ${NSD_CreateCheckBox} 0 71u 33% 10u "08_12Lead"
  Pop $12Lead_HWND
  StrCpy $R0 "12Lead"
  StrCpy $R1 $12Lead_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $12Lead_HWND 12Lead_Clicked

  ${NSD_CreateCheckBox} 0 81u 33% 10u "09_Physiology"
  Pop $Physiology_HWND
  StrCpy $R0 "Physiology"
  StrCpy $R1 $Physiology_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $Physiology_HWND Physiology_Clicked

  ${NSD_CreateCheckBox} 0 91u 33% 10u "10_Дыхательный_цикл..."
  Pop $BreathCycle_HWND
  StrCpy $R0 "BreathCycle"
  StrCpy $R1 $BreathCycle_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $BreathCycle_HWND BreathCycle_Clicked

  ${NSD_CreateCheckBox} 0% 111u 33% 10u "12_Hematocrit"
  Pop $HCT_ENG_HWND
  StrCpy $R0 "HCT_ENG"
  StrCpy $R1 $HCT_ENG_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $HCT_ENG_HWND HCT_ENG_Clicked

  ${NSD_CreateCheckBox} 0% 121u 33% 10u "13_Гематокрит"
  Pop $HCT_RUS_HWND
  StrCpy $R0 "HCT_RUS"
  StrCpy $R1 $HCT_RUS_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $HCT_RUS_HWND HCT_RUS_Clicked

  ${NSD_CreateCheckBox} 0% 131u 33% 10u "14_PhysioEx"
  Pop $PhysioEx_HWND
  StrCpy $R0 "PhysioEx"
  StrCpy $R1 $PhysioEx_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $PhysioEx_HWND PhysioEx_Clicked

  ${NSD_CreateCheckBox} 34% 01u 33% 10u "15_IP"
  Pop $IP_HWND
  StrCpy $R0 "IP"
  StrCpy $R1 $IP_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $IP_HWND IP_Clicked

  ${NSD_CreateCheckBox} 34% 11u 33% 10u "16_FINK"
  Pop $FINK_HWND
  StrCpy $R0 "FINK"
  StrCpy $R1 $FINK_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $FINK_HWND FINK_Clicked

  ${NSD_CreateCheckBox} 34% 21u 33% 10u "17_iNutrition"
  Pop $iNutrition_HWND
  StrCpy $R0 "iNutrition"
  StrCpy $R1 $iNutrition_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $iNutrition_HWND iNutrition_Clicked

  ${NSD_CreateCheckBox} 34% 31u 33% 10u "18_Kidney"
  Pop $KIDNEY_ENG_HWND
  StrCpy $R0 "KIDNEY_ENG"
  StrCpy $R1 $KIDNEY_ENG_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $KIDNEY_ENG_HWND KIDNEY_ENG_Clicked

  ${NSD_CreateCheckBox} 34% 41u 33% 10u "19_Почка"
  Pop $KIDNEY_RUS_HWND
  StrCpy $R0 "KIDNEY_RUS"
  StrCpy $R1 $KIDNEY_RUS_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $KIDNEY_RUS_HWND KIDNEY_RUS_Clicked

  ${NSD_CreateCheckBox} 34% 51u 33% 10u "20_Suppl...Behavior"
  Pop $PHYSIOLOGY_OF_BEHAVIOR_HWND
  StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
  StrCpy $R1 $PHYSIOLOGY_OF_BEHAVIOR_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $PHYSIOLOGY_OF_BEHAVIOR_HWND PHYSIOLOGY_OF_BEHAVIOR_Clicked

  ${NSD_CreateCheckBox} 34% 61u 33% 10u "21_Норм_Физиология"
  Pop $Electronic_Atlas_HWND
  StrCpy $R0 "Electronic_Atlas"
  StrCpy $R1 $Electronic_Atlas_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $Electronic_Atlas_HWND Electronic_Atlas_Clicked

  ${NSD_CreateCheckBox} 34% 71u 33% 10u "22_Тест_Люшера"
  Pop $LUSHER_HWND
  StrCpy $R0 "LUSHER"
  StrCpy $R1 $LUSHER_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $LUSHER_HWND LUSHER_Clicked

  ${NSD_CreateCheckBox} 34% 81u 33% 10u "23_Гемодинамика"
  Pop $HAEMODYNAMICS_HWND
  StrCpy $R0 "HAEMODYNAMICS"
  StrCpy $R1 $HAEMODYNAMICS_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $HAEMODYNAMICS_HWND HAEMODYNAMICS_Clicked

  ${NSD_CreateCheckBox} 34% 91u 33% 10u "24_О_кафедре"
  Pop $DEPARTMENT_HWND
  StrCpy $R0 "DEPARTMENT"
  StrCpy $R1 $DEPARTMENT_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $DEPARTMENT_HWND DEPARTMENT_Clicked

  ${NSD_CreateCheckBox} 34% 101u 33% 10u "25_Путь_в_страну..."
  Pop $HEALTH_WAY_HWND
  StrCpy $R0 "HEALTH_WAY"
  StrCpy $R1 $HEALTH_WAY_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $HEALTH_WAY_HWND HEALTH_WAY_Clicked

  ${NSD_CreateCheckBox} 34% 111u 33% 10u "26_Современный_Курс..."
  Pop $Modern_Physiol_Lectures_HWND
  StrCpy $R0 "Modern_Physiol_Lectures"
  StrCpy $R1 $Modern_Physiol_Lectures_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $Modern_Physiol_Lectures_HWND Modern_Physiol_Lectures_Clicked

  ${NSD_CreateCheckBox} 34% 121u 33% 10u "27_Учебник_Орлова..."
  Pop $Orlov_Nozdrachev_HWND
  StrCpy $R0 "Orlov_Nozdrachev"
  StrCpy $R1 $Orlov_Nozdrachev_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $Orlov_Nozdrachev_HWND Orlov_Nozdrachev_Clicked

  ${NSD_CreateCheckBox} 34% 131u 33% 10u "28_SpO2_Assistant"
  Pop $SpO2_HWND
  StrCpy $R0 "SpO2"
  StrCpy $R1 $SpO2_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $SpO2_HWND SpO2_Clicked

  ${NSD_CreateCheckBox} 67% 61u 33% 10u "SoundsHz"
  Pop $SoundsHz_HWND
  StrCpy $R0 "SoundsHz"
  StrCpy $R1 $SoundsHz_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $SoundsHz_HWND SoundsHz_Clicked

  ${NSD_CreateCheckBox} 67% 71u 33% 10u "Sheffield Biosciences"
  Pop $Sheffield_HWND
  StrCpy $R0 "Sheffield"
  StrCpy $R1 $Sheffield_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $Sheffield_HWND Sheffield_Clicked

  ${NSD_CreateCheckBox} 67% 81u 33% 10u "Нобелевские лауреаты"
  Pop $Nobel_HWND
  StrCpy $R0 "Nobel"
  StrCpy $R1 $Nobel_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $Nobel_HWND Nobel_Clicked

  ${NSD_CreateCheckBox} 67% 91u 33% 10u "Курение"
  Pop $Smoking_HWND
  StrCpy $R0 "Smoking"
  StrCpy $R1 $Smoking_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $Smoking_HWND Smoking_Clicked

  ${NSD_CreateCheckBox} 67% 101u 33% 10u "BPRAT"
  Pop $BPRAT_HWND
  StrCpy $R0 "BPRAT"
  StrCpy $R1 $BPRAT_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $BPRAT_HWND BPRAT_Clicked

  ${NSD_CreateCheckBox} 67% 111u 33% 10u "NERVE"
  Pop $NERVE_HWND
  StrCpy $R0 "NERVE"
  StrCpy $R1 $NERVE_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $NERVE_HWND NERVE_Clicked

  ${NSD_CreateCheckBox} 67% 121u 33% 10u "Mechanisms_in_hematology"
  Pop $MECINHEM_HWND
  StrCpy $R0 "MECINHEM"
  StrCpy $R1 $MECINHEM_HWND
  Call setCheckboxStateByRegistry
  ${NSD_OnClick} $MECINHEM_HWND MECINHEM_Clicked

  nsDialogs::Show
FunctionEnd

Function PHYSIOL2_Clicked
  Push $R0

  StrCpy $R0 "PHYSIOL2"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function NMJ_Clicked
  Push $R0

  StrCpy $R0 "NMJ"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function TWITCH_Clicked
  Push $R0

  StrCpy $R0 "TWITCH"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function PRAT_Clicked
  Push $R0

  StrCpy $R0 "PRAT"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function EyeTests_Clicked
  Push $R0

  StrCpy $R0 "EyeTests"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function RabkinTables_Clicked
  Push $R0

  StrCpy $R0 "RabkinTables"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function HEARTSND_Clicked
  Push $R0

  StrCpy $R0 "HEARTSND"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function 12Lead_Clicked
  Push $R0

  StrCpy $R0 "12Lead"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function Physiology_Clicked
  Push $R0

  StrCpy $R0 "Physiology"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function BreathCycle_Clicked
  Push $R0

  StrCpy $R0 "BreathCycle"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function HCT_ENG_Clicked
  Push $R0

  StrCpy $R0 "HCT_ENG"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function HCT_RUS_Clicked
  Push $R0

  StrCpy $R0 "HCT_RUS"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function PhysioEx_Clicked
  Push $R0

  StrCpy $R0 "PhysioEx"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function IP_Clicked
  Push $R0

  StrCpy $R0 "IP"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function FINK_Clicked
  Push $R0

  StrCpy $R0 "FINK"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function iNutrition_Clicked
  Push $R0

  StrCpy $R0 "iNutrition"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function KIDNEY_ENG_Clicked
  Push $R0

  StrCpy $R0 "KIDNEY_ENG"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function KIDNEY_RUS_Clicked
  Push $R0

  StrCpy $R0 "KIDNEY_RUS"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function PHYSIOLOGY_OF_BEHAVIOR_Clicked
  Push $R0

  StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function Electronic_Atlas_Clicked
  Push $R0

  StrCpy $R0 "Electronic_Atlas"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function LUSHER_Clicked
  Push $R0

  StrCpy $R0 "LUSHER"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function HAEMODYNAMICS_Clicked
  Push $R0

  StrCpy $R0 "HAEMODYNAMICS"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function DEPARTMENT_Clicked
  Push $R0

  StrCpy $R0 "DEPARTMENT"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function HEALTH_WAY_Clicked
  Push $R0

  StrCpy $R0 "HEALTH_WAY"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function Modern_Physiol_Lectures_Clicked
  Push $R0

  StrCpy $R0 "Modern_Physiol_Lectures"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function Orlov_Nozdrachev_Clicked
  Push $R0

  StrCpy $R0 "Orlov_Nozdrachev"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function SpO2_Clicked
  Push $R0

  StrCpy $R0 "SpO2"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function SoundsHz_Clicked
  Push $R0

  StrCpy $R0 "SoundsHz"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function Sheffield_Clicked
  Push $R0

  StrCpy $R0 "Sheffield"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function Nobel_Clicked
  Push $R0

  StrCpy $R0 "Nobel"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function Smoking_Clicked
  Push $R0

  StrCpy $R0 "Smoking"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function BPRAT_Clicked
  Push $R0

  StrCpy $R0 "BPRAT"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function NERVE_Clicked
  Push $R0

  StrCpy $R0 "NERVE"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd

Function MECINHEM_Clicked
  Push $R0

  StrCpy $R0 "MECINHEM"
  Call invertRegistryValue 

  Pop $R0
FunctionEnd



Section shttps
  Call shttpsRequired
  ${If} $R0 == "true"
    StrCpy $R0 "shttps"
    Call registryStatus
    ${If} $R0 != "installed"
      SetOutPath "$PROGRAMFILES\\NormPhys\\shttps"
      File /r ".\\soft\\shttps\"
      CreateShortcut \
          "$SMSTARTUP\\shttps.lnk" \
          "$OUTDIR\\http.exe"
      StrCpy $R0 "shttps"
      StrCpy $R1 "installed"
      Call setRegistryStatus
      Exec "http.exe"
    ${EndIf}
  ${Else}
    StrCpy $R0 "shttps"
    Call registryStatus
    ${If} $R0 != ""
      ExecWait '"C:\Windows\System32\taskkill.exe" /IM http.exe'
      SetOutPath "$PROGRAMFILES\\NormPhys"
      RMDir /r "$OUTDIR\\shttps"
      Delete "$SMSTARTUP\\shttps.lnk"
      StrCpy $R0 "shttps"
      StrCpy $R1 ""
      Call setRegistryStatus
    ${EndIf}
  ${EndIf}
SectionEnd

Section PHYSIOL2
  StrCpy $R0 "PHYSIOL2"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\PHYSIOL2"
    File /r ".\\soft\\PHYSIOL2\"
    CreateShortcut \
        "$DESKTOP\\01_PHYSIOL2.lnk" \
        "$OUTDIR\\run.bat" \
        "" \
        "$OUTDIR\\PHYSIOL2.ico"
    StrCpy $R0 "PHYSIOL2"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\PHYSIOL2"
    Delete "$DESKTOP\\01_PHYSIOL2.lnk"
    StrCpy $R0 "PHYSIOL2"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section NMJ
  StrCpy $R0 "NMJ"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\NMJ"
    File /r ".\\soft\\NMJ\"
    CreateShortcut \
        "$DESKTOP\\02_NMJ.lnk" \
        "$OUTDIR\\run.bat" \
        "" \
        "$OUTDIR\\NMJ.ico"
    StrCpy $R0 "NMJ"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\NMJ"
    Delete "$DESKTOP\\02_NMJ.lnk"
    StrCpy $R0 "NMJ"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section TWITCH
  StrCpy $R0 "TWITCH"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\TWITCH"
    File /r ".\\soft\\TWITCH\"
    CreateShortcut \
        "$DESKTOP\\03_TWITCH.lnk" \
        "$OUTDIR\\run.bat" \
        "" \
        "$OUTDIR\\TWITCH.ico"
    StrCpy $R0 "TWITCH"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\TWITCH"
    Delete "$DESKTOP\\03_TWITCH.lnk"
    StrCpy $R0 "TWITCH"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section PRAT
  StrCpy $R0 "PRAT"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\PRAT"
    File /r ".\\soft\\PRAT\"
    CreateShortcut \
        "$DESKTOP\\04_PRAT.lnk" \
        "$OUTDIR\\run.bat" \
        "" \
        "$OUTDIR\\BP.ico"
    StrCpy $R0 "PRAT"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\PRAT"
    Delete "$DESKTOP\\04_PRAT.lnk"
    StrCpy $R0 "PRAT"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section EyeTests
  StrCpy $R0 "EyeTests"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\EyeTests"
    File /r ".\\soft\\EyeTests\"
    CreateShortcut \
        "$DESKTOP\\05_EyeTests.lnk" \
        "$OUTDIR\\run.bat" \
        "" \
        "$OUTDIR\\EyeTests.ico"
    StrCpy $R0 "EyeTests"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\EyeTests"
    Delete "$DESKTOP\\05_EyeTests.lnk"
    StrCpy $R0 "EyeTests"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section RabkinTables
  StrCpy $R0 "RabkinTables"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\RabkinTables"
    File /r ".\\soft\\RabkinTables\"
    CreateShortcut \
        "$DESKTOP\\06_Таблицы_Рабкина.lnk" \
        "$OUTDIR\\RabkinTables.pps" \
        "" \
        "$OUTDIR\\RabkinTables.ico"
    StrCpy $R0 "RabkinTables"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\RabkinTables"
    Delete "$DESKTOP\\06_Таблицы_Рабкина.lnk"
    StrCpy $R0 "RabkinTables"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section HEARTSND
  StrCpy $R0 "HEARTSND"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\HEARTSND"
    File /r ".\\soft\\HEARTSND\"
    CreateShortcut \
        "$DESKTOP\\07_Heart_Sounds.lnk" \
        "$OUTDIR\\HRTSND32.exe" \
        "" \
        "$OUTDIR\\HEARTSND.ico"
    StrCpy $R0 "HEARTSND"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\HEARTSND"
    Delete "$DESKTOP\\07_Heart_Sounds.lnk"
    StrCpy $R0 "HEARTSND"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section 12Lead
  StrCpy $R0 "12Lead"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\12Lead"
    File /r ".\\soft\\12Lead\"
    CreateShortcut \
        "$DESKTOP\\08_12Lead.lnk" \
        "http://localhost:1025/12Lead/12Lead.htm" \
        "" \
        "$OUTDIR\\12Lead.ico"
    StrCpy $R0 "12Lead"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
    RMDir /r "$OUTDIR\\12Lead"
    Delete "$DESKTOP\\08_12Lead.lnk"
    StrCpy $R0 "12Lead"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section Physiology
  StrCpy $R0 "Physiology"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\Physiology"
    File /r ".\\soft\\Physiology\"
    CreateShortcut \
        "$DESKTOP\\09_Physiology.lnk" \
        "$OUTDIR\\Physiology.exe" \
        "" \
        "$OUTDIR\\Physiology.ico"
    StrCpy $R0 "Physiology"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\Physiology"
    Delete "$DESKTOP\\09_Physiology.lnk"
    StrCpy $R0 "Physiology"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section HCT_ENG
  StrCpy $R0 "HCT_ENG"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\HCT_ENG"
    File /r ".\\soft\\HCT_ENG\"
    CreateShortcut \
        "$DESKTOP\\12_Hematocrit.lnk" \
        "$OUTDIR\\SWFPlayer.exe" \
        "startpage.swf" \
        "$OUTDIR\\HCT.ico"
    StrCpy $R0 "HCT_ENG"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\HCT_ENG"
    Delete "$DESKTOP\\12_Hematocrit.lnk"
    StrCpy $R0 "HCT_ENG"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section HCT_RUS
  StrCpy $R0 "HCT_RUS"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\HCT_RUS"
    File /r ".\\soft\\HCT_RUS\"
    CreateShortcut \
        "$DESKTOP\\13_Гематокрит.lnk" \
        "$OUTDIR\\SWFPlayer.exe" \
        "startpage.swf" \
        "$OUTDIR\\HCT.ico"
    StrCpy $R0 "HCT_RUS"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\HCT_RUS"
    Delete "$DESKTOP\\13_Гематокрит.lnk"
    StrCpy $R0 "HCT_RUS"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section PhysioEx
  StrCpy $R0 "PhysioEx"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\PhysioEx"
    File /r ".\\soft\\PhysioEx\"
    CreateShortcut \
        "$DESKTOP\\14_PhysioEx.lnk" \
        "$OUTDIR\SWFPlayer.exe" \
        "_files\main.swf" \
        "$OUTDIR\\icon.ico"
    StrCpy $R0 "PhysioEx"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\PhysioEx"
    Delete "$DESKTOP\\14_PhysioEx.lnk"
    StrCpy $R0 "PhysioEx"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section IP
  StrCpy $R0 "IP"
  Call registryStatus
  ${If} $R0 == "install"
    ${IfNot} ${FileExists} "C:\\Windows\\SysWOW64\\Macromed\\Shockwave 8\\UNWISE.exe"
    ${AndIfNot} ${FileExists} "C:\\Windows\\System32\\Macromed\\Shockwave 8\\UNWISE.exe"
      SetOutPath "$TEMP"
      File ".\\soft\\shockwave.exe"
      ExecWait "shockwave.exe"
      Delete "shockwave.exe"
    ${EndIf}
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\IP-10"
    File /r ".\\soft\\IP-10\"
    MessageBox MB_OK "Internet Explorer is required for IP-10.$\r$\nIt can be enabled in:$\r$\nControl panel -> Windows features"
    CreateShortcut \
        "$DESKTOP\\15_IP.lnk" \
        "http://localhost:1025/IP-10/index.html" \
        "" \
        "$OUTDIR\\IP.ico"
    StrCpy $R0 "IP"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    ${If} ${FileExists} "C:\\Windows\\SysWOW64\\Macromed\\Shockwave 8\\UNWISE.exe"
      ExecWait "C:\\Windows\\SysWOW64\\Macromed\\Shockwave 8\\UNWISE.exe"
    ${ElseIf} ${FileExists} "C:\\Windows\\System32\\Macromed\\Shockwave 8\\UNWISE.exe"
      ExecWait "C:\\Windows\\System32\\Macromed\\Shockwave 8\\UNWISE.exe"
    ${Else}
    ${EndIf}
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
    RMDir /r "$OUTDIR\\IP-10"
    Delete "$DESKTOP\\15_IP.lnk"
    StrCpy $R0 "IP"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section BreathCycle
  StrCpy $R0 "BreathCycle"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\BreathCycle"
    File /r ".\\soft\\BreathCycle\"
    CreateShortcut \
        "$DESKTOP\\10_Дыхательный_цикл_покоя.lnk" \
        "$OUTDIR\\BreathCycle.ppsx" \
        "" \
        "$OUTDIR\\BreathCycle.ico"
    StrCpy $R0 "BreathCycle"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\BreathCycle"
    Delete "$DESKTOP\\10_Дыхательный_цикл_покоя.lnk"
    StrCpy $R0 "BreathCycle"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section FINK
  StrCpy $R0 "FINK"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\FINK"
    File /r ".\\soft\\FINK\"
    CreateShortcut \
        "$DESKTOP\\16_FINK.lnk" \
        "$OUTDIR\\run.bat" \
        "" \
        "$OUTDIR\\FINK.ico"
    StrCpy $R0 "FINK"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\FINK"
    Delete "$DESKTOP\\16_FINK.lnk"
    StrCpy $R0 "FINK"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section iNutrition
  StrCpy $R0 "iNutrition"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\iNutrition\"
    File /r ".\\soft\\iNutrition\"
    SetOutPath "$PROGRAMFILES\\NormPhys\\iNutrition"
    CreateShortcut \
        "$DESKTOP\\17_iNutrition.lnk" \
        "$OUTDIR\\iNutrition.exe" \
        "" \
        "$OUTDIR\\iNutrition.ico"
    StrCpy $R0 "iNutrition"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
      ExecWait '"C:\Windows\System32\taskkill.exe" /IM iNutrition.exe'
    RMDir /r "$OUTDIR\\iNutrition"
    Delete "$DESKTOP\\17_iNutrition.lnk"
    StrCpy $R0 "iNutrition"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section KIDNEY_ENG
  StrCpy $R0 "KIDNEY_ENG"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\KIDNEY_ENG"
    File /r ".\\soft\\KIDNEY_ENG\"
    CreateShortcut \
        "$DESKTOP\\18_Kidney.lnk" \
        "$OUTDIR\\run.bat" \
        "" \
        "$OUTDIR\\KIDNEY.ico"
    StrCpy $R0 "KIDNEY_ENG"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\KIDNEY_ENG"
    Delete "$DESKTOP\\18_Kidney.lnk"
    StrCpy $R0 "KIDNEY_ENG"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section KIDNEY_RUS
  StrCpy $R0 "KIDNEY_RUS"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\KIDNEY_RUS"
    File /r ".\\soft\\KIDNEY_RUS\"
    CreateShortcut \
        "$DESKTOP\\19_Почка.lnk" \
        "$OUTDIR\\run.bat" \
        "" \
        "$OUTDIR\\KIDNEY.ico"
    StrCpy $R0 "KIDNEY_RUS"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\KIDNEY_RUS"
    Delete "$DESKTOP\\19_Почка.lnk"
    StrCpy $R0 "KIDNEY_RUS"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section PHYSIOLOGY_OF_BEHAVIOR
  StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\Physiology_of_Behavior"
    File /r ".\\soft\\Physiology_OF_BEHAVIOR\"
    CreateShortcut \
        "$DESKTOP\\20_Supplement_to_the_Physiology_of_Behavior.lnk" \
        "$OUTDIR\\NSANIM.exe" \
        "" \
        "$OUTDIR\\Ico_brain.ico"
    StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\Physiology_of_Behavior"
    Delete "$DESKTOP\\20_Supplement_to_the_Physiology_of_Behavior.lnk"
    StrCpy $R0 "PHYSIOLOGY_OF_BEHAVIOR"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section Electronic_Atlas
  StrCpy $R0 "Electronic_Atlas"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$TEMP"
    File ".\\soft\\7z.exe"
    File ".\\soft\\7z.dll"
    ExecWait '7z.exe x -o"$PROGRAMFILES\\NormPhys\\shttps\\www\\electronic_atlas" "$EXEDIR\\electronic_atlas.zip"'
    Delete "7zip.exe"
    Delete "7zip.dll"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\electronic_atlas"
    CreateShortcut \
        "$DESKTOP\\21_Норм_Физиология.lnk" \
        "http://localhost:1025/electronic_atlas/index.html" \
        "" \
        "$OUTDIR\\Logo_NormPhys_ru.ico"
    StrCpy $R0 "Electronic_Atlas"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
    RMDir /r "$OUTDIR\\electronic_atlas"
    Delete "$DESKTOP\\21_Норм_Физиология.lnk"
    StrCpy $R0 "Electronic_Atlas"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section LUSHER
  StrCpy $R0 "LUSHER"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\LUSHER"
    File /r ".\\soft\\LUSHER\"
    CreateShortcut \
        "$DESKTOP\\22_Тест_Люшера.lnk" \
        "$OUTDIR\\run.bat" \
        "" \
        "$OUTDIR\\LUSHER.ico"
    StrCpy $R0 "LUSHER"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\LUSHER"
    Delete "$DESKTOP\\22_Тест_Люшера.lnk"
    StrCpy $R0 "LUSHER"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section HAEMODYNAMICS
  StrCpy $R0 "HAEMODYNAMICS"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\Haemodynamics"
    File /r ".\\soft\\Haemodynamics\"
    CreateShortcut \
        "$DESKTOP\\23_Гемодинамика.lnk" \
        "http://localhost:1025/Haemodynamics/23_haemodynamics_start.html" \
        "" \
        "$OUTDIR\\Icon.ico"
    StrCpy $R0 "HAEMODYNAMICS"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
    RMDir /r "$OUTDIR\\HAEMODYNAMICS"
    Delete "$DESKTOP\\23_Гемодинамика.lnk"
    StrCpy $R0 "HAEMODYNAMICS"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section DEPARTMENT
  StrCpy $R0 "DEPARTMENT"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\DEPARTMENT"
    File /r ".\\soft\\DEPARTMENT\"
    CreateShortcut \
        "$DESKTOP\\24_О_кафедре_нормальной_физиологии.lnk" \
        "$OUTDIR\\кафедра.pps" \
        "" \
        "$OUTDIR\\Rosanov1.ico"
    StrCpy $R0 "DEPARTMENT"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\DEPARTMENT"
    Delete "$DESKTOP\\24_О_кафедре_нормальной_физиологии.lnk"
    StrCpy $R0 "DEPARTMENT"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section HEALTH_WAY
  StrCpy $R0 "HEALTH_WAY"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\HEALTH_WAY"
    File /r ".\\soft\\HEALTH_WAY\"
    CreateShortcut \
        "$DESKTOP\\25_Путь_в_страну_здоровья.lnk" \
        "$OUTDIR\\Way.ppsx" \
        "" \
        "$OUTDIR\\Run1.ico"
    StrCpy $R0 "HEALTH_WAY"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\HEALTH_WAY"
    Delete "$DESKTOP\\25_Путь_в_страну_здоровья.lnk"
    StrCpy $R0 "HEALTH_WAY"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section Modern_Physiol_Lectures
  StrCpy $R0 "Modern_Physiol_Lectures"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$TEMP"
    File ".\\soft\\7z.exe"
    File ".\\soft\\7z.dll"
    ExecWait '7z.exe x -o"$PROGRAMFILES\\NormPhys\\shttps\\www\\Modern_Physiol_Lectures" "$EXEDIR\\Modern_Physiol_Lectures.zip"'
    Delete "7zip.exe"
    Delete "7zip.dll"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\Modern_Physiol_Lectures"
    CreateShortcut \
        "$DESKTOP\\26_Современный_курс_классической_физиологии.lnk" \
        "http://localhost:1025/Modern_Physiol_Lectures/index.htm" \
        "" \
        "$OUTDIR\\Logo2.ico"
    StrCpy $R0 "Modern_Physiol_Lectures"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
    RMDir /r "$OUTDIR\\Modern_Physiol_Lectures"
    Delete "$DESKTOP\\26_Современный_курс_классической_физиологии.lnk"
    StrCpy $R0 "Modern_Physiol_Lectures"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section Orlov_Nozdrachev
  StrCpy $R0 "Orlov_Nozdrachev"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\Nozdrachev"
    File /r ".\\soft\\Nozdrachev\"
    CreateShortcut \
        "$DESKTOP\\27_Учебник_Орлова_и_Ноздрачева.lnk" \
        "http://localhost:1025/Nozdrachev/pages/head.htm" \
        "" \
        "$OUTDIR\\Dept1.ico"
    StrCpy $R0 "Orlov_Nozdrachev"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
    RMDir /r "$OUTDIR\\Orlov_Nozdrachev"
    Delete "$DESKTOP\\27_Учебник_Орлова_и_Ноздрачева.lnk"
    StrCpy $R0 "Orlov_Nozdrachev"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section SpO2
  StrCpy $R0 "SpO2"
  Call registryStatus

  ${If} $R0 == "install"
    SetOutPath "$TEMP"
    File ".\\soft\\SpO2\\vcredist_x86.exe"
    ExecWait "$TEMP\\vcredist_x86.exe /Q"
    Delete "$TEMP\\vcredist_x86.exe"
    SetOutPath "$TEMP\\VCP"
    File /r ".\\soft\\SpO2\\CP210x_VCP\"
    ExecWait "installslabvcp.bat"
    SetOutPath "$PROGRAMFILES\\NormPhys\\SpO2"
    RMDir /r "$TEMP\\VCP"
    File /r ".\\soft\\SpO2\\SpO2\"
    ExecWait 'regSvr32 "$OUTDIR\\50KReview\\Step\\MSCHRT20.OCX"'
    CreateShortcut \
        "$DESKTOP\\28_SpO2_Assistant.lnk" \
        "$OUTDIR\\SpO2.exe" \
        "" \
        "$OUTDIR\\Ico_blood.ico"
    StrCpy $R0 "SpO2"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$TEMP"
    File ".\\soft\\SpO2\\CP210x_VCP\\deleteslabvcp.bat"
    ExecWait "$OUTDIR\\deleteslabvcp.bat"
    Delete "$OUTDIR\\deleteslabvcp.bat"
    ExecWait "MsiExec.exe /X{7299052b-02a4-4627-81f2-1818da5d550d} /quiet /qn"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    ExecWait 'regSvr32 /u "$OUTDIR\\SpO2\\50KReview\\Step\\MSCHRT20.OCX"'
    RMDir /r "$OUTDIR\\SpO2"
    StrCpy $R0 "SpO2"
    StrCpy $R1 ""
    Call setRegistryStatus
    Delete "$DESKTOP\\28_SpO2_Assistant.lnk"
  ${EndIf}
SectionEnd

Section SoundsHz
  StrCpy $R0 "SoundsHz"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\SoundsHz"
    File /r ".\\soft\\SoundsHz\"
    CreateShortcut \
        "$DESKTOP\\SoundsHz.lnk" \
        "$OUTDIR\\SoundsHz.exe" \
        "" \
        "$OUTDIR\\sin.ico"
    StrCpy $R0 "SoundsHz"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\SoundsHz"
    Delete "$DESKTOP\\SoundsHz.lnk"
    StrCpy $R0 "SoundsHz"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section Sheffield
  StrCpy $R0 "Sheffield"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$DESKTOP\\Sheffield_Biosciences"
    SetOutPath "$PROGRAMFILES\\NormPhys\\Sheffield_Biosciences"
    File /r ".\\soft\\Sheffield_Biosciences\"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Autonomic_Pharmacology.lnk" \
        "$OUTDIR\\Autonomic_Pharmacology\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Blood_Coagulation.lnk" \
        "$OUTDIR\\Blood_Coagulation\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Blood_Physiology.lnk" \
        "$OUTDIR\\Blood_Physiology\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Cellular_Respiration.lnk" \
        "$OUTDIR\\Cellular_Respiration\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Chest_Clinic.lnk" \
        "$OUTDIR\\Chest_Clinic\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Circulatory_Vessels.lnk" \
        "$OUTDIR\\Circulatory_Vessels\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Clinical_Aspects_of_Pain.lnk" \
        "$OUTDIR\\Clinical_Aspects_of_Pain\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Epilepsy.lnk" \
        "$OUTDIR\\Epilepsy\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Exercise_Physiology.lnk" \
        "$OUTDIR\\Exercise_Physiology\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Experimental_Design.lnk" \
        "$OUTDIR\\Experimental_Design\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Frog_Heart.lnk" \
        "$OUTDIR\\Frog_Heart\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Guinea_Pig_Ileum.lnk" \
        "$OUTDIR\\Guinea_Pig_Ileum\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Inflammation.lnk" \
        "$OUTDIR\\Inflammation\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Insulin_Glucagon.lnk" \
        "$OUTDIR\\Insulin_Glucagon\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Intestinal_Absorption.lnk" \
        "$OUTDIR\\Intestinal_Absorption\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Intestinal_Motility.lnk" \
        "$OUTDIR\\Intestinal_Motility\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Introduction_to_Endocrinology.lnk" \
        "$OUTDIR\\Introduction_to_Endocrinology\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Langendorff_Heart.lnk" \
        "$OUTDIR\\Langendorff_Heart\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Muscle_Physiology.lnk" \
        "$OUTDIR\\Muscle_Physiology\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Nerve_Biophysics_Tutorials.lnk" \
        "$OUTDIR\\Nerve_Biophysics_Tutorials\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Nerve_Physiology.lnk" \
        "$OUTDIR\\Nerve_Physiology\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Neuromuscular_Junction.lnk" \
        "$OUTDIR\\Neuromuscular_Junction\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Neuromuscular_Pharmacology.lnk" \
        "$OUTDIR\\Neuromuscular_Pharmacology\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Nictitating_Membrane.lnk" \
        "$OUTDIR\\Nictitating_Membrane\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Parathyroid_Glands.lnk" \
        "$OUTDIR\\Parathyroid_Glands\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Rat_Blood_Pressure.lnk" \
        "$OUTDIR\\Rat_Blood_Pressure\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Renal_Function_in_Humans.lnk" \
        "$OUTDIR\\Renal_Function_in_Humans\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Respiratory_Pharmacology.lnk" \
        "$OUTDIR\\Respiratory_Pharmacology\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Respiratory_Physiology.lnk" \
        "$OUTDIR\\Respiratory_Physiology\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\The_Heart.lnk" \
        "$OUTDIR\\The_Heart\\click_me.exe"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\Thyroid_Glands.lnk" \
        "$OUTDIR\\Thyroid_Glands\\click_me.exe"
    SetOutPath "$PROGRAMFILES\\NormPhys\\Sheffield_Biosciences\\PKSIMS"
    CreateShortcut \
        "$DESKTOP\\Sheffield_Biosciences\\PKSIMS.lnk" \
        "$OUTDIR\\RUN.bat"
    StrCpy $R0 "Sheffield"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\Sheffield_Biosciences"
    SetOutPath "$DESKTOP"
    RMDir /r "$OUTDIR\\Sheffield_Biosciences"
    StrCpy $R0 "Sheffield"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section Nobel
  StrCpy $R0 "Nobel"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\Nobel"
    File /r ".\\soft\\Nobel\"
    CreateShortcut \
        "$DESKTOP\\Все_нобелевские_лауреаты_по_медицине.lnk" \
        "http://localhost:1025/Nobel/All Nobel Laureates in Medicine.htm"
    StrCpy $R0 "Nobel"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
    RMDir /r "$OUTDIR\\Nobel"
    Delete "$DESKTOP\\Все_нобелевские_лауреаты_по_медицине.lnk"
    StrCpy $R0 "Nobel"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section Smoking
  StrCpy $R0 "Smoking"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www\\Smoking"
    File /r ".\\soft\\Smoking\"
    CreateShortcut \
        "$DESKTOP\\Курение.lnk" \
        "http://localhost:1025/Smoking/Содержание.htm"
    StrCpy $R0 "Smoking"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys\\shttps\\www"
    RMDir /r "$OUTDIR\\Smoking"
    Delete "$DESKTOP\\Курение.lnk"
    StrCpy $R0 "Smoking"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section BPRAT
  StrCpy $R0 "BPRAT"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\BPRAT"
    File /r ".\\soft\\BPRAT\"
    CreateShortcut \
        "$DESKTOP\\BPRAT.lnk" \
        "$OUTDIR\\run.bat"
    StrCpy $R0 "BPRAT"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\BPRAT"
    Delete "$DESKTOP\\BPRAT.lnk"
    StrCpy $R0 "BPRAT"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section NERVE
  StrCpy $R0 "NERVE"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\NERVE"
    File /r ".\\soft\\NERVE\"
    CreateShortcut \
        "$DESKTOP\\NERVE.lnk" \
        "$OUTDIR\\run.bat"
    StrCpy $R0 "NERVE"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\NERVE"
    Delete "$DESKTOP\\NERVE.lnk"
    StrCpy $R0 "NERVE"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section MECINHEM
  StrCpy $R0 "MECINHEM"
  Call registryStatus
  ${If} $R0 == "install"
    SetOutPath "$PROGRAMFILES\\NormPhys\\Mechanisms_in_hematology"
    File /r ".\\soft\\Mechanisms_in_hematology\"
    CreateShortcut \
        "$DESKTOP\\Mechanisms_in_hematology.lnk" \
        "$OUTDIR\\MECINHEM.exe"
    StrCpy $R0 "MECINHEM"
    StrCpy $R1 "installed"
    Call setRegistryStatus
  ${ElseIf} $R0 == "remove"
    SetOutPath "$PROGRAMFILES\\NormPhys"
    RMDir /r "$OUTDIR\\Mechanisms_in_hematology"
    Delete "$DESKTOP\\Mechanisms_in_hematology.lnk"
    StrCpy $R0 "MECINHEM"
    StrCpy $R1 ""
    Call setRegistryStatus
  ${EndIf}
SectionEnd

Section cleanup
  SetOutPath "$PROGRAMFILES"
  EnumRegValue $0 HKCU "Software\NormPhysAdmin" 0
  ${If} $0 == ""
    DeleteRegKey /ifempty HKCU "Software\NormPhysAdmin"
    RMDir /r "$OUTDIR\\NormPhys"
  ${EndIf}
SectionEnd

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE English
