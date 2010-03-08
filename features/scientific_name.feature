Feature: Scientific name
  In order to browse scientific names
  As a user
  I want to view and modify scientific name alternatives
  
  Scenario: List Names
    Given that I have created taxon with the attributes:
    | name | rank |
    | Animalia | 0 |
    When I go to index
    And I select "Animalia" from "kingdom"
    Then I should see "Animalia"