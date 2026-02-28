*** Settings ***
Resource        ../resources/pages/functions.resource


*** Variables ***
@{PARTS_DATA}  @{EMPTY}
@{SINGLE_PART_DATA}  @{EMPTY}
${LINES_PER_PAGE}  100


*** Tasks ***
Get DRT Car Parts Data
  Start Chrome With Port
  Connect To Chrome On Port
  Go To  ${URL}
  Login And Go To All Parts Page  ${LINES_PER_PAGE}  0
  ${number_of_pages}  Get The Number Of Pages
  FOR  ${page_number}  IN RANGE  ${number_of_pages}
    Log To Console  ${\n}Started for page ${page_number} from ${number_of_pages} pages.
    Go To Page Number  ${LINES_PER_PAGE}  ${page_number}
    FOR  ${line_index}  IN RANGE  ${LINES_PER_PAGE}
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
    Log To Console  Page ${page_number} data is written.
  END
  Close Chrome
