pipeline {
    agent any

    tools {
        // Jenkins descargará Maven automáticamente y usará el Java 21 que ya tiene el contenedor
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
                sh 'mvn test-compile'
            }
        }

        stage('Ejecutar Pruebas de Gatling') {
            steps {
                sh 'mvn test -Dgatling.simulationClass=performance.GatlingSimulation'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'target/gatling/**/*', allowEmptyArchive: true
        }
    }
}