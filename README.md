Windows XP SP4
===

En 2011 hice un SP4 para actualizar rapidamente las maquinas en los trabajos. Con ayuda de los unos amigos sysadmins que tambien lo usaban logre pulir esta version que hice publica en 2012.


Info
-----------

* 153 Hoxfixes
* Windows Media Player 11
* Internet Explorer 8
* Soporte de Linea de Comando
* Windows Media Player 11 force validation
* DirectX 9 updater
* BootOptimizeFunction, EnableQuickReboot y algun tweak mas agregado
* Esta actualizado al 27/06/2012


Comandos soportados
-----------

* /nobackup :no realizar copias de seguridad de los archivos a actualizar
* /wmpfix   :fuerza la validacion del windows media player (solo usar en wmp11)
* /uiupdate :parchea uxtheme.dll para poder usar temas no firmados e instala Luna Royale, Panther y Zune
* /ieupdate :instala y actualiza ie8
* /wmpupdate:instala y actualiza wmp11		
* /directx  :al terminar coloca en el escritorio el updater de DirectX 9
* /cleanup  :borrar archivos usados por el instalador
* /S        :instalacion desatendida
* /?        :muestra los switch usados por linea de comando
* /ending   :usar solo si no se quiere instalar WindowsUpdateAgent30, kb898461, KB942288, ie8 ni wmp11
