Feature: User usability
  In order to have useful content
  A user
  Should to be able to view, create and download common name alternatives
    
  Background:
    Given a taxon of ID 1 exists

  @javascript
  Scenario: view common name alternatives
    Given a taxon of rank 0 named "Animalia"
      And a common name "Animals" exists for the taxon named "Animalia"
      And I am on the index
    When I select "Animalia" from "kingdom"
    Then I should see "Animals"
  
  @wip @javascript  
  Scenario: create common name alternative
    Given a taxon of rank 0 named "Animalia"
      And a user account exists
      And I am a logged in user
    When I select "Animalia" from "kingdom"
      And I follow "add new common name"
      And I fill in the following:
      | name     | 動物       |
      | language | Japanese |
      And I press "Submit"
    Then I should see "Common name added"