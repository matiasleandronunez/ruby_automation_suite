@api_feature
Feature: API Testing

  @id:0001 @add_already_existing_customer
  Scenario: Attempt to add an already existing customer username
    Given I post an existing customer to the customer create endpoint
    Then I verify I get a conflict response from the API

  @id:0002 @delete_a_customer
  Scenario: Delete a customer
    Given I delete a customer to the customer delete endpoint
    Then I verify I get a no content response from the API

  @id:0003 @create_new_customer
  Scenario: Add a new customer
    Given I post a new customer to the customer create endpoint
    Then I verify I get a entity created response from the API
      And I verify I get the customer ID from the API response