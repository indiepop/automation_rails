@demo


Feature: The demo login

  Scenario: login user fail
    Given I Open main page using wrong credential

  Scenario: login user ok
    Given I Open main page using default credential
    When  I click the 'group' link



     # Background, When,Then,And ,Scenario Outline ,Examples
