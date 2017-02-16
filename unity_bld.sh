#!/bin/bash
BLD_ID=$(date '+%m%d%Y%H%M%S')
START_TIME=$(date +%m)
/opt/Unity/Editor/Unity -quit -batchmode -nographics -buildOSXUniversalPlayer /var/www/html/builds/$BLD_ID/OSX/LA.app -projectPath /home/jenkins_user/.jenkins/jobs/<JOB>/workspace
/opt/Unity/Editor/Unity -quit -batchmode -nographics -buildWindows64Player /var/www/html/builds/$BLD_ID/WIN/LA.exe -projectPath /home/jenkins_user/.jenkins/jobs/<JOB>/workspace
sleep 1
if [ $? -eq  0 ]; then
        END_TIME=$(date +%m)
        ELAPSED_TIME=$[$END_TIME - $START_TIME]
        JSON="{\"channel\": \"#builds\", \"username\": \"Jenkins\", \"icon_emoji\": \":shit:\",\"text\": \"Build: $BLD_ID has completed.\nElapsed Time: $ELAPSED_TIME minutes.\nPublishing build to: <LOC>\"}"
        curl -s -d "payload=$JSON" "https://hooks.slack.com/services/<TOKEN>"
        rm -rf /var/www/html/builds/latest
        ln -s /var/www/html/builds/$BLD_ID /var/www/html/builds/latest
        chmod -R 777 /var/www/html/builds/$BLD_ID
fi
