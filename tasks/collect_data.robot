*** Settings ***
Resource        ../resources/pages/functions.resource


*** Variables ***
&{PART_DATA}  &{EMPTY}


*** Tasks ***
Get Data
  Start Chrome With Port
  Connect To Chrome On Port
  Go To  ${URL}
  Login And Go To All Parts Page
  FOR  ${line_index}  IN RANGE  60
    Wait Until Element Is Visible  ${part_id.format('${line_index}')}  timeout=15
    Scroll Element Into View  ${part_id.format('${line_index}')}
    ${id}  Get Text  ${part_id.format('${line_index}')}
    ${name}  Get Text  ${part_name.format('${line_index}')}
    ${first_code}  Get First Code  ${part_code.format('${line_index}')}
    ${price}  Get Text  ${part_price.format('${line_index}')}
    VAR  &{PART_DATA}  part_id=${id}  part_name=${name}  part_code=${first_code}  part_price=${price}
    Log To Console  ${PART_DATA}
  END
