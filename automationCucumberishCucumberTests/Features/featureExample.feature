Feature: Feature Example

Background: Create Mocks
  Given a Mock with the params:
    | x |
    | y |

Scenario Outline: Change the OTP lifetime for the same DetectID with <value> seconds
  Given a frist number <number_1>
  And a second number <number_2>
  When the operation is a sum
  Then the result is <result>
  Examples:
    | number_1 | number_2 | result |
    | 1        | 5        | 6       |
    | 5        | 8        | 12      |

