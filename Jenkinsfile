//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label 'docker-agent' }
    stages {
        stage('build') {
            steps {
                sh 'docker build -t sftptest:0.001 -f Dockerfile .'
                sh 'echo built'
            }
        }
    }
}
