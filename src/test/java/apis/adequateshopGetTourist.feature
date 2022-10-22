Feature: simpleApi Get Books api validation

  Background: 
    * def baseUrl = baseUri 
    * def path = path
  

  @sample
  Scenario: A sample karate scenario
    * print "--------------- Hello April 2022 ----------------------"

  Scenario: Get Books jsonPath
    Given url 'https://simple-books-api.glitch.me/books'
    When method GET
    Then status 200
    And print response

  @background @smoke
  Scenario: Use of Background
    Given url baseUrl
    And path path
    When method get
    Then status 200
    And print response


  @getAbook
  Scenario: find specific book
    Given url baseUrl
    And path path + '/1'
    When method Get
    Then status 200

  @negative
  Scenario: find specific book
    Given url baseUrl
    And path  path + '/20'
    When method Get
    Then status 404
    * match response.error == "No book with id 20"
