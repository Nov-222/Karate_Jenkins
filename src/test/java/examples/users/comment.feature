Feature: Pruebas Software Quality Assurance Practico 2 - Comments

    Background:
        * url 'https://gorest.co.in/public/v2'
        * header Accept = 'application/json'
        * header Content-Type = 'application/json'
        * header Authorization = 'Bearer 700d0c7a86eb84028bf5cd204b11587f812f9d7cd880dc4edbdbd1d407ae9954'
        * def dataGenerator = Java.type('examples.Utils.DataGenerator')

    @Comentario @Crear_Comentario @Logica_Principal
    Scenario: Crear un comentario 
        * def Usuario = call read('users.feature@CrearUsuario')
        * def UserId = Usuario.UserId
        * def UserName = Usuario.response.name
        * def UserEmail = Usuario.response.email
        * def Post = call read('post.feature@Crear_Post') { UserId: '#(UserId)' }
        * def PostId = Post.response.id

        Given path 'posts', PostId, 'comments'
        And request 
        """
        {
            "name": "#(UserName)",
            "email": "#(UserEmail)",
            "body": "1 + 1 = 2."
        }
        """
        When method post
        Then status 201
        And match response.post_id == PostId
        And match response.id == '#number'
        And match response.email == UserEmail

        * eval karate.match(responseTime, '#? _ < 500')

    @Comentario @Obtener_Comentarios @Logica_Principal
    Scenario: Obtener comentarios
        * def Usuario = call read('users.feature@CrearUsuario')
        * def UserId = Usuario.UserId
        * def Post = call read('post.feature@Crear_Post') { UserId: '#(UserId)' }
        * def PostId = Post.response.id

        Given path 'posts', PostId, 'comments'
        When method get
        Then status 200

        * eval karate.match(responseTime, '#? _ < 500')
