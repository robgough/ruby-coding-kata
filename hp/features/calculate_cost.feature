Feature: Caculcate cost of books
  In order to buy a book
  As a user of the system
  I want to calculate the cost

  Scenario: 1 book costs £8
    Given I buy a book
    When I calculate the price
    Then the price is 8 pounds

  Scenario: 2 of the same book costs £16
    Given I buy 2 of the same books
    When I calculate the price
    Then the price is 16 pounds

  Scenario: 2 books have a 5% discount
    Given I buy 2 different books
    When I calculate the price
    Then the price has a 5% discount

  Scenario: 3 different books get a 10% discount
    Given I buy 3 different books
    When I calculate the price
    Then the price has a 10% discount

  Scenario: 4 different books get a 20% discount
    Given I buy 4 different books
    When I calculate the price
    Then the price has a 20% discount

  Scenario: 5 different books get a 25% discount
    Given I buy 5 different books
    When I calculate the price
    Then the price has a 25% discount
