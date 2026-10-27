Feature: Pruebas Software Quality Assurance Practico 2 - Posts

    Background:
    * url 'https://gorest.co.in/public/v2'
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'

    @Post @Crear_Post @Logica_Principal
    Scenario: Crear Post
        * def Usuario = call read('users.feature@CrearUsuario')
        * def UserId = Usuario.UserId

        Given path 'users', UserId, 'posts'
        And request 
        """
        {
            "title": "Post Numero 1",
            "body": "Uno, Dos, Tres."
        }
        """
        When method post
        Then status 201
        And match response.user_id == UserId
        And match response.id == '#number'
        And match response.title == "Post Numero 1"

        * eval karate.match(responseTime, '#? _ < 500')

    @Post @Obtener_Post @Logica_Principal
    Scenario: Obtener Posts
        Given path 'posts'
        When method get
        Then status 200

        * eval karate.match(responseTime, '#? _ < 500')