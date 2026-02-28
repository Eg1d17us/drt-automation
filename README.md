robocop check --reports all
robocop format
robocop list formatters

robot --outputdir output  .\tasks\collect_data.robot
robot --outputdir output --loglevel DEBUG .\tests\web\
robot --outputdir output --loglevel TRACE .\tests\web\

.venv\Scripts\activate
deactivate

taskkill /F /IM chrome.exe
get all chrome PIDs:
tasklist /FI "IMAGENAME eq chrome.exe"
taskkill /PID <PID> /F
"C:\Program Files\Google\Chrome\Application\chrome.exe" --remote-debugging-port=9266 --user-data-dir="C:\selenium\ChromeProfile"