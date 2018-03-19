Feature: Retrieving Keys


  Scenario Outline: Retrieving saved epochs

    Given I have a previously populated <database>
    When I request for stored epochs
    Then I should get all stored epochs

    Examples:
      | database |
      | Files    |
      | MySQL    |
      | Redis    |
      #| Firebase |

  Scenario Outline: Retrieving saved scenarios

    Given I have a previously populated <database>
    When I request for stored scenarios
    Then I should get all stored scenarios

    Examples:
      | database |
      | Files    |
      | MySQL    |
      | Redis    |
      #| Firebase |

  Scenario Outline: Retrieving saved branches

    Given I have a previously populated <database>
    When I request for stored branches
    Then I should get all stored branches

    Examples:
      | database |
      | Files    |
      | MySQL    |
      | Redis    |
      #| Firebase |

  Scenario Outline: Retrieving saved features

    Given I have a previously populated <database>
    When I request for stored features
    Then I should get all stored features

    Examples:
      | database |
      | Files    |
      | MySQL    |
      | Redis    |
      #| Firebase |