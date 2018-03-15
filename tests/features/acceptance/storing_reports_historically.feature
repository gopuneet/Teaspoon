Feature: Storing Reports Historically

  As a QA
  I want to save my cucumber results over time
  So I can track the behaviour of my scenarios.

  Scenario Outline: Saving a cucumber report

    Given I have <database>
    When I execute some cucumber tests
    Then their results should be saved to the database

    Examples:
    | database |
    | Files    |
    | MySQL    |
    | Redis    |
    | Firebase |