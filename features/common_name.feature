Feature: User usability
  In order to view and annotate data
  As a user
  I want to be able to view, create and download common name alternatives
  
  Background:
    Given a taxon of ID 1 exists
  
  @selenium
  Scenario: view common name alternatives
    Given a taxon of rank 0 named "Animalia"
      And a common name "Animals" exists for the taxon named "Animalia"
      And I am on the index
    When I select "Animalia" from "kingdom"
    Then I should see "Animals"