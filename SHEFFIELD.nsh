!include ".\constants.nsh"
!include ".\registry.nsh"
!include ".\utils.nsh"

!ifndef SHEFFIELD_NSH
!define SHEFFIELD_NSH

Function SHEFFIELD_INSTALL
  SetOutPath "$DESKTOP\\Sheffield_Biosciences"
  SetOutPath "${ADMIN_PATH}\\SHEFFIELD"
  File /r "${SOURCE_PATH}\\SHEFFIELD\"
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
  SetOutPath "$OUTDIR\\PKSIMS"
  CreateShortcut \
      "$DESKTOP\\Sheffield_Biosciences\\PKSIMS.lnk" \
      "$OUTDIR\\PKSIMS_START.exe" \
      "-fullscreen"

  Push $R0
  Push $R1
  StrCpy $R0 "SHEFFIELD"
  StrCpy $R1 "installed"
  Call setRegStatus
  StrCpy $R1 "1"
  Call setRegVersion
  Pop $R1
  Pop $R0
FunctionEnd

!macro SHEFFIELD_REMOVE un
Function ${un}SHEFFIELD_REMOVE
  Push $R0
  Push $R1

  StrCpy $R0 "SHEFFIELD"
  Call ${un}regVersion
  Pop $R1
  ${If} $R1 == "1"
    StrCpy $R0 "${ADMIN_PATH}\\SHEFFIELD"
    Call ${un}removeDirectory
    StrCpy $R0 "$DESKTOP\\Sheffield_Biosciences"
    Call ${un}removeDirectory
    StrCpy $R0 "SHEFFIELD"
    Call ${un}regDelete
  ${Else}
    !insertmacro notifyOfUnknownVersion "SHEFFIELD" $R1
  ${EndIf}

  Pop $R1
  Pop $R0
FunctionEnd
!macroEnd
!insertmacro SHEFFIELD_REMOVE ""
!insertmacro SHEFFIELD_REMOVE "un."

Function SHEFFIELD_UPDATE
FunctionEnd

!insertmacro createInstallSection SHEFFIELD
!insertmacro createUninstallSection SHEFFIELD

!endif
