Feature: Dev Ops

  IntegratonQA should know about Dev Ops so they can help companies with bridge the gap between
  development and operations

  Scenario: Find Dev Ops blog
    Given I am on the IntegrationQA blog page
    When I search for 'Dev Ops'
    Then a result is returned

  Scenario: Find Culture change blog
    Given I am on the IntegrationQA blog page
    When I search for 'Culture change'
    Then a result is returned