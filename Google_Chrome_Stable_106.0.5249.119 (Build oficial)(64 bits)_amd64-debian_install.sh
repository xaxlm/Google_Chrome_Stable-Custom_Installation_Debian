#!/bin/bash
# Ultima actualización: 05/12/2024 Versión 131.0.6778.108 (Build oficial) (64 bits)
cd /
#
# Se descarga Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
mkdir /tmp/google
chmod 755 /tmp/google/
dpkg -x google-chrome-stable_current_amd64.deb /tmp/google/
cd /tmp/google/
tar czvf google-chrome-stable_current_amd64.tar.gz opt/ usr/ etc/
#
# Se confirma la existencia de dependencias necesarias
echo '>>> Ingresando a /usr/local/...'
cd /usr/local/
echo 'Instalando dependencias adicionales...'
apt-get install libindicator7 libdbusmenu-gtk4 libdbusmenu-glib4 libappindicator1 gconf-service libgconf-2-4 fonts-liberation xdg-utils
echo 'Dependencias instaladas...'
sleep 2
echo 'Se va a instalar en /usr/local/...'
read -p "Ingresa el nombre del directorio principal de instalacion, si no existe se creará: " DIRINST
if [ -d $DIRINST ];
	then
		echo 'El directorio ya existe...'
		echo '>>> Ingresando...'
		cd $DIRINST
	else
		echo 'El directorio no existe...'
		echo 'Creando directorio...'
		mkdir $DIRINST
		echo 'Directorio creado...'
		echo '>>> Ingresando...'
		cd $DIRINST
fi
sleep 2
mkdir google-chrome
cd google-chrome/
mv /tmp/google/google-chrome-stable_current_amd64.tar.gz .
tar xzvf google-chrome-stable_current_amd64.tar.gz
cd ../
#
# El directorio tiene que ser propiedad de root para actuar sobre éste
# SUID adecuados sobre google-sandbox para poder ejecutar el binario
chown -R root:root google-chrome/
chmod -R +x google-chrome/
chmod g-s google-chrome/
chmod 4755 google-chrome/opt/google/chrome/chrome-sandbox
#
#App a Menú
cd /usr/share/applications/
touch google-chrome.desktop
echo '[Desktop Entry]' > google-chrome.desktop
echo 'Version=131.0.6778.108 (Build oficial) (64 bits) empaquetado de .deb' >> google-chrome.desktop
echo 'Name=Google Chrome' >> google-chrome.desktop
echo 'Comment=Suite Navegador Web' >> google-chrome.desktop
echo 'Exec=/usr/local/'$DIRINST'/google-chrome/opt/google/chrome/google-chrome' >> google-chrome.desktop
echo 'Icon=/usr/local/'$DIRINST'/google-chrome/opt/google/chrome/product_logo_64.png' >> google-chrome.desktop
echo 'Categories=Network;' >> google-chrome.desktop
echo 'Terminal=false' >> google-chrome.desktop
echo 'Type=Application' >> google-chrome.desktop
cd /usr/local/$DIRINST/google-chrome/
#
#Remove
touch remove.sh
echo "#!/bin/bash" > remove.sh
echo "echo '------------------------------'" >> remove.sh
echo "echo 'Removiendo...'" >> remove.sh
echo 'apt-get remove libindicator7 libdbusmenu-gtk4 libdbusmenu-glib4 libappindicator1' >> remove.sh
echo "echo -ne '[===>                                    ]( 8.33%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[=========>                              ](16.66%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[============>                           ](24.99%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[===============>                        ](33.32%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[==================>                     ](41.65%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[=====================>                  ](49.98%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[========================>               ](58.31%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[===========================>            ](66.64%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[==============================>         ](74.97%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[=================================>      ](83.30%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[====================================>   ](91.64%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '[=======================================>](100.00%)\r';sleep 0.2" >> remove.sh
echo "echo -ne '\n'" >> remove.sh
echo 'cd /' >> remove.sh
echo 'rm -rf /usr/share/applications/google-chrome.desktop' >> remove.sh
echo 'rm -rf /usr/local/'$DIRINST'/google-chrome/' >> remove.sh
USR=`users`
echo 'rm -rf /home/'$USR'/.cache/google-chrome/' >> remove.sh
echo 'rm -rf /home/'$USR'/.config/google-chrome/' >> remove.sh
echo "echo 'Completado!'" >> remove.sh
echo "echo '------------------------------'" >> remove.sh
echo 'exit' >> remove.sh
chmod 744 remove.sh
#
#README
touch README.txt
echo 'Google Chrome' > README.txt
echo 'Idioma=es_MX' >> README.txt
echo 'Version=131.0.6778.108 (Build oficial) (64 bits) empaquetado de .deb' >> README.txt
echo 'Arquitectura=amd64' >> README.txt
echo 'Esta es una instalación no invasiva.' >> README.txt
echo 'Para desinstalar ejecute el fichero remove.sh como root.' >> README.txt
echo '' >> README.txt
echo 'https://www.google.com.mx/chrome/browser/desktop/index.html' >> README.txt
echo '' >> README.txt
echo 'xaxlm' >> README.txt
#
# Limpieza
cd /
echo '------------------------------'
echo 'Limpiando...'
echo -ne '[===>                                    ]( 8.33%)\r';sleep 0.2
echo -ne '[=========>                              ](16.66%)\r';sleep 0.2
echo -ne '[============>                           ](24.99%)\r';sleep 0.2
echo -ne '[===============>                        ](33.32%)\r';sleep 0.2
echo -ne '[==================>                     ](41.65%)\r';sleep 0.2
echo -ne '[=====================>                  ](49.98%)\r';sleep 0.2
echo -ne '[========================>               ](58.31%)\r';sleep 0.2
echo -ne '[===========================>            ](66.64%)\r';sleep 0.2
echo -ne '[==============================>         ](74.97%)\r';sleep 0.2
echo -ne '[=================================>      ](83.30%)\r';sleep 0.2
echo -ne '[====================================>   ](91.64%)\r';sleep 0.2
echo -ne '[=======================================>](100.00%)\r';sleep 0.2
echo -ne '\n'
rm -rf /tmp/google/
rm -rf /google-chrome-stable_current_amd64.deb
rm -rf /usr/local/$DIRINST/google-chrome/google-chrome-stable_current_amd64.tar.gz
if [ -d /home/$USR/.cache/google-chrome/ ];
	then
		rm -rf /home/$USR/.cache/google-chrome/
	else
		:
fi
if [ -d /home/$USR/.config/google-chrome/ ];
	then
		rm -rf /home/$USR/.config/google-chrome/
	else
		:
fi
echo 'Completado!'
echo '------------------------------'
exit
