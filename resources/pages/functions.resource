*** Settings ***
Library         SeleniumLibrary
Variables       ../../resources/locators/web_locators.py
Variables       ../../env_variables.py


*** Variables ***
${PROFILE_DIR}  C:/Users/egylk/AppData/Local/Google/Chrome/User Data


*** Keywords ***
Login
  [Arguments]  ${port}
  ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
  Call Method  ${options}  add_experimental_option  debuggerAddress  localhost:${port}
  Call Method  ${options}  add_argument  --disable-extensions
  Call Method  ${options}  add_argument  --disable-web-security
  Call Method  ${options}  add_argument  --disable-gpu
  Call Method  ${options}  add_argument  --disable-dev-shm-usage
  Call Method  ${options}  add_argument  --no-sandbox
  Call Method  ${options}  add_argument  --window-size\=1920,1080
  Call Method  ${options}  add_argument  --user-data-dir\=${PROFILE_DIR}
  Create Webdriver  Chrome  options=${options}
  Go To  ${URL}
  Wait Until Element Is Visible  ${email_input}
  Input Text  ${email_input}  ${USER_NAME}
  Input Text  ${password_input}  ${PASSWORD}
  Click Element  ${submit_btn}
