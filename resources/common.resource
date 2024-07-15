*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Create User
    [Arguments]    ${url}    ${userName}    ${password}
    ${body}    Create Dictionary    userName=${userName}    password=${password}

    ${response}    POST    url=${url}/Account/v1/User    json=${body}       

    Status Should Be    201    # Validações
    ${userID}    Set Variable    ${response.json()}[userID]
    Set Suite Variable    ${userID}
    Log to Console    ${userID}

Create Bearer
    [Arguments]    ${url}    ${userName}    ${password}

    ${body}    Create Dictionary    userName=${userName}    password=${password}
    ${response}    POST    url=${url}/Account/v1/GenerateToken    json=${body}

    Status Should Be    200
    ${bearer}    Set Variable    ${response.json()}[token]
    Set Suite Variable    ${bearer} 
    Log to Console    ${bearer}

Create Authorized
    [Arguments]    ${url}    ${userName}    ${password}

    ${body}    Create Dictionary    userName=${userName}    password=${password}
    ${response}    POST    url=${url}/Account/v1/Authorized    json=${body}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}    ${{bool(True)}}

Steps
    [Arguments]    ${url}    ${userName}    ${password}
    Create User    ${url}    ${userName}    ${password}
    Create Bearer    ${url}   ${userName}    ${password}
    Create Authorized    ${url}    ${userName}    ${password}