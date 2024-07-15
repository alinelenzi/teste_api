*** Settings ***
Library        RequestsLibrary
Library    OperatingSystem
Resource       ../../resources/common.resource
Variables      ../../resources/variables.py
Suite Setup    Steps    ${url}    ${userName}    ${password}

*** Variables ***
${isbn}    9781593277574

*** Test Cases ***
Delete Book
    ${headers}   Create Dictionary    Cookie=userId=${userID}    Content-Type=${content_type}
    ${body}    Create Dictionary    userId=${userID}   isbn=${isbn}
    ${response}    DELETE    url=${url}/BookStore/v1/Book    headers=${headers}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200

