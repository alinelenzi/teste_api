*** Settings ***
Library        RequestsLibrary
Library    OperatingSystem
Resource       ../../resources/common.resource
Variables      ../../resources/variables.py
Suite Setup    Steps    ${url}    ${userName}    ${password}

*** Test Cases ***

Get UserId
    Create User    ${url}    ${userName}    ${password}
    ${headers}    Create Dictionary    Content-Type=${content_type}    #Header é opcional neste caso
    ${response}    GET    url=${url}/Account/v1/User/${UserID}
    ...    headers=${headers} 

    ${response_body}    Set Variable    ${response.json}
    Log To Console    ${response_body}

