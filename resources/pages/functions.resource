*** Settings ***
Library         Collections
Library         Process
Library         String
Library         SeleniumLibrary
Variables       ../../resources/locators/web_locators.py
Variables       ../../env_variables.py


*** Variables ***
${PORT}  9266
${PROFILE_DIR}  C:\\selenium\\ChromeProfile
${CHROME_PATH}  C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe


*** Keywords ***
Start Chrome With Port
  Start Process
  ...  ${CHROME_PATH}
  ...  --remote-debugging-port\=${PORT}
  ...  --user-data-dir\=${PROFILE_DIR}
  ...  alias=chrome_debug
  ...  shell=True

Connect To Chrome On Port
  ${chrome_options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
  Call Method  ${chrome_options}  add_experimental_option  debuggerAddress  localhost:${PORT}
  Create Webdriver  Chrome  options=${chrome_options}

Login And Go To All Parts Page
  Wait Until Element Is Visible  ${email_input}  timeout=20
  Input Text  ${email_input}  ${USER_NAME}
  Input Text  ${password_input}  ${PASSWORD}
  Click Element  ${submit_btn}
  Wait Until Element Is Visible  ${navigation_menu}
  Go To  https://drtauto.rrr.lt/v2/parts/all?status=0&status=1&order=id%3Dasc&items_per_page=60
  Wait Until Element Is Visible  ${part_id.format('0')}  timeout=15

Get First Code
  [Arguments]  ${part_code_cell_locator}
  ${codes}  Get Text  ${part_code_cell_locator}
  ${list_of_codes}  Split String  ${codes}  \n
  ${first_code}  Get From List  ${list_of_codes}  0
  RETURN  ${first_code}
