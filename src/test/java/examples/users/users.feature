Feature: Pruebas Software Quality Assurance Practico 2 - Usuarios

  Background:
    * url 'https://gorest.co.in/public/v2'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'
    * def dataGenerator = Java.type('examples.Utils.DataGenerator') 

   @Usuario @Logica_Principal @CrearUsuario
   Scenario: Crear un nuevo usuario exitosamente
    * def RandomUser = dataGenerator.getUserRandom()

    Given path 'users'
    And request RandomUser
    When method post
    Then status 201

    * eval karate.match(responseTime, '#? _ < 500')
    * def UserId = response.id

   @Usuario @Obtener_Usuario_Id @Logica_Principal
   Scenario: Obtener Usuario Creado
    * def Usuario = call read('users.feature@CrearUsuario')
    * def UserId = Usuario.UserId

    Given path 'users', UserId
    When method get
    Then status 200

    * eval karate.match(responseTime, '#? _ < 500')
    * def UserId = response.id

   @Usuario @Obtener_Usuarios @Logica_Principal
  Scenario: Obtener Usuarios
    Given path 'users'
    When method get
    Then status 200

    * eval karate.match(responseTime, '#? _ < 500')

  @Usuario @Actualizar_Usuario @Logica_Principal
  Scenario: Actualizar Usuario
    * def Usuario = call read('users.feature@CrearUsuario')
    * def UserId = Usuario.UserId

    Given path 'users', UserId
    And request { "name": "Kal 2.0", "status": "active" }
    When method put
    Then status 200
    And Usuario.id == response.id

    * eval karate.match(responseTime, '#? _ < 500')

  @Usuario @Eliminar_Usuario @Logica_Principal
  Scenario: Eliminar Usuario
    * def Usuario = call read('users.feature@CrearUsuario')
    * def UserId = Usuario.UserId

    Given path 'users', UserId
    When method delete
    Then status 204

    * eval karate.match(responseTime, '#? _ < 500')