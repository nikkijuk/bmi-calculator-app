# Important: when using flutter driver localization doesn't kick in
# Currently tests that fallbacks for this bug work
# to run only this feature
# > dart test_driver/app_test.dart --feature="calculate_bmi.feature"

Feature: Calculate BMI
  As the good software developer
  I want to be able to calculate my BMO
  So that I can have extra joy when it at some point is again at green level

  # Default language is "en"
  Scenario: check default language
    Then I expect the "app-title" to be "BMI Calculator"

  # test changing language
  # --> from log
  #I/flutter ( 4970): The following assertion was thrown while handling a gesture:
  ##I/flutter ( 4970):         BlocProvider.of() called with a context that does not contain a Cubit of type
  #I/flutter ( 4970): LocalizationBloc.
  #I/flutter ( 4970):         No ancestor could be found starting from the context that was passed to
  #I/flutter ( 4970): BlocProvider.of<LocalizationBloc>().
  #I/flutter ( 4970):
  #I/flutter ( 4970):         This can happen if the context you used comes from a widget above the BlocProvider.
  Scenario: select language
    When I tap the "flag-gb" button
    Then I expect the "app-title" to be "BMI Calculator"
    # add here reading of title of app (should be ok)
    # test also field name (shouldn't exist)

  # test bmi calculation for one person
  Scenario: Bmi for our imaginary test person
    When I set field "height" to value "170"
    When I set field "weight" to value "70"
    Then I expect field "bmi" to have value "@FIXME"

  # test bmi calculation for list of persons
  Scenario Outline: BMI is calculated when values are given
    When I set field "height" to value "<height-input>"
    When I set field "weight" to value "<weight-input>"
    Then I expect the "bmi" to be "<bmi-result>"
    Examples:
      | height-input  | weight-input  | bmi-result  | should-be       |
      | 170           | 70            | @FIXME      | bmi is 24.22    |
      | 190           | 110           | @FIXME      | bmi is 30.47    |
      #| 0             | 1             | @FIXME      | bmi is Infinity |
