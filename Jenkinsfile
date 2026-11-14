pipeline {
    agent any

    tools {
        // Apunta al nombre exacto del JDK registrado en el panel de Jenkins (Tools)
        jdk 'JDK_21'
        // Mantiene la configuración automática de Maven
        maven 'Maven 3'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Compilar Proyecto') {
            steps {
                // Compila las clases de prueba (incluyendo Scala y Gatling)
                sh 'mvn test-compile'
            }
        }

        stage('Ejecutar Pruebas de Gatling') {
            steps {
                // Ejecuta la simulación de Gatling configurada en tu proyecto Karate
                sh 'mvn test -Dgatling.simulationClass=performance.GatlingSimulation'
            }
        }
    }

    post {
        always {
            // Archiva los reportes HTML generados por Gatling para poder descargarlos desde Jenkins
            archiveArtifacts artifacts: 'target/gatling/**/*', allowEmptyArchive: true
        }
        success {
            echo '¡Pruebas de Gatling ejecutadas exitosamente!'
        }
        failure {
            echo 'La ejecución de Gatling ha fallado.'
        }
    }
}