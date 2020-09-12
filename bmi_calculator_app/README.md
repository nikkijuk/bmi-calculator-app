# bmi_calculator_app

Flutter Body Mass Index Calculator

## Calculate your BMI

Body mass index can be calculated from two values, and result correlates to persons healt. It's hard to think simpler app with real meaning in context of our lives.

![Calculate your BMI](../diagrams/calculator-page-iphone-simulator-screenshot.png)

In current development stage app doesn't yet contain description of value, but this will be propably added later.

Note: Bmi has [limited value](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6477109/) on estimating overall healt.

## Implementing domain classes

Body mass index is calculated from height and weight of person. Result is single number. Two parameters, one number as result. Pretty neat.

World is still bit tricky
- In europe we have ISO system (KG, CM), but there's other systems in world also.
- There's well known way of calculating BMI, but also new way which should be more accurate.

While this app uses solely ISO when calculating, it has classes for both traditional and new algorithm.

Reason: It's ok to assume in contract of components that client does transformation between numeric systems. Still, we want algorithm to be isolated for use and testing.

![Domain classes implementation and tests](../diagrams/bmi-calculator-classes.png)

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

![Bloc implementation and tests](../diagrams/bmi-calculator-bloc-test.png)

Bloc is tested with specialized [bloc_test](https://pub.dev/packages/bloc_test) extensions, which makes it clean and simple to interact with sinks and streams.

Domain logic is separated from Bloc, and is tested with simple unit test. With separate tests we can concentrate on bloc tests to interaction with business logic, since we know that algorithm itself is already ok.

Note: bloc_flutter is similarly named component as one we use, so be careful not to mix them.

## Implementing UI components

BMI calculator is simple and has only one page. This page is shown after BmiCalcularApp is started.

Flutter uses composition to build viewa
- BmiCalcularApp is composed of MaterialApp, Scaffold and CalculatorPage during startup
- CalculatorPage is composed of BlocBuilder, Center, Column and HeightInput, WeightInput and BmiCalculationResult
- CalculatorPage is rendere when BlocBuilder receives state from bloc
- HeightInput, WeightInput and BmiCalculationResult are all rendered when associated BlocBuilder receives update
- HeightInput, WeightInput and BmiCalculationResult have all id's (key), which can used to identify fields ui component during test

![Calculator Page outline](../diagrams/calculator-page-outline.png)

Composition in CalculatorPage is extreme, and for this app it would be nought to have all embedded within one BlocBuilder. 

WidgetTester component is used to interact with ui fron test classes. All interactions with ui are async. When state of UI is changed it needs to be re-rendered. 

![Calculator UI implementation and tests](../diagrams/calculator-page-test.png)

UI components are Flutter Widgets. So, from here on one can't reuse classes with for example Angular.
