Feature: Common name
  In order to browse common names
  As a user
  I want to view and modify common name alternatives
  
  Scenario: List Names
    Given that I have created taxon "Animalia"
    When I select "Animalia" from "kingdom"
    Then I should see "Animals"