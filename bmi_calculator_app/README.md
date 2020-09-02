# bmi_calculator_app

Flutter Body Mass Index Calculator

## Implementing Bloc pattern

Bloc pattern is implemented in BMI Calculator using 3rd party extension called bloc_flutter.

Bloc itself is not Flutter specific, and can be used from other Dart apps and tests without Flutter.

![Bloc implementation and tests](../diagrams/bmi-calculator-bloc-test.png)

Note that domain logic is separated from Bloc, and can be tested with simple unit test.

Bloc is tested with specialized test extensions, which makes it clean and simple to interact with sinks and streams.