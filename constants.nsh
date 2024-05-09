; constants.nsh contains global constants that define how installer looks
; and behaves (version, icons, colors, registry etc).

!include ".\constants_unicode.nsh"

!ifndef CONSTANTS_NSH
!define CONSTANTS_NSH

!define ADMIN_VERSION 1
!define ADMIN_REGISTRY_ROOT HKLM
!define ADMIN_REGISTRY_PATH "Software\NormPhysAdmin"

!define ADMIN_PATH "$PROGRAMFILES\\NormPhysAdmin"
!define SOURCE_PATH ".\\soft"

!define MUI_INSTFILESPAGE_COLORS "DDDDDD 222222"
!define MUI_ICON "icon.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "header_icon.bmp"

!define PHYSIOL2
!define PHYSIOL2_VERSION 1
!define PHYSIOL2_UI_NAME "01_PHYSIOL2"

!define NMJ
!define NMJ_VERSION 1
!define NMJ_UI_NAME "02_NMJ"

!define TWITCH
!define TWITCH_VERSION 1
!define TWITCH_UI_NAME "03_TWITCH"

!define PRAT
!define PRAT_VERSION 1
!define PRAT_UI_NAME "04_PRAT"

!define EYE_TESTS
!define EYE_TESTS_VERSION 1
!define EYE_TESTS_UI_NAME "05_EyeTests"

!define RABKIN_TABLES
!define RABKIN_TABLES_VERSION 1

!define HEARTSND
!define HEARTSND_VERSION 1
!define HEARTSND_UI_NAME "07_Heart_Sounds"


!define PHYSIOLOGY
!define PHYSIOLOGY_VERSION 1
!define PHYSIOLOGY_UI_NAME "09_Physiology"

!define BREATH_CYCLE
!define BREATH_CYCLE_VERSION 1


!define HCT_ENG
!define HCT_ENG_VERSION 1
!define HCT_ENG_UI_NAME "12_Hematocrit"

!define HCT_RUS
!define HCT_RUS_VERSION 1

!define PHYSIO_EX
!define PHYSIO_EX_VERSION 1
!define PHYSIO_EX_UI_NAME "14_PhysioEx"

!define FINK
!define FINK_VERSION 1
!define FINK_UI_NAME "16_FINK"

!define INUTRITION
!define INUTRITION_VERSION 1
!define INUTRITION_UI_NAME "17_iNutrition"

!define KIDNEY_ENG
!define KIDNEY_ENG_VERSION 1
!define KIDNEY_ENG_UI_NAME "18_Kidney"

!define KIDNEY_RUS
!define KIDNEY_RUS_VERSION 1


!define LUSHER
!define LUSHER_VERSION 1

!define DEPARTMENT
!define DEPARTMENT_VERSION 1

!define HEALTH_WAY
!define HEALTH_WAY_VERSION 1

!define SPO2
!define SPO2_VERSION 1
!define SPO2_UI_NAME "28_SpO2_Assistant"


!define SOUNDS_HZ
!define SOUNDS_HZ_VERSION 1
!define SOUNDS_HZ_UI_NAME "SoundsHz"

!define SHEFFIELD
!define SHEFFIELD_VERSION 1
!define SHEFFIELD_UI_NAME "Sheffield_Biosciences"


!define BPRAT
!define BPRAT_VERSION 1
!define BPRAT_UI_NAME "BPRAT"

!define NERVE
!define NERVE_VERSION 1
!define NERVE_UI_NAME "NERVE"

!define MECINHEM
!define MECINHEM_VERSION 1
!define MECINHEM_UI_NAME "Mechanisms_in_Hematology"

!endif
