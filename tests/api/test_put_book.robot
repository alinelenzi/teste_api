*** Settings ***
Library        RequestsLibrary
Library    OperatingSystem
Resource       ../../resources/common.resource
Variables      ../../resources/variables.py
Suite Setup    Steps    ${url}    ${userName}    ${password}

*** Variables ***
${isbn}    9781449365035
${title}    Eu não tenho certeza
${author}    Aline

*** Test Cases ***

Put Books
    ${headers}   Create Dictionary    Cookie=userId=${userID}    Content-Type=${content_type}
    ${body}    Create Dictionary    userId=${userID}   isbn=${isbn}    title=${title}    author=${author}    
    ${response}    PUT    url=${url}/BookStore/v1/Books?ISBN=${isbn}    headers=${headers}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    204
    Should Be Equal    ${response_body}[books][title]     title  
    Should Be Equal    ${response_body}[books][author]     author 

