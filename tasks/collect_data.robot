*** Settings ***
Resource        ../resources/pages/functions.resource


*** Variables ***
@{PARTS_DATA}  @{EMPTY}
@{SINGLE_PART_DATA}  @{EMPTY}


*** Tasks ***
Get DRT Auto Parts Data
  Start Chrome With Port
  Connect To Chrome On Port
  Go To  ${URL}
  Login And Go To All Parts Page
  ${number_of_pages}  Get The Number Of Pages
  FOR  ${page_number}  IN RANGE  ${number_of_pages}
    Log To Console  ${\n}Page ${page_number} from ${number_of_pages} pages.
    Go To Page Number  ${page_number}
    FOR  ${line_index}  IN RANGE  60
      Wait Until Element Is Visible  ${part_id.format('${line_index}')}  timeout=15
      Scroll Element Into View  ${part_id.format('${line_index}')}
      ${id}  Get Text  ${part_id.format('${line_index}')}
      ${name}  Get Text  ${part_name.format('${line_index}')}
      ${first_code}  Get The First Part Code  ${part_code.format('${line_index}')}
      ${price}  Get Text  ${part_price.format('${line_index}')}
      VAR  @{SINGLE_PART_DATA}  ${id}  ${name}  ${first_code}  ${price}
      Append To List  ${PARTS_DATA}  ${SINGLE_PART_DATA}
    END
    Write Parts To Excel  ${PARTS_DATA}
  END
