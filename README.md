# A robot that completes the customer onboarding challenge

This example robot completes the customer onboarding challenge at https://developer.automationanywhere.com/challenges/automationanywherelabs-customeronboarding.html.

The robot uses the [RPA.Browser.Playwright](https://robocorp.com/docs/libraries/rpa-framework/rpa-browser-playwright) library for browser automation and the [RPA.HTTP](https://robocorp.com/docs/libraries/rpa-framework/rpa-http) library for downloading the CSV file used in the challenge.

```robot
*** Tasks ***
Complete the customer onboarding challenge
    Open the challenge website
    Accept cookies
    ${customers}=    Get customers
    Fill and submit customer info    ${customers}
    Take a screenshot of the result
```
