*** Settings ***
Library         Collections
Library         Process
Library         String
Library         SeleniumLibrary
Library         RPA.Excel.Files
Variables       ../../resources/locators/web_locators.py
Variables       ../../env_variables.py


*** Variables ***
${PORT}  9266
${PROFILE_DIR}  C:\\selenium\\ChromeProfile
${CHROME_PATH}  C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe
${PAGE_WITH_PLACEHOLDER}  https://drtauto.rrr.lt/v2/parts/all?status=0&status=1&order=id%3Dasc&items_per_page=60&page={}
${WORKBOOK_PATH}  ./resources/data/parts_data_empty_file.xlsx
${WORKBOOK_OUTPUT_PATH}  ./output/xlsx_files/


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
  Wait Until Element Is Visible  ${email_input}  timeout=30
  Input Text  ${email_input}  ${USER_NAME}
  Input Text  ${password_input}  ${PASSWORD}
  Click Element  ${submit_btn}
  Wait Until Element Is Visible  ${navigation_menu}
  Go To Page Number  0

Get The First Part Code
  [Arguments]  ${part_code_cell_locator}
  ${codes}  Get Text  ${part_code_cell_locator}
  ${list_of_codes}  Split String  ${codes}  \n
  ${first_code}  Get From List  ${list_of_codes}  0
  RETURN  ${first_code}

Go To Page Number
  [Arguments]  ${page_number}
  Go To  ${PAGE_WITH_PLACEHOLDER.format('${page_number}')}
  Wait Until Element Is Visible  ${part_id.format('0')}  timeout=30

Get The Number Of Pages
  Wait Until Element Is Visible  ${last_page_btn}  timeout=30
  Click Element  ${last_page_btn}
  Sleep  1
  ${page_url}  Get Location
  ${number_of_pages}  Fetch From Right  ${page_url}  =
  ${number_plus_one}  Evaluate  ${number_of_pages} + 1
  RETURN  ${number_plus_one}

Write Parts To Excel
  [Arguments]  ${parts_list}
  Open Workbook  path=${WORKBOOK_PATH}
  Append Rows To Worksheet  ${parts_list}
  Save Workbook  ${WORKBOOK_OUTPUT_PATH}output_parts_data.xlsx
