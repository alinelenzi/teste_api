*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Create User
    [Arguments]    ${url}    ${userName}    ${password}
    ${body}    Create Dictionary    username=${userName}    password=${password}

    ${response}    POST    url=https://bookstore.toolsqa.com/swagger/#/Account/AccountV1UserPost    json=${body}       
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    201    # Validações
    Should Be Equal    ${response_body}[userName]    userName

    ${userId}    Set Variable    ${response.json()}[0][userId]
    Set Suite Variable    ${userId}
    Log to Console    ${userId}

Create Bearer
    [Arguments]    ${url}    ${userName}    ${password}

    ${body}    Create Dictionary    username=${userName}    password=${password}
    ${response}    POST    url=https://bookstore.toolsqa.com/swagger/#/Account/AccountV1GenerateTokenPost    json=${body}

    Status Should Be    200
    ${bearer}    Set Variable    ${response.json()}[bearer]
    Set Suite Variable    ${bearer}                          #transforma a variável (token) em global para todo projeto ao realizar testes, lembrando que o token muda, portanto não poderia estar no variables.py
    Log to Console    ${bearer}

Create Authentication
    [Arguments]    ${url}    ${userName}    ${password}

    ${body}    Create Dictionary    username=${userName}    password=${password}
    ${response}    POST    url=https://bookstore.toolsqa.com/swagger/#/Account/AccountV1AuthorizedPost    json=${body}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}    true

Steps
    [Arguments]    ${url}    ${userName}    ${password}
    Create User    ${url}    ${userName}    ${password}
    Create Bearer    ${url}   ${userName}    ${password}
    Create Authentication    ${url}    ${userName}    ${password}