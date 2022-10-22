Feature: jsonHolder Post User API validation

  Background: 
    * url baseUrl = jsonHolderBaseUri
    * path putUsersPath = putUsersPathJsonHolder
    * def payload = read('classpath:user.json')
  	# And header Authorization = 'Bearer xxx'
  	
  @postUser
  Scenario: Post a user
    Given header Accept = 'application/json'
    When request {"title": "foo","body": "bar","userId": 1}
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == 1
    And match response.body contains 'b'

  @jsonFile
  Scenario: Post a user with json
    Given header Accept = 'application/json'
    When request payload
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == payload.userId
    And match response.body contains payload.body.charAt(0)

  @setJsonRequest
  Scenario: Post a user with json
    Given header Accept = 'application/json'
    * set payload.userId = 15
    When request payload
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == payload.userId
    And match response.body contains payload.body.charAt(0)

  @dataDriven @smoke @regression
  Scenario Outline: Test for - <title>
    Given header Accept = 'application/json'
    * set payload.title = <title>
    * set payload.body = <body>
    * set payload.userId = <userId>
    When request payload
    And method POST
    Then status 201
    # Response header validation
    Then match header Server == 'cloudflare'
    And match header X-Ratelimit-Limit == '1000'
    # Response body validation
    Then match response.userId == payload.userId
    And match response.body contains payload.body.charAt(0)

    Examples: 
      | title                 | body                     | userId |
      | 'Mortal Kombat-1' | 'Earths Doom' |    101 |
      | 'Mortal Kombat-2' | 'Two Dragons' |    202 |
      | 'Mortal Kombat-3' | 'Finish Him'    |    303 |
