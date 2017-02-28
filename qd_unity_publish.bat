"C:\Program Files\Unity\Editor\Unity.exe" -quit -batchmode -executeMethod Build.PerformOSXUniversalBuild -projectPath C:\<PROJECT_PATH> -logFile C:\<LOG_FILE>
"C:\Program Files\Unity\Editor\Unity.exe" -quit -batchmode -executeMethod Build.PerformWinBuild -projectPath C:\<PROJECT_PATH>-logFile C:\<LOG_FILE>
"C:\Program Files\Unity\Editor\Unity.exe" -quit -batchmode -executeMethod Build.PerformWebBuild -projectPath C:\<PROJECT_PATH> -logFile C:\<LOG_FILE>
bash -c "cd <PROJECT_PATH>/Builds/; zip -r ./Win.zip ./Win"
bash -c "cd <PROJECT_PATH>/Builds/; zip -r ./OSX.zip ./OSX-Universal"
bash -c "ssh -i <OUT> 'mv <OUT>/Win.zip <OUT>Win.zip.bak'; scp -i <KEY> -r <PROJECT_PATH>/Builds/Win.zip <OUT>"
bash -c "ssh -i <OUT> 'mv <OUT>/OSX.zip <OUT>OSX.zip.bak'; scp -i <KEY> -r <PROJECT_PATH>/Builds/OSX.zip <OUT>"
bash -c "scp -i <KEY> -r <PROJECT_PATH>/Builds/Web/* <OUT>/webgl/"
bash -c "rm -r <PROJECT_PATH>/Builds/Win*"
bash -c "rm -r <PROJECT_PATH>/Builds/OSX*"
bash -c "rm -r /<PROJECT_PATH>/Builds/Web*"
bash -c 'BLD_ID=$(shuf -i 1000-999 -n 1);JSON="{\"channel\": \"#builds\", \"username\": \"Hello\", \"icon_emoji\": \":cc:\",\"text\": \"Build $BLD_ID has completed\nPublishing build\nMore Message\"}"; curl -s -d "payload=$JSON" "<TOKEN>"'