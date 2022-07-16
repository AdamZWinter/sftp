//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label 'docker-agent' }

    environment {
        AZURE_SUBSCRIPTION_ID='1b395c3d-0862-40fe-8e4b-3d49360960ed'
        AZURE_TENANT_ID='25705655-d5cb-4276-b67b-62935168d950'
        TF_VAR_subscriptionid='1b395c3d-0862-40fe-8e4b-3d49360960ed'
        TF_VAR_tenantid='25705655-d5cb-4276-b67b-62935168d950'
        CONTAINER_REGISTRY='ArcticaCR'
        RESOURCE_GROUP='crrg'
        REPO="sftp01"
        IMAGE_NAME="sftptest"
        TAG="0.01"
    }
    
    stages {
        stage('build') {
            steps {
                //sh 'docker build -t ArcticaCR.azurecr.io/sftp01/sftptest:0.01 -f Dockerfile .'
                //sh 'echo built'
                
                withCredentials([
                    usernamePassword(credentialsId: 'sftpServicePrincipalCreds', passwordVariable: 'TF_VAR_clientsecret', usernameVariable: 'TF_VAR_clientid'),
                    usernamePassword(credentialsId: 'passwordtestCreds', passwordVariable: 'TEST_PASSWORD', usernameVariable: 'TEST_USERNAME')
                ]) {
                        //sh 'env.TF_VAR_subscriptionid = env.AZURE_SUBSCRIPTION_ID'
                        //sh 'env.TF_VAR_tenantid = env.AZURE_TENANT_ID'
                    
                    //sh 'export TF_VAR_clientid=$AZURE_CLIENT_ID'
                    //sh 'export TF_VAR_clientsecret=$AZURE_CLIENT_SECRET'
                    //sh 'export TF_VAR_subscriptionid=$AZURE_SUBSCRIPTION_ID'
                    //sh 'export TF_VAR_tenantid=$AZURE_TENANT_ID && echo $TF_VAR_tenantid'
                    
                    //sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                    //sh 'az account set -s $AZURE_SUBSCRIPTION_ID'
                    //sh 'az acr login --name $CONTAINER_REGISTRY --resource-group $RESOURCE_GROUP'
                    //sh 'az acr build --image $REPO/$IMAGE_NAME:$TAG --registry $CONTAINER_REGISTRY --file Dockerfile . '
                    //sh 'az logout'
                    
                    //sh 'export TF_LOG=DEBUG'
                    //sh 'TF_LOG_PATH=/home/jenkins/terraform-debug.log'
                    
                    sh 'terraform init'
                    sh 'terraform fmt'
                    sh 'terraform validate'
                    
                    sh 'terraform apply -auto-approve -no-color -var testpassword=$TEST_PASSWORD'
                    
                    //If I pass the variables this way, it works fine.
                    //sh 'terraform apply -auto-approve -no-color \
                    //    -var clientid=$AZURE_CLIENT_ID \
                    //    -var clientsecret=$AZURE_CLIENT_SECRET \
                    //    -var subscriptionid=$AZURE_SUBSCRIPTION_ID \
                    //    -var tenantid=$AZURE_TENANT_ID \
                    //    -var testpassword=$TEST_PASSWORD'
                    
                    sh 'terraform show'
                    sh 'terraform state list'
                    //sh 'terraform import azurerm_lb.sftptestloadbalancer /subscriptions/$AZURE_SUBSCRIPTION_ID/resourceGroups/sftpResourceGroup/providers/Microsoft.Network/loadBalancers/sftptestloadbalancer'
                        }
            }
        }
    }
}
