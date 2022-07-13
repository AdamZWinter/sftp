//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label 'docker-agent' }
    stages {
        stage('build') {
            steps {
                sh 'docker build -t grcccontainerregistry.azurecr.io/sftp01/sftptest:0.01 -f Dockerfile .'
                sh 'echo built'
            }
        }
    }
}
