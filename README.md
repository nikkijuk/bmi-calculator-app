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

## Calculate your BMI

Body mass index can be calculated from two values, and result correlates to persons healt. 

It's hard to think simpler app with real meaning in context of our lives.

![Calculate your BMI](diagrams/calculator-page-iphone-simulator-screenshot.png)

Color of result corresponds to color on graph and there's even text explaining bmi result. How cool is that!

Note: Health is not a simple number game. Bmi has [limited value](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6477109/) on estimating overall health, so one should take care of not interpreting "normal weight" as "healthy" even if green color suggest that result is positive.  

## Implementing domain classes

Body mass index is calculated from height and weight of person. Result is single number. Two parameters, one number as result. Pretty neat.

World is still bit tricky
- In europe we have ISO system (KG, CM), but there's other systems in world also.
- There's well known way of calculating BMI, but also new way which should be more accurate.

While this app uses solely ISO (CM, KG) when calculating, it has classes for both traditional and new algorithm.

Traditional formula: 
- BMI = weight(kg)/height(m)^2 = 703 * weight(lb)/height(in)^2.

New formula: 
- BMI = 1.3 * weight(kg)/height(m)^2.5 = 5734 * weight(lb)/height(in)^2.5

Reason: It's ok to assume in contract of components that client does transformation between numeric systems. Still, we want algorithm to be isolated for use and testing.

![Domain classes implementation and tests](diagrams/bmi-calculator-classes.png)

There's test for each implemented algorithm. When testing later business logic components (bloc) and interaction (pages) we don't need to duplicate tests which are already done for domain objects.

Domain classes do not have dependencies to Flutter.

## Implementing Bloc pattern

Bloc pattern is implemented in BMI Calculator using 3rd party extension called [flutter_bloc](https://pub.dev/packages/flutter_bloc).

Calculator Bloc reacts on three events
- CalculatorReset 
- CalculatorHeightChanged containing persons height
- CalculatorWeightChanged containing persons weight

Bloc state is returned when bloc state changes
- State contains currently given height, weight and possibly calculated bmi 

Bloc itself is not Flutter specific, and can be used from other Dart apps and tests without Flutter.

![Bloc implementation and tests](diagrams/bmi-calculator-bloc-test.png)

Bloc is tested with specialized [bloc_test](https://pub.dev/packages/bloc_test) extensions, which makes it clean and simple to interact with sinks and streams.

Domain logic is separated from Bloc, and is tested with simple unit test. With separate tests we can concentrate on bloc tests to interaction with business logic, since we know that algorithm itself is already ok.

Note: due to design decision made reset event is never used. Nevertheless, it functions, and could be used if state would be managed in ui components differently.

Note: bloc_flutter is similarly named component as one we use, so be careful not to mix them.

## Implementing UI components

BMI calculator is simple and has only one page. This page is shown after BmiCalcularApp is started.

Flutter uses composition to build views
- BmiCalcularApp is composed of MaterialApp, Scaffold and CalculatorPage during startup
- CalculatorPage is composed of BlocBuilder, Center, Column and HeightInput, WeightInput and BmiCalculationResult
- CalculatorPage is rendere when BlocBuilder receives state from bloc
- HeightInput, WeightInput and BmiCalculationResult are all rendered when associated BlocBuilder receives update
- HeightInput, WeightInput and BmiCalculationResult have all id's (key), which can used to identify fields ui component during test

![Calculator Page outline](diagrams/calculator-page-outline.png)

Composition in CalculatorPage is done using separate stateless widgets and for this reason several bloc builders are used. For this app it would be possible to have all input and result widgets embedded within one BlocBuilder, but this would have been at some point simply too much.  

WidgetTester component is used to interact with ui fron test classes. All interactions with ui are async. When state of UI is changed it needs to be re-rendered. 

![Calculator UI implementation and tests](diagrams/calculator-page-test.png)

UI components are Flutter Widgets. So, from here on one can't reuse classes with for example Angular.

## Further info

- https://bloclibrary.dev/#/
- https://github.com/felangel/bloc/tree/master/examples/flutter_dynamic_form
- https://www.youtube.com/watch?v=knMvKPKBzGE&feature=youtu.be
- https://blog.codemagic.io/flutter-libraries-ebook-by-codemagic/
