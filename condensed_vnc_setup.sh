sudo apt-get update
sudo apt-get install xfce4 xfce4-goodies tightvncserver

#Should also install xvfb for the virtual frame buffer if you are using 
#VNC to work around Unity's requirement to have a display for initial license agreement 
#when building on a headless server
###
# Example use of xvfb to work around unity requiring a frame buffer to build
# xvfb-run --auto-servernum --server-args='-screen 0 640x480x24' /opt/Unity/Editor/Unity -quit -batchmode -nographics -projectPath /var/lib/jenkins/workspace/<project> -logFile <log_file_loc> -executeMethod Class.BuildMethod 

vncserver

vncserver -kill :1

mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
vim ~/.vnc/xstartup

#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &

sudo chmod +x ~/.vnc/xstartup

vim /etc/init.d/vncserver

#!/bin/bash
PATH="$PATH:/usr/bin/"
export USER="user"
DISPLAY="1"
DEPTH="16"
GEOMETRY="1024x768"
OPTIONS="-depth ${DEPTH} -geometry ${GEOMETRY} :${DISPLAY} -localhost"
. /lib/lsb/init-functions
case "$1" in
start)
log_action_begin_msg "Starting vncserver for user '${USER}' on localhost:${DISPLAY}"
su ${USER} -c "/usr/bin/vncserver ${OPTIONS}"
;;
stop)
log_action_begin_msg "Stopping vncserver for user '${USER}' on localhost:${DISPLAY}"
su ${USER} -c "/usr/bin/vncserver -kill :${DISPLAY}"
;;
restart)
$0 stop
$0 start
;;
esac
exit 0

chmod +x /etc/init.d/vncserver
service vncserver start
update-rc.d vncserver defaults

