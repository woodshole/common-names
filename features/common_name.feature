Feature: User usability
  As a user
  I want to be able to view, create and download common name alternatives
  In order to view and annotate data
    
  Background:
    Given a taxon of ID 1 exists
    And a taxon of rank 0 named "Animalia"

  Scenario: view common name alternatives
    Given a common name "Animals" exists for the taxon named "Animalia"
    And I am on the index
    When I select "Animalia" from "kingdom"
    Then I should see "Animals"
    
# Scenario: create common name alternative
#     Given I am a logged in user
#       And I am on the "Animalia" taxon page
#     When I follow "add new common name"
#       And I fill in the following:
#       | name     | 動物       |
#       | language | Japanese |
#       And I press "Submit"
#     Then I should see "Common name added"