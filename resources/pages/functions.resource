*** Settings ***
Library         Process
Library         SeleniumLibrary
Variables       ../../resources/locators/web_locators.py
Variables       ../../env_variables.py


*** Variables ***
${PORT}  9266
${PROFILE_DIR}  C:\\selenium\\ChromeProfile
${CHROME_PATH}  C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe


*** Keywords ***
Connect To Local Browser
  Start Chrome With Debug Port
  ${chrome_options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
  Call Method  ${chrome_options}  add_experimental_option  debuggerAddress  localhost:${PORT}
  Create Webdriver  Chrome  options=${chrome_options}
  Go To  ${URL}

Start Chrome With Debug Port
  Start Process
  ...  ${CHROME_PATH}
  ...  --remote-debugging-port\=${PORT}
  ...  --user-data-dir\=${PROFILE_DIR}
  ...  alias=chrome_debug
  ...  shell=True

Login And Go To All Parts Page
  Wait Until Element Is Visible  ${email_input}  timeout=20
  Input Text  ${email_input}  ${USER_NAME}
  Input Text  ${password_input}  ${PASSWORD}
  Click Element  ${submit_btn}
  Wait Until Element Is Visible  ${navigation_menu}
  Go To  https://drtauto.rrr.lt/v2/parts/all?status=0&status=1&order=id%3Dasc&items_per_page=60
  Wait Until Element Is Visible  ${part_id.format('0')}  timeout=15
