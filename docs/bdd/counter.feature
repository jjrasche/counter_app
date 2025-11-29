Feature: Counter

Scenario: Fresh start
  Then the counter shows 0

Scenario: Single tap
  When I tap increment
  Then the counter shows 1

Scenario: Multiple taps
  When I tap increment 3 times
  Then the counter shows 3