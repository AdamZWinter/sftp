//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'docker build -t grcccontainerregistry.azurecr.io/sftp01/sftptest:0.01 -f Dockerfile .'
                sh 'echo built'
            }
        }
    }
}
