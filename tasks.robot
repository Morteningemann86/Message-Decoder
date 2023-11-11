*** Settings ***
Documentation       Template robot main suite.
Library    RPA.Browser.Selenium
Library    String
Library    RequestsLibrary

*** Variables ***
${URL_TRANSLATE}    https://www.deepl.com/translator
${URL_MESSAGE_DECODER}    https://developer.automationanywhere.com/challenges/AutomationAnywhereLabs-Translate.html?_ga=2.266219782.805881909.1699727641-720841238.1685815347&_gl=1*zrmznv*_ga*NzIwODQxMjM4LjE2ODU4MTUzNDc.*_ga_DG1BTLENXK*MTY5OTcyNzY0MS40LjEuMTY5OTcyNzY4Ni4xNS4wLjA.

*** Tasks ***
Translate Text from Bulgarian to English
    Open Websites
    ${text_to_translate}    Get Text to Translate
    # TODO: Figure out how to use API for translation
    ${text_translated}    Translate text    ${text_to_translate}
    

    ${request}    POST    https://www2.deepl.com/jsonrpc?method=LMT_split_text



    Log    Done.

*** Keywords ***
Open Websites
    Open Available Browser    ${URL_TRANSLATE}    alias=translate
    Open Available Browser    ${URL_MESSAGE_DECODER}    alias=message_decoder

Get Text to Translate
    ${string}    Get Text    xpath://*[contains(text(),'Text to Decode: ')]
    ${string_stripped}    Strip String    ${string}    characters="Text to Decode: "
    RETURN    ${string_stripped}

Translate text
    [Arguments]    ${text_to_translate}
    Switch Browser    translate
    Input Text When Element Is Visible    xpath://*[@_d-id="1"]    ${text_to_translate}
    Wait Until Element Is Not Empty    xpath://*[@_d-id="20"]
    ${text_translated}    Get Text    xpath://*[@_d-id="20"]
    RETURN    ${text_translated}

Wait Until Element Is Not Empty
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds    10x    1s    Run Keyword And Expect Error    *    Get Text    ${locator}