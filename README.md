# bmi-calculator-app

Body Mass Index calculator implemented with Flutter

## What is BMI?

"BMI is a measurement of a person's leanness or corpulence based on their height and weight, and is intended to quantify tissue mass. It is widely used as a general indicator of whether a person has a healthy body weight for their height. Specifically, the value obtained from the calculation of BMI is used to categorize whether a person is underweight, normal weight, overweight, or obese depending on what range the value falls between." - https://www.calculator.net/bmi-calculator.html

## Technology

This project is a pretty simple technology demo

- Flutter for UI
- Localizely for Localization workflow
- CodeMagic for CI/CD
- Bloc pattern for separating logic from UI 
- bloc & bloc_flutter packages for implementation of Bloc  
- object equality implemented with equatable
- Bloc tested with with bloc_test
- Domain logic tested with normal unit test
- Additional test for user interaction

## Roadmap

Extend with BDD / ATDD tools, preferably Gherkin tests
- https://medium.com/@maheshmnj/testing-your-flutter-app-f08ebc54beb9
https://pub.dev/packages/flutter_gherkin

Try Screenshot tests, possibly with Golden Toolkit
- https://tech.ebayinc.com/engineering/ebay-motors-screenshot-testing-with-flutter/
- https://pub.dev/packages/golden_toolkit

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

## Immutabiliy, Object equality and Debugging bloc

Events & States are immutable. State needs to be compared to previous state in bloc to see if it has changed according to event.

Instead of generating model classes, using generated implementation of equals, hascode and toString or writing manually own boilerplate code there's single library which makes it really easy to implement these methods without polluting model classes with extra lines.

https://pub.dev/packages/equatable

Extending model with handy Equals & HashCode & toString features makes bloc also easy to debug - otherwise it might be really hard to unserstand what happens under the hood.

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

## Localization

Localization is pretty complicated to implement completely without 3rd party tools. 

Candidates for process / tooling
- Flutter default process with [Intl package](https://pub.dev/packages/intl) 
- Additional translations collection with [Intl_traslations](https://pub.dev/packages/intl_translation)
- Experimental: Support for other formats than ARB with [int_translation_format](https://pub.dev/packages/intl_translation_format) and [intl_translation_xliff](https://pub.dev/packages/intl_translation_xliff)
- Code generation from arb files with [intl_utils](https://pub.dev/packages/intl_utils)
- Saas service with [plugin to Android studio](https://plugins.jetbrains.com/plugin/13666-flutter-intl) and VS Code like [Localizely.com](https://localizely.com/)
- Saas service without integration to IDEs like [Phrase](https://phrase.com/)
- Windows, Linux & OSX desktop client like [BabelEdit](https://www.codeandweb.com/babeledit) from [CodeAndWeb](https://www.codeandweb.com)
- Clever library like [easy localization](https://pub.dev/packages/easy_localization)
- Clever Library plus [Some Python Scripts & Spreadsheet](https://itnext.io/flutter-localisation-google-sheets-api-python-internalisation-paradise-8439cab57866)

As the saying goes: "A fool with a tool is still a fool", so one must learn how flutter does localization.

### Experimenting with Localizely

[Localizely's localization workflow](https://localizely.com/flutter-localization-workflow/) can be integrated directly to IDE, which makes it potentially easy to use, as developer doesn't ever need to leave IDE.

Android studios Flutter_intl plugin and Localizely project are connected with Localizelys developer specific api key and Localizelys project specific project id.

![Localizely flow](diagrams/localizely-flow.png)

There might be different person in role of translator, or developer can do translations in addition to programming. In long run separating these roles is vital, but during this experiment I was doing both sides.

After some setup tasks and checking that needed dependencies are at place one one can test roundtrip of upload arb files - change localizations - download arb files - generate code for localization - use localizations from flutter app.

When ARB files are downloaded from Localizely Flutter_Intl plugin generates needed code to use translations. Code shouldn't be changed by developer as next roundtrip overwrites generated files.  

I was using upload and download. 
- First single arb was uploaded to Localizely
- I added locations and keys to cover some of real complexity
- After downloading updated and new arb's I just needed to use generated artifacts to integrate localizations.
- Using localizations needed LocalizationDelegates to be defined from MaterialApp, WidgetTests to be altered due to async loading of localizations and using localizations in UI.

I managed to get Localizely translation workflow to run, but it wasn't always that smooth.
- Android studio let me to give wrong localizely project id while [integrating to localizely](https://localizely.com/flutter-localization-workflow/), and later error message was confusing when trying to upload arb's to Localizely.
- Once integration to Localizely on IDE was simply grayed out - no idea why, and what brought it back - if it would have been longer time absent I would have needed to see how to accomlish needed tasks from command line or using localizelys api's or user interface. 
- Generated code [intl_utils](https://pub.dev/packages/intl_utils) produces seems ok, but if for some reason it doesn't work you're workflow is broken. [intl_utils](https://pub.dev/packages/intl_utils) is closed source, so there's very little you can do by yourself.
- Tests didn't work after localization due to [bug in Flutter](https://github.com/flutter/flutter/issues/22193). This is not related to Localizely, but makes it very important to unserstand what exactly happens in process and how Flutter works.
- In addition I wanted to localize list of strings, and for this I used [Intl package](https://pub.dev/packages/intl) directly. There might have been some easier way, but this was first I came across.
- I also used translations with placeholders, which worked fine at the end, but Localizely didn't give any information as I was on very first try writing placeholders in wrong syntax - code generation did give error message, and nothing happened, so I hanaged to fix it eventually.
- Writing translations in Localizely was ok, but when having 3 languages focus on web app was changing and order of language colums was re-ordered when translations were entered, which suprised me quite a lot.

I could have opted to [not use code generation](https://localizely.com/blog/flutter-localization-step-by-step/, but it seemed good idea and made my life easy.

Experience was mostly positive, but there's still lot to do on developer & Translator UX before it all works smoothly.

## CI/CD

Codemagic is used for CI/CD and integrating it was really simple. There was need to enable tests, since they were by default not active. 

![CI/CD with tests](diagrams/calculator-ci-cd-codemagic.png)

Note: At first flutter app was at sub directory of repo. This might have worked with some configuration, since by default CodeMagic seems to think that in multirepo subdirectories are pure dart, not flutter apps. I decided to copy app to root of repository and after that all was very simple.

## Static analysis

Command *Flutter analyze* does static analyze to dart code.

When everything is ok locally then just select that Codemagic runs analyze during build. 

## Manually deploying to iOS from CI/CD artifacts - without Apple Developer Account

There seems to be several ways of deploying artifact produced with CI/CD to iOS device. I haven't so far tested them. I recommend to try stackoverflows recipe.

https://stackoverflow.com/questions/51254470/how-to-create-ipa-file-for-testing-using-runner-app/56666092

## Linux, Docker and iOs?

How cool is this: You can develop iOs apps with Linux. Haven't tested it yet, but it sounds just great.

https://blog.codemagic.io/how-to-develop-and-distribute-ios-apps-without-mac-with-flutter-codemagic/

## Further info

BLOC
- https://bloclibrary.dev/#/
- https://www.youtube.com/watch?v=knMvKPKBzGE&feature=youtu.be

Localization
- https://flutter.dev/docs/development/accessibility-and-localization/internationalization

Localizely
- https://localizely.com/flutter-localization-workflow/

Phrase
- https://phrase.com/
- https://phrase.com/blog/posts/how-to-internationalize-a-flutter-app/

Easy Localization
- https://pub.dev/packages/easy_localization
- https://dev.to/remejuan/bringing-localization-into-your-widget-testing-71f

BabelEdit
- https://www.codeandweb.com/babeledit/tutorials/how-to-translate-your-flutter-apps

Libraries
- https://blog.codemagic.io/flutter-libraries-ebook-by-codemagic/

CI/CD
- https://codemagic.io
- https://blog.codemagic.io/flutter-step-by-step-tutorial/

Static analysis
- https://github.com/flutter/flutter/wiki/Using-the-Dart-analyzer
- https://docs.codemagic.io/testing/static-code-analysis/
