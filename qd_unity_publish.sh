#!/bin/bash
########################################
EDITOR_LOC=<unity_editor_install_loc> 
PROJECT_PATH=<unity_project_path>
KEY_LOC=<ssh_key_file>
HOST_LOC=<host_directory>
BLD_ID=$(date "+%m%d%Y%H%M%S")
START_TIME=$(date +%m)

$EDITOR_LOC -quit -batchmode -nographics -executeMethod Build.PerformOSXUniversalBuild -projectPath $PROJECT_PATH -logFile $PROJECT_PATH/../publishOSX.log
$EDITOR_LOC -quit -batchmode -nographics -executeMethod Build.PerformWinBuild -projectPath $PROJECT_PATH  -logFile $PROJECT_PATH/../publishWIN.log
$EDITOR_LOC -quit -batchmode -nographics -executeMethod Build.PerformWebBuild -projectPath $PROJECT_PATH  -logFile $PROJECT_PATH/../publishWEB.log
END_TIME=$(date +%m)
ELAPSED_TIME=$[$END_TIME - $START_TIME]
JSON_PAYLOAD="{\"channel\": \"#builds\", \"username\": \"HI\", \"icon_emoji\": \":shipit:\",\"text\": \"Build $BLD_ID has completed\nElapsed Time: $ELAPSED_TIME minutes.\nPublishing build to\n<MORE MESSAGE>\"}"

cd $PROJECT_PATH/Builds/; zip -r Win.zip ./Win;
cd $PROJECT_PATH/Builds/; zip -r OSX.zip ./OSX_Universal;
ssh -i $KEY_LOC root@lumera.xyz "mv $HOST_LOC/Win.zip $HOST_LOC/Win.zip.bak"
ssh -i $KEY_LOC root@lumera.xyz "mv $HOST_LOC/OSX.zip $HOST_LOC/OSX.zip.bak"
scp -i $KEY_LOC -r $PROJECT_PATH/Builds/Win.zip <INFO>:$HOST_LOC/Win.zip
scp -i $KEY_LOC -r $PROJECT_PATH/Builds/OSX.zip <INFO>:$HOST_LOC/OSX.zip
scp -i $KEY_LOC -r $PROJECT_PATH/Builds/Web/* <INFO>:$HOST_LOC/webgl
curl -s -d "payload=$JSON_PAYLOAD" "https://hooks.slack.com/services/<TOKEN>"'
