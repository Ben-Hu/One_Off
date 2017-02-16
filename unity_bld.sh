#!/bin/bash
BLD_ID=$(date '+%m%d%Y%H%M%S')
START_TIME=$(date +%m)
/opt/Unity/Editor/Unity -quit -batchmode -nographics -buildtarget webgl /var/www/html/builds/$BLD_ID/ -projectPath /home/jenkins_user/.jenkins/jobs/<JOB>workspace/
if [ $? -eq  0 ]; then
        rm /var/www/html/builds/latest
        ln -s /var/www/html/builds/$BLD_ID/ /var/www/html/latest
        END_TIME=$(date +%m)
        ELAPSED_TIME=$[$END_TIME - $START_TIME]
        JSON="{\"channel\": \"#builds\", \"username\": \"Jenkins\", \"icon_emoji\": \":shit:\",\"text\": \"Build: $BLD_ID has completed.\nElapsed Time: $ELAPSED_TIME minutes.\nPublishing build to: http:\/\/<URL>\/builds\/latest\"}"
        curl -s -d "payload=$JSON" "https://hooks.slack.com/services/<TOKEN>"
fi
