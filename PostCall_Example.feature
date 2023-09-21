Feature: Reqres Post Call Validation

  Background:
    * url reques = 'https://reqres.in/api/users'

  Scenario: User to validate Post call for reqres
    Given url reques
    When request {"name": "Roshni","job": "Tester"}
    When method POST
    Then status 201
    And print response
    And assert response.name == 'Roshni'
    And assert response.job == 'Tester'
    And assert response.id != null
    And assert response.createdAt != null

  Scenario: User to validate Post call for pet creation
    Given url 'https://petstore.swagger.io/v2/pet'
    When request {  "id": 2,  "category": {  "id": 0,  "name": "string"  },  "name": "doggie",  "photoUrls": [  "string"  ],  "tags": [  {  "id": 0,  "name": "string"  }  ],  "status": "available"  }
    When method POST
    Then status 200
    And print response

    # Post call validation by passing parameter
  Scenario Outline: User to validate Post call for reqres
    Given url reques
    When request {"name": '<name_emp>',"job": '<job_emp>'}
    When method POST
    Then status 201
    And print response
    And assert response.name == '<name_emp>'
    And assert response.job == '<job_emp>'
    And assert response.id != null
    And assert response.createdAt != null
    And match response.createdAt contains '2023'


    Examples:
    |name_emp|job_emp|
    |Vinu|BusinessAnalyst|
    |Nagina|Teacher      |
    |Annie |Developer    |
    |Subeen|Business     |
    |Kavitha|Singer      |
    |Manu   |Manager     |
    |Veena  |Anchor      |
    |Sonam  |Student     |

  Scenario Outline: User to validate Post call for pet creation
    Given url 'https://petstore.swagger.io/v2/pet'
    When request {  "id": '<pet_id>',  "category": {  "id": 0,  "name": "string"  },  "name": '<pet_name>',  "photoUrls": [  "string"  ],  "tags": [  {  "id": 0,  "name": "string"  }  ],  "status": "available"  }
    When method POST
    Then status 200
    And print response
    And assert response.id == '<pet_id>'
    And assert response.name == '<pet_name>'
    And assert response.status == 'available'


    Examples:
    |pet_id|pet_name|
    |1     |doggie|
    |2     |cat   |
    |3     |Lucky |
    |4     |Ruby  |
    |5     |Rocksy|
    |6     |Rabbit|
    |7     |Mitthu|
    |8     |Rugby |



  Scenario: User to validate Post call for CelsiusToFahrenheit
    Given url 'https://www.w3schools.com/xml/tempconvert.asmx'
    * configure ssl = true
    And header Content-Type = 'application/soap+xml; charset=utf-8'
    When request
    """
  <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
  <CelsiusToFahrenheit xmlns="https://www.w3schools.com/xml/">
  <Celsius>20</Celsius>
  </CelsiusToFahrenheit>
  </soap12:Body>
  </soap12:Envelope>
    """
    When method POST
    Then status 200
    And print response
