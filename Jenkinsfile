pipeline {
    agent any

    tools {
        jdk 'JDK_21'
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
                // Usamos 'bat' en lugar de 'sh' para Windows
                bat 'mvn test-compile'
            }
        }

        stage('Ejecutar Pruebas de Gatling') {
            steps {
                // Comando exacto para correr Gatling en tu proyecto
                bat 'mvn gatling:test -Dgatling.simulationClass=performance.GatlingSimulationOther'
            }
        }
    }

    post {
        always {
            // Archiva los reportes HTML generados por Gatling
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