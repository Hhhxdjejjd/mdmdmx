#!/bin/bash

case $(uname -m) in
  x86_64)
    #supported
    ;;
  *)
    echo -e "System not supported.\nAn x86_64 OS is required. Please request support for your platform."
    exit 1
    ;;
esac

if [ $(id -u) -ne 0 ]; then
  echo "Please run this script with sudo."
  exit 1
fi

YELLOW='\033[33;1m'
BLUE='\033[0;34m'
BBLUE="\033[1;34m"
NC='\033[0m' #No Color

SDKRoot=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir -p /usr/local/share/applications/

echo "Creating desktop files..."

cp "$SDKRoot/Resources/date.play.simulator.svg" /usr/share/icons/hicolor/scalable/apps/

SDKEscaped=$(printf %q "$SDKRoot")

cat <<-EOF > /tmp/date.play.simulator.desktop
[Desktop Entry]
Name=Playdate Simulator
Exec=$SDKEscaped/bin/PlaydateSimulator %u
Icon=/usr/share/icons/hicolor/scalable/apps/date.play.simulator.svg
Terminal=false
Type=Application
MimeType=application/x-playdate-game;x-scheme-handler/playdate-simulator
StartupWMClass=PlaydateSimulator
Categories=Development;
StartupNotify=true
EOF

desktop-file-install --dir=/usr/local/share/applications/  /tmp/date.play.simulator.desktop

echo "Creating mime info..."

#install mime info in /usr/share/mime/packages

xdg-mime install --mode system "$SDKRoot/Resources/playdate-types.xml"

#install icons into /usr/share/icons/hicolor/

IconRoot=$SDKRoot/Resources/file-icon

xdg-icon-resource install --mode system --context mimetypes --size 16 "$IconRoot/data-16.png" application-x-playdate
xdg-icon-resource install --mode system --context mimetypes --size 32 "$IconRoot/data-32.png" application-x-playdate
xdg-icon-resource install --mode system --context mimetypes --size 48 "$IconRoot/data-48.png" application-x-playdate
xdg-icon-resource install --mode system --context mimetypes --size 512 "$IconRoot/data-512.png" application-x-playdate

update-desktop-database

echo "Setting udev rule..."

cp "$SDKRoot/Resources/50-playdate.rules" /etc/udev/rules.d/
udevadm control --reload-rules
udevadm trigger

cp "$SDKRoot/Resources/playdate-types.xml" /usr/share/mime/packages/
update-mime-database /usr/share/mime

echo -e "\n${YELLOW}Tip:${BLUE}\nMake sure ${BBLUE}\`PLAYDATE_SDK_PATH\`${BLUE} env value is set to the SDK path for development."
echo -e "See the \e]8;;https://sdk.play.date\\aInside Playdate documentation\e]8;;\a for more details.${NC}"

echo -e "\nDone."
