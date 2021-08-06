*** Settings ***
Documentation     Complete the customer onboarding challenge.
Library           RPA.Browser.Playwright
Library           RPA.HTTP
Library           RPA.Tables

*** Variables ***
${CSV_PATH}=      ${OUTPUT_DIR}${/}customers.csv
${URL}=           https://developer.automationanywhere.com/challenges/automationanywherelabs-customeronboarding.html

*** Tasks ***
Complete the customer onboarding challenge
    Open the challenge website
    Accept cookies
    ${customers}=    Get customers
    Fill and submit customer info    ${customers}
    Take a screenshot of the result

*** Keywords ***
Open the challenge website
    Open Browser    ${URL}

Accept cookies
    Click    css=#onetrust-accept-btn-handler    noWaitAfter=True

Get customers
    ${csv_url}=    Get Attribute    css=p.lead a    href
    RPA.HTTP.Download    ${csv_url}    ${CSV_PATH}    overwrite=True
    ${customers}=    Read table from CSV    ${CSV_PATH}
    [Return]    ${customers}

Fill and submit customer info
    [Arguments]    ${customers}
    FOR    ${customer}    IN    @{customers}
        Fill Text    css=#customerName    ${customer}[Company Name]
        Fill Text    css=#customerID    ${customer}[Customer ID]
        Fill Text    css=#primaryContact    ${customer}[Primary Contact]
        Fill Text    css=#street    ${customer}[Street Address]
        Fill Text    css=#city    ${customer}[City]
        Fill Text    css=#zip    ${customer}[Zip]
        Fill Text    css=#email    ${customer}[Email Address]
        Select Options By    css=#state    value    ${customer}[State]
        IF    "${customer}[Offers Discounts]" == "YES"
            Check Checkbox    css=#activeDiscountYes
        ELSE
            Check Checkbox    css=#activeDiscountNo
        END
        IF    "${customer}[Non-Disclosure On File]" == "YES"
            Check Checkbox    css=#NDA
        END
        Click    css=#submit_button    force=True    noWaitAfter=True
    END

Take a screenshot of the result
    Take Screenshot    selector=css=.modal-content
