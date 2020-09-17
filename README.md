# bmi-calculator-app
Body Mass Index calculator implemented with Flutter

## What is BMI?

"BMI is a measurement of a person's leanness or corpulence based on their height and weight, and is intended to quantify tissue mass. It is widely used as a general indicator of whether a person has a healthy body weight for their height. Specifically, the value obtained from the calculation of BMI is used to categorize whether a person is underweight, normal weight, overweight, or obese depending on what range the value falls between." - https://www.calculator.net/bmi-calculator.html

## Technology

This project is a pretty simple technology demo

- Flutter for UI
- Bloc pattern for separating logic from UI 
- bloc & bloc_flutter packages for implementation of Bloc  
- Bloc tested with with bloc_test
- Domain logic tested with normal unit test
- Additional test for user interaction

## Roadmap

Integrate to CI/CD, possibly Codemagic (commercial)
- https://medium.com/flutter-community/how-to-save-10-of-flutter-development-time-every-day-40c39833d1cb
- https://codemagic.io

Extend with BDD / ATDD tools, preferably Gherkin tests
- https://medium.com/@maheshmnj/testing-your-flutter-app-f08ebc54beb9
https://pub.dev/packages/flutter_gherkin

Try implementing Screenshot tests, possibly with Golden Toolkit
- https://tech.ebayinc.com/engineering/ebay-motors-screenshot-testing-with-flutter/
- https://pub.dev/packages/golden_toolkit

Implement localization
- https://flutter.dev/docs/development/accessibility-and-localization/internationalization

Add static analysis for dart code
- https://pub.dev/packages/analyzer

Prepare distribution thru stores
- .. this might never happen, as there's quite limited value on adding this app to any kind of store 

## Further info

- https://bloclibrary.dev/#/
- https://github.com/felangel/bloc/tree/master/examples/flutter_dynamic_form
- https://www.youtube.com/watch?v=knMvKPKBzGE&feature=youtu.be
- https://blog.codemagic.io/flutter-libraries-ebook-by-codemagic/
