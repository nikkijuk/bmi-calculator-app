# Important: when using flutter driver localization doesn't kick in
# Currently tests that fallbacks for this bug work
# to run only this feature
# > dart test_driver/app_test.dart --feature="calculate_bmi.feature"

Feature: Calculate BMI
  As the good software developer
  I want to be able to calculate my BMO
  So that I can have extra joy when it at some point is again at green level

  # test person
  Scenario: Bmi for our imaginary test person
    When I set field "height" to value "170"
    When I set field "weight" to value "70"
    Then I expect field "bmi" to have value "@FIXME"

  # test person, Donald & Bug
  Scenario Outline: BMI is calculated when values are given
    When I set field "height" to value "<height-input>"
    When I set field "weight" to value "<weight-input>"
    Then I expect the "bmi" to be "<bmi-result>"
    Examples:
      | height-input  | weight-input  | bmi-result  | should-be       |
      | 170           | 70            | @FIXME      | bmi is 24.22    |
      | 190           | 110           | @FIXME      | bmi is 30.47    |
      | 0             | 1             | @FIXME      | bmi is Infinity |
