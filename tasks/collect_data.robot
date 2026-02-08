*** Settings ***
Library         Collections
Library         SeleniumLibrary
Resource        ../resources/pages/functions.resource
Variables       ../resources/locators/web_locators.py
Variables       ../env_variables.py


*** Variables ***
@{LIST}  @{EMPTY}


*** Tasks ***
Get Data
  Connect To Local Browser
  Login And Go To All Parts Page
  FOR  ${line}  IN RANGE  60
    Wait Until Element Is Visible  ${part_id.format('${line}')}  timeout=15
    Scroll Element Into View  ${part_id.format('${line}')}
    ${text}  Get Text  ${part_id.format('${line}')}
    Log To Console  ${line}
    Log To Console  ${text}
    Append To List  ${LIST}  ${text}
    Log To Console  ${LIST}
  END
  ${len}  Evaluate  len(${LIST})
  Log To Console  ${len}
