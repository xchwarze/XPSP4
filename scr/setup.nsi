!include Sections.nsh
!include LogicLib.nsh
!include FileFunc.nsh
!insertmacro GetParameters
!insertmacro GetOptions

!define APPNAME "[ Windows XP SP4 ]"
;AutoCloseWindow True
RequestExecutionLevel user
SetCompressor /SOLID lzma
SetDatablockOptimize on
CRCCheck on

; Config extra
;!define /date MYTIMESTAMP "%Y-%m-%d"
OutFile "setup.exe"
Caption "${APPNAME}"
InstallDir "$WINDIR\sp4dsr"
Var /GLOBAL SWITCHS
Var /GLOBAL SWITCHS2
Var /GLOBAL cmdLineParams
	
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
;!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_INSTFILES


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
	
	;Switchs!
	StrCpy $SWITCHS "/q /z /o"
	StrCpy $SWITCHS2 "/Q"
		
	;CMD deamon
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
		StrCpy $SWITCHS "/q /n /z /o"
		
	${GetOptions} $cmdLineParams '/ending' $R0
    IfErrors +2 0
		StrCpy $0 '777'
FunctionEnd


Section "Updates"
	IfFileExists "$WINDIR\cn.jpg" 0 +3
		MessageBox MB_OK|MB_ICONEXCLAMATION "Se detecto que ya encuentra instalado el SP4 en sistema. Borre el archivo $WINDIR\cn.jpg si quiere forzar la instalacion!"
		Abort

  	${If} $0 == '777'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb923561-x86-esn_f78e5fa8ba9f9f7da466fb8d6a575b7b6a2edd9e.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb923789-x86-esn_fee6045a3b698154ef25a4cbfc797477b0cde26b.exe" $SWITCHS2'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB946648-x86-ESN.exe" $SWITCHS'
		
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb950762-x86-esn_b3d6b01986038ce657fb580964b38731a892a6e9.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb950974-x86-esn_a5119a28a53bf80cab99e010a139cf162a740432.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb951376-v2-x86-esn_b329d94658364fcf1ab5fdce55fb1d76b5e36bc4.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb951748-x86-esn_f52a6e97fe16b9d8eefbadbaa98d0f77f7ffb059.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB951978-x86-ESN.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb952004-x86-esn_db80e5c829c059be087ade80faea54b69198bc31.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb952287-x86-esn_f17a951ffd5f18915b964613cc7d9d13e5c2aaf2.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb952954-x86-esn_9ae0cd16af424397ef94ffd131c2527dc1f410f1.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb954459-x86-esn_2a6cd99cf62747c8ab5c45224785bbeba34757f1.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb955759-x86-esn_1541fd5951e5bec10763371ae5f9b3a396e8a06f.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb956572-x86-esn_c658b04c8bf63ef4ff0b929c781628b544750d8d.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb956802-x86-esn_fec87096acbb42378aea966e83ecff2218e8f14d.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb956803-x86-esn_d6ca56227671355c50758be3156e27f8edc31cd6.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb956844-x86-esn_fcadfc5dcecd466983880fae7dbc47e84e8a509f.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb958644-x86-esn_3603582f035865c3bc5030cb4abba86fd56b7d66.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb958869-x86-esn_97a2d8e17906613121d1dbdfc4861754e75fad9b.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb959426-x86-esn_42fe49580d235418632894817d039cab9c42226f.exe" $SWITCHS'
		
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb960803-x86-esn_23e849c2107a84fb89e336c5aa97d690a05e550b.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb960859-x86-esn_10d58033bc57a00b1d84c4e42214e60b3c10010c.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb961501-x86-esn_500de4f8025b5a578b5278ca93a591d32aaa34da.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB967715-x86-ESN.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB968389-x86-ESN.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB969084-x86-esn.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb969059-x86-esn_111d5c62f981df94d1b61b0ad930af25cc85fe25.exe" $SWITCHS'		

		; acomodar a partir de aca
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb973869-x86-esn_816c392cf124bcf62fff4699cd3575205b293789.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb973507-x86-esn_d7ad78fc5775db6c8274b56f410f039480c06eee.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb973815-x86-esn_96cd3bd57fb87653d5310a3138e24561a9f504d8.exe" $SWITCHS'
		
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB971029-x86-ESN.exe" $SWITCHS'
		
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb971657-x86-esn_38287b0aec013cc544bf83ad8cc88597a24010b1.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb975025-x86-esn_83e430588396ceea975004720ecebad5a6430863.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb974571-x86-esn_39101a08166b7e3cc45923d16f78e5a0a9ede6aa.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb974112-x86-esn_4f81b88be217419a46ad75af10740cdb5f008615.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb974318-x86-esn_6cb80a3d409cb698bbf9f929608518b79ec9d24c.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb974392-x86-esn_13e8d4868893a94403d1f68582e5760b274a8f20.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb973904-x86-esn_d5f660090b27ce25c0c5176763eaa849e5700e89.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb972270-x86-esn_47dbba036639d9ea1427b66b97bb6a746c67efc3.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb975713-x86-esn_2467d31a0f83b5e9795b90d6d16c1df666db8a22.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb975560-x86-esn_de969b185b99f3191863d07f09decbc81ca424a5.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb977914-x86-esn_6603510c306d001782e699a09e224532ff2b3535.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb978706-x86-esn_16ca7cf78951f1901a56cb833d243b7f7ab7e837.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb977816-x86-esn_2d67834dd54c564084b6a9539be4449b92c95b75.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb979309-x86-esn_2fcd36d0648b030638e863f5b19489ff537ebae6.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb978338-x86-esn_af1130623f5456b2838230a86a4bd51d0dcf9749.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb978601-x86-esn_c5144df69ba73dc131fb604fa68f014894454401.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb978542-x86-esn_a6329e11e249832fb20cbda5b097e58887bb9d4f.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb979482-x86-esn_187b62f8e4c7deca25d48b80f4c03a9f53afce8c.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb975562-x86-esn_dfce4f0577f317e6d3bb38a3e9aa16982c351603.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb979687-x86-esn_5ac7643c4532f508bf70222e418cbf36f3b8ce66.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb973687-x86-esn_55b88761db4066a945a13ca253243ed9a408f641.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB970430-x86-ESN.exe" $SWITCHS'	
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB975467-x86-ESN.exe" $SWITCHS'		
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB971737-x86-ESN\update\update.exe" $SWITCHS'

		ExecWait '"$INSTDIR\KBHell\windowsxp-kb980232-x86-esn_21314c6e719a9d818a80f482357200b66d8c4b8a.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb980195-x86-esn_da2ee0f1d818f1967fb3bd80313fc12eb111bdac.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2229593-x86-esn_01aec1f656ad07698412c7fd98df617aa24dc67f.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2115168-x86-esn_cbcf2cdbaf07efc8155477e1b43b1e1aa3677cb5.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb982665-x86-esn_d6909194fc694dc716ffed90f57cf97000c211c9.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb982214-x86-esn_c78309951a612ca6ceab5bd3fba1b0aed02bd7af.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb981997-x86-esn_076ace642346c8e2fb308937c2e49c55dceae8b1.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb980436-x86-esn_c4bdb1c50a71c44713a5982fea29ea6dcc203ce4.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2259922-x86-esn_feccf5ff737b926e001ff055bc45590adf93a9df.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb981322-x86-esn_6ffa88605b6b1ce620bd21e58897a5e4b79d2343.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2121546-x86-esn_78d44af9aae1f92eb8d0ae19bc3eeecfa0ff2b3d.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2347290-x86-esn_25baf732c3e807fd362dd04e36445f9d7b5c1a79.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2296011-x86-esn_11e8136898ffa3296097a3b0f9bc75b5a3cd9ead.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2387149-x86-esn_c7c4046fd88a56b74e96f1f832821fbd012f879e.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb982132-x86-esn_20de786b69b5e2e65f5d10eecc62522c2f9c4ead.exe" $SWITCHS'

		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB2141007-x86-ESN\update\update.exe" $SWITCHS'

		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB2345886-x86-ESN.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2360937-x86-esn_d1b76ef8c2ab4d5fbaed26ec6bd04e85fbd00343.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2393802-x86-esn_cad31e47968b1c2bb7dcf35e9327726599bb03f3.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2079403-x86-esn_e0f04ac1403eb17687f287f6a7db256956908f9a.exe" $SWITCHS'

		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2423089-x86-esn_5d057e88b08afa36f605c8edda11636dfc81c10c.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2443105-x86-esn_f7d3b0530b16276dc2a173e5aaf2de63fe089a48.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2443685-x86-esn_f46603772f3d104a6b506e677fd1f4c414eb7215.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2440591-x86-esn_42902ccfd0796bdfaf0edefcc757c85ed73ab7d9.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2419632-x86-esn_3c29d8748dac260b7bf97a00e541b9132765726b.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2478971-x86-esn_65a56b64d1a66690cee8f71b5d21c2ebab7196ec.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2483185-x86-esn_2f993e8e5f06f4de0e77f1cb01a0adcde448bee7.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2479628-x86-esn_786541eee43b773ddea437af59b6f4a580ad2382.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2478960-x86-esn_7d48644131c5f9a3163a1a7d42e4b7faeb181180.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2485376-x86-esn_a7527663c37bfcb05d9041a37d5226b58e4fa56a.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2476687-x86-esn_46a6af73a48b66454344e145328d0a64cd9aa45c.exe" $SWITCHS'
		

		; Actualizaciones 2012	
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB2412687-x86-ESN.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB2503658-x86-ESN.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB2506223-x86-ESN.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB2508272-x86-ESN.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB2511455-x86-ESN.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2524375-x86-esn_25266d3ff6a54bfe2bff59a39107c6ff4950985f.exe" $SWITCHS'

		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2479943-x86-esn_85da9bce423b9f8c15cbf2d3338a5995ad8c58b1.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2483614-x86-esn_036ebb23f1f1735188427106b4be0b41c05110ff.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2485663-x86-esn_888e0e49e6b65fbe943b49d121ed529da1d5319f.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2508429-x86-esn_88436bc6091f0daf67d09c8480a14ecf95e31e34.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2506212-x86-esn_7b031294805f49ec025b9b10078355c64b10e62f.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2507618-x86-esn_4c069fa5d3bfa9a831783a3246f3481ccd8778e5.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2509553-x86-esn_287767dc3a62971433598db6ea47b10a658b1819.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2535512-x86-esn_e808d94133fe99482cd6ccf5a3dc7ef026d33adc.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2476490-x86-esn_358ba8f13e46f4a3cc0659c84cc67e6b4a7f75f6.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2507938-x86-esn_32a55b7f17213ed0fb1a6f613a4a927dae34d570.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2566454-x86-esn_ea935184fe394d86eb52352d3a27a714a920e770.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2536276-v2-x86-esn_8d03490a579a46c12f767e33552d915f7ac74592.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2570947-x86-esn_9dd2cd1e344d87f0baa9b00f875ac3d1f1f90e90.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2592799-x86-esn_58bf59f121c333e1b989f23617a4907192ba83c2.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windows-es-es-kb2564958_c29836d3fd610263d469f025b1c49ed43a29cc1c.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2544893-v2-x86-esn_a6ae2555cd1950461892e7254fa105d7f7addfe0.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2624667-x86-esn_0885183a8b8891c241deb709897a8fa1a71b5e50.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2618451-x86-esn_9e74a26b6bf4ea8dff6a19e5fa8bf235dbd35f90.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2619339-x86-esn_856abe67ec864ec45f42516a93d3b21153c3afe7.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2620712-x86-esn_73fcec7093986c8aab536775c19116166cb691d7.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2633952-x86-esn_0fc117e1e69a3ff792791b646bfe32f251840b6c.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2584146-x86-esn_4ec6819250d7ba900b97aeac4557d9f5c0db46c4.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2631813-x86-esn_ab4ade44bdd3c88bcdab2bf451e43a02ccda6619.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2585542-x86-esn_2bf175409263f1c0332868932afd7b9f3907a2a0.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2603381-x86-esn_af48474f702be68e40e838012f9493da02004349.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2598479-x86-esn_c4efd25bac61ca7dc23df13d0221d9fc72178ced.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2646524-x86-esn_c4dc790b1b8a945bd02ab38a831a06aae37dece6.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2661637-x86-esn_c8ffab0cf2d8fbd98626df8446c600e61d45c53e.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2653956-x86-esn_6f3c0fe9a4b7b728d81dbbb00cee78326b15a6cb.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2695962-x86-esn_2ede09076ce842870064de4721e03889414bb31f.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2676562-x86-esn_c359f53aa96637f10544eb2f4822d21b1613d13a.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2659262-x86-esn_c80a8bce264b4002aa92488323b8f34346386c65.exe" $SWITCHS'
		
		; esta dos veces por algo
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2686509-x86-esn_026b90090a69972e318014d84cbce7d28dc12b6c.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2686509-x86-esn_d3467067d016fb8a73001c4ecc246b13d58889a1.exe" $SWITCHS'
		
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2707511-x86-esn_1c8ef56b4c3748a51224765ba469f03daa03382a.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2709162-x86-esn_3ebc991a42c406cd892eb2f25baa199ef736f8a9.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb2685939-x86-esn_585e96e6db7eba36e96a46c467b4552cce1d9d73.exe" $SWITCHS'
		
		ExecWait '"$INSTDIR\KBHell\Windowsxp-kb2718704-x86\update\update.exe" $SWITCHS'

	
		; Extras
		ExecWait '"$INSTDIR\KBHell\rootsupd.exe" $SWITCHS2'
		
		
		; IExxxx
		${GetOptions} $cmdLineParams '/ieupdate' $R0
		IfErrors +9 0
		ExecWait '"$INSTDIR\KBHell\ie8-windowsxp-kb971961-x86-esn_782a03cb5e84c98f3e27a7d7bf16ede6c3c3fc0c.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\ie8-windowsxp-kb976662-x86-esn_5a6d12552d490f9bb495f53059cdd4bd5a6a42a4.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\ie8-windowsxp-kb981332-x86-esn_b38d2675ceacc29499330b40716c1f78d98ed3bf.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\ie8-windowsxp-kb2482017-x86-esn_d4591f83cbc9b5b10a3916b111cbc79f73777743.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\IE8-WindowsXP-KB2497640-x86-ESN.exe" $SWITCHS'	
		ExecWait '"$INSTDIR\KBHell\ie8-windowsxp-kb2510531-x86-esn_5d4bbb87e597090dbb5595df8b2eef0201cdc7e7.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\ie8-windowsxp-kb2544521-x86-esn_6f6999addfbc3312fa0e01124b9879b3f7681ed1.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\ie8-windowsxp-kb2699988-x86-esn_aea6e2f646268de066b110472ec56618fd19f580.exe" $SWITCHS'

		; windowsmedia
		${GetOptions} $cmdLineParams '/wmpupdate' $R0
		IfErrors +6 0
		ExecWait '"$INSTDIR\KBHell\windowsxp-windowsmedia-kb954155-x86-esn_6b64d3ecd9016b2cbe29a70e64493470f7f7914b.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-windowsmedia-kb973540-x86-esn_b6d5c62d069723ac7a86a40151d9ab3462a17b57.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-windowsmedia-kb978695-x86-esn_55c5c2b1c6505a03af17c6eb8f234e06984785b9.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-windowsmedia-kb975558-x86-esn_17e6ce9414f0e1eb807ce20c8557878965f86fe8.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\windowsxp-windowsmedia-kb2378111-x86-esn_5fa2d72a5d83441f38a3c0d25cb8ebe620203b25.exe" $SWITCHS'
		
		
		# Misc
		DeleteRegValue HKLM SOFTWARE\Microsoft\Windows\CurrentVersion\Run "SP4 Installer"
		WriteRegStr HKEY_CURRENT_USER "Software\Microsoft\Internet Explorer\Main" "Start Page" "http://www.exocet.com.ar"
		WriteRegStr HKEY_CURRENT_USER ".DEFAULT\Software\Microsoft\Internet Explorer\Main" "Start Page" "http://www.exocet.com.ar"
		WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" "EnableQuickReboot" "1"
		WriteRegDWORD HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Session Manager" "AutoChkTimeOut" 0x3
		WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" "Enable" "Y"
		WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" "LcnStartLocation" "0"
		WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" "LcnEndLocation" "0"
		WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" "OptimizeComplete" "No"
		WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" "OptimizeError" "Not Run"
		WriteRegStr HKEY_CURRENT_USER "Control Panel\Keyboard" "KeyboardDelay" "0"
		WriteRegStr HKEY_CURRENT_USER "Control Panel\Keyboard" "KeyboardSpeed" "31"
		WriteRegDWORD HKEY_CURRENT_USER "Software\Microsoft\Windows\CurrentVersion\InternetSettings" "“MaxConnectionsPer1_0Server”" 0xa
		WriteRegDWORD HKEY_CURRENT_USER "Software\Microsoft\Windows\CurrentVersion\InternetSettings" "“MaxConnectionsPerServer”" 0xa
		
		SetOutPath "$WINDIR"
		SetOverwrite on
		File /r ".\Misc\*.*"
				
		# wmpfix 
		${GetOptions} $cmdLineParams '/wmpfix' $R0
		IfErrors +3 0
			SetOutPath "$PROGRAMFILES\Windows Media Player"
			File "LegitLibM.dll"
			
		# agregados visuales nuevos
		${GetOptions} $cmdLineParams '/uiupdate' $R0
		IfErrors +7 0
			SetOutPath "$TEMP"
			File "utp.exe"
			ExecWait '"$TEMP\utp.exe" -silent'
			Delete '"$TEMP\utp.exe"'
			SetOutPath "$WINDIR\Resources\Themes"
			File /r ".\Themes\*.*"
		
		# directx
		${GetOptions} $cmdLineParams '/directx' $R0
		IfErrors +4 0
			SetOutPath "$DESKTOP"
			File "dxwebsetup.exe"
			Exec '"$DESKTOP\dxwebsetup.exe"'
			
		# cleanup
		${GetOptions} $cmdLineParams '/cleanup' $R0
		IfErrors +2 0
			RMDir /r "$WINDIR\sp4dsr"
	${Else}
		# 1 Tanda
		SetOutPath "$WINDIR\sp4dsr"
		ExecWait '"$INSTDIR\KBHell\WindowsUpdateAgent30-x86.exe" /wuforce /quiet /norestart'
		ExecWait '"$INSTDIR\KBHell\windowsxp-kb898461-x86-esn_a210d3cf72ec7a3067d2e4bdd5fed46f5bb8bf68.exe" $SWITCHS'
		ExecWait '"$INSTDIR\KBHell\WindowsXP-KB942288-v3-x86.exe" /quiet /norestart'
		
		${GetOptions} $cmdLineParams '/ieupdate' $R0
		IfErrors +3 0
		${GetFileVersion} "$PROGRAMFILES\Internet Explorer\iexplore.exe" $R1
		${If} $R1 < "8"
			ExecWait '"$INSTDIR\KBHell\ie8-windowsxp-x86-esn_297c2f54751058a07d3ffb091755150dc8437b8b.exe" /quiet /update-no /no-default /norestart'
		${EndIf}
		
		${GetOptions} $cmdLineParams '/wmpupdate' $R0
		IfErrors +3 0
		${GetFileVersion} "$PROGRAMFILES\Windows Media Player\wmplayer.exe" $R1
		${If} $R1 < "11"
			ExecWait '"$INSTDIR\KBHell\wmp11-windowsxp-x86-ES-ES.exe" $SWITCHS2'
		${EndIf}
		
		WriteRegStr HKLM SOFTWARE\Microsoft\Windows\CurrentVersion\Run "SP4 Installer" '"$WINDIR\sp4dsr\setup.exe" /ending $cmdLineParams'
	${EndIf}
	
	Exec '"$WINDIR\system32\shutdown.exe" -r -f -t 10 -c "Se reniciara el equipo para completar el proceso de instalacion."'
SectionEnd
;EOF