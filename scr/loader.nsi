!include Sections.nsh
!include LogicLib.nsh
!include FileFunc.nsh
!insertmacro GetParameters
!insertmacro GetOptions

!define APPNAME "[ Windows XP SP4 ]"
AutoCloseWindow True
RequestExecutionLevel user
SetCompressor /SOLID lzma
SetDatablockOptimize on
CRCCheck on

; Config extra
!define /date MYTIMESTAMP "%Y-%m-%d"
OutFile "Windows XP SP4 Build ${MYTIMESTAMP}.exe"
Caption "${APPNAME}"
InstallDir "$WINDIR\sp4dsr"
Var /GLOBAL PARAMETROS
	
VIProductVersion "2.0.0.0"
VIAddVersionKey /LANG=1033 "ProductName" "Windows XP SP4"
VIAddVersionKey /LANG=1033 "CompanyName" "Exocet"
VIAddVersionKey /LANG=1033 "FileDescription" "Desarrollado por DSR!"
VIAddVersionKey /LANG=1033 "FileVersion" "2.0.0.0"



!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP ".\modern-header.bmp"
/*
;!define MUI_COMPONENTSPAGE_SMALLDESC
!define MUI_COMPONENTSPAGE_TEXT_TOP "by DSR! -> www.SoportExocet.ar.gs"
!define MUI_COMPONENTSPAGE_TEXT_COMPLIST "Select actions to run:"
;!define MUI_COMPONENTSPAGE_TEXT_INSTTYPE ""
!define MUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO "Select the action to see the description"
*/
!define MUI_COMPONENTSPAGE_TEXT_DESCRIPTION_TITLE "Descripcion:"
BrandingText 'Desarrollado por Exocet - www.soportexocet.com.ar'	

!include "MUI2.nsh"
!define MUI_ICON ".\Icon Entry.ico"
!insertmacro MUI_LANGUAGE "Spanish"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES

Function Select1
	!insertmacro SelectSection 0
FunctionEnd
Function Select2
	!insertmacro SelectSection 1
FunctionEnd
Function Select3
	!insertmacro SelectSection 2
FunctionEnd
Function Select4
	!insertmacro SelectSection 3
FunctionEnd
Function Select5
	!insertmacro SelectSection 4
FunctionEnd
Function Select6
	!insertmacro SelectSection 5
FunctionEnd
Function Select7
	!insertmacro SelectSection 6
FunctionEnd


Function .onInit
	;Mutex
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "MutexEXSP4") i .r1 ?e'
	Pop $R0
	StrCmp $R0 0 +3
	MessageBox MB_OK|MB_ICONEXCLAMATION "El instalador ya esta corriendo!"
	Abort
	
	;chequear version de windows
	ReadRegStr $R0 HKLM \
		"SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion
	${If} $R0 > "5.1"
		MessageBox MB_OK|MB_ICONEXCLAMATION "No estas corriendo XP ($R0)"
		Abort
	${EndIf}
	
	ReadRegStr $R0 HKLM \
		"SOFTWARE\Microsoft\Windows NT\CurrentVersion" CSDVersion
	${If} $R0 != "Service Pack 3"
		MessageBox MB_OK|MB_ICONEXCLAMATION "El Windows no es Service Pack 3 ($R0)"
		Abort
	${EndIf}
	
	;CMD deamon
	Var /GLOBAL cmdLineParams
	Push $R0
	${GetParameters} $cmdLineParams
	ClearErrors
	
	${GetOptions} $cmdLineParams '/?' $R0
	IfErrors +3 0
	MessageBox MB_OK "Command line parameters: /nobackup /wmpfix /uiupdate /ieupdate /wmpupdate /directx /cleanup /S /?"
	Abort
	Pop $R0
	Push $R0
	
	${GetOptions} $cmdLineParams '/nobackup' $R0
    IfErrors +2 0
	Call Select1
		
	${GetOptions} $cmdLineParams '/wmpfix' $R0
    IfErrors +2 0
	Call Select2
	
	;nuevos
	${GetOptions} $cmdLineParams '/uiupdate' $R0
    IfErrors +2 0
	Call Select3
	
	${GetOptions} $cmdLineParams '/ieupdate' $R0
    IfErrors +2 0
	Call Select4
	
	${GetOptions} $cmdLineParams '/wmpupdate' $R0
    IfErrors +2 0
	Call Select5
	
	${GetOptions} $cmdLineParams '/directx' $R0
    IfErrors +2 0
	Call Select6
	
	${GetOptions} $cmdLineParams '/cleanup' $R0
    IfErrors +2 0
	Call Select7
FunctionEnd


Section /o "No backups" Section1
	StrCpy $PARAMETROS "/nobackup"
SectionEnd

Section /o "WMP11 Fix" Section2
	StrCpy $PARAMETROS "$PARAMETROS /wmpfix"
SectionEnd

Section /o "Themes patch and update" Section3
	StrCpy $PARAMETROS "$PARAMETROS /uiupdate"
SectionEnd

Section /o "IE update" Section4
	StrCpy $PARAMETROS "$PARAMETROS /ieupdate"
SectionEnd

Section /o "WMP update" Section5
	StrCpy $PARAMETROS "$PARAMETROS /wmpupdate"
SectionEnd
	
Section /o "DirectX update" Section6
	StrCpy $PARAMETROS "$PARAMETROS /directx"
SectionEnd
  
Section /o "Clean up" Section7
	StrCpy $PARAMETROS "$PARAMETROS /cleanup"
SectionEnd

Section "-hidden section"
;Section "Updates" Section1
	;MessageBox MB_OK $PARAMETROS
	SetOutPath "$WINDIR\sp4dsr"
	SetOverwrite on
	File /r ".\build\*.*"
	Exec '"$WINDIR\sp4dsr\setup.exe" $PARAMETROS'
SectionEnd


!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${Section1} "No hacer copias de seguridad para la desinstalacion de los parches aplicados."
	!insertmacro MUI_DESCRIPTION_TEXT ${Section2} "Forzar validacion de Windows Media Player."
	!insertmacro MUI_DESCRIPTION_TEXT ${Section3} "Despues de instalar el SP4 se coloca en el escritorio el updater dxwebsetup.exe para actualizar."
	!insertmacro MUI_DESCRIPTION_TEXT ${Section4} "Borrar copia de los parches usada por el instalador que esta alojada en $WINDIR\sp4dsr"
!insertmacro MUI_FUNCTION_DESCRIPTION_END
; DSR! / Exocet!