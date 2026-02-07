*** Settings ***
Library         SeleniumLibrary
Library   Collections
Resource        ../resources/pages/functions.resource
Variables       ../resources/locators/web_locators.py
Variables       ../env_variables.py

*** Variables ***
@{list}

*** Tasks ***
Get data
  Login  9266
  Go To  https://drtauto.rrr.lt/v2/parts/
  Sleep  10
  FOR  ${line}  IN RANGE  60
    Wait Until Element Is Visible  ${part_id.format('${line}')}  timeout=15
    Scroll Element Into View    ${part_id.format('${line}')}
    Wait Until Element Is Visible  ${part_id.format('${line}')}  timeout=15
    ${text}  Get Text  ${part_id.format('${line}')}
    Log To Console  ${text}
    Append To List    ${list}  ${text}
    Log To Console    ${list}
  END
  ${len}  Evaluate  len(${list})
  Log To Console    ${len}

