//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { docker { image 'php:8.1.4-alpine' } }
    stages {
        stage('build') {
            steps {
                sh 'php --version'
                sh 'echo test'
            }
        }
    }
}
