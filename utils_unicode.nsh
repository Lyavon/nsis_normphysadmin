!include ".\constants.nsh"

!ifndef UTILS_UNICODE_NSH
!define UTILS_UNICODE_NSH

!macro notifyOfUnknownVersion appName version
  MessageBox \
      MB_ICONSTOP|MB_TOPMOST|MB_OK \
      "Невозможно удалить приложение ${appName}: неизвестная версия (${version})"
!macroend

!endif
