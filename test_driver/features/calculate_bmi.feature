
Feature: Calculate BMI
  As the good software developer
  I want to be able to calculate my BMO
  So that I can have extra joy when it at some point is again at green level

  # test person
  Scenario: Bmi for our imaginary test person
    Given the height is "170"
    Given the weight is "70"
    Then I expect the bmi is "24.22"

  # test person, Donald & Bug
  Scenario Outline: BMI is calculated when values are given
    Given the height is "<height-input>"
    Given the weight is "<weight-input>"
    Then I expect the bmi is "<bmi-result>"
    Examples:
      | height-input  | weight-input  | bmi-result       |
      | 170           | 70            | bmi is 24.22     |
      | 190           | 110           | bmi is 30.47     |
      | 0             | 1             | bmi is Infinity  |
