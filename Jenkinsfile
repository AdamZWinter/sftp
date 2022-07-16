//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label 'docker-agent' }

    environment {
        AZURE_SUBSCRIPTION_ID='e7df41d1-c6b8-476e-a15e-bd947f424c1f'
        AZURE_TENANT_ID='fa40663e-9727-4978-9bce-776cf824bca5'
        CONTAINER_REGISTRY='grcccontainerregistry'
        RESOURCE_GROUP='crrg'
        REPO="sftp01"
        IMAGE_NAME="sftptest"
        TAG="0.01"
    }
    
    stages {
        stage('build') {
            steps {
                //sh 'docker build -t grcccontainerregistry.azurecr.io/sftp01/sftptest:0.01 -f Dockerfile .'
                //sh 'echo built'
                
                withCredentials([usernamePassword(credentialsId: 'grcccontainerregistryCreds', passwordVariable: 'AZURE_CLIENT_SECRET', usernameVariable: 'AZURE_CLIENT_ID')]) {
                    
                    //sh 'export TF_VAR_clientid=$AZURE_CLIENT_ID'
                    //sh 'export TF_VAR_clientsecret=$AZURE_CLIENT_SECRET'
                    //sh 'export TF_VAR_subscriptionid=$AZURE_SUBSCRIPTION_ID'
                    //sh 'export TF_VAR_tenantid=$AZURE_TENANT_ID && echo $TF_VAR_tenantid'
                    
                    //sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                    //sh 'az account set -s $AZURE_SUBSCRIPTION_ID'
                    //sh 'az acr login --name $CONTAINER_REGISTRY --resource-group $RESOURCE_GROUP'
                    //sh 'az acr build --image $REPO/$IMAGE_NAME:$TAG --registry $CONTAINER_REGISTRY --file Dockerfile . '
                    
                    //sh 'export TF_LOG=DEBUG'
                    //sh 'TF_LOG_PATH=/home/jenkins/terraform-debug.log'
                    
                    sh 'terraform init'
                    sh 'terraform fmt'
                    sh 'terraform validate'
                    
                    //sh 'terraform apply -auto-approve -no-color'
                    
                    //If I pass the variables this way, it works fine.
                    sh 'terraform apply -auto-approve -no-color -var clientid=$AZURE_CLIENT_ID -var clientsecret=$AZURE_CLIENT_SECRET -var subscriptionid=$AZURE_SUBSCRIPTION_ID -var tenantid=$AZURE_TENANT_ID'
                    
                    sh 'terraform show'
                    sh 'terraform state list'
                        }
            }
        }
    }
}
