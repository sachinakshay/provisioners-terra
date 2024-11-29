pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY')       // Jenkins credentials ID for AWS Access Key
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_KEY')   // Jenkins credentials ID for AWS Secret Key
        AWS_REGION = 'us-east-1'                                // AWS region
        TERRAFORM_DIR = 'terraform'                             // Path to Terraform configuration
        GIT_BRANCH = 'main'                                     // Replace 'main' with your actual branch name if different
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                git branch: env.GIT_BRANCH, 
                    url: 'https://github.com/sachinakshay/provisioners-terra.git'
            }
        }

        stage('Initialize Terraform') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    echo 'Initializing Terraform...'
                    bat '''
                        terraform init
                    '''
                }
            }
        }

        stage('Validate Terraform') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    echo 'Validating Terraform configuration...'
                    bat '''
                        terraform validate
                    '''
                }
            }
        }

        stage('Plan Terraform') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    echo 'Planning Terraform execution...'
                    bat '''
                        terraform plan -var="aws_access_key=%AWS_ACCESS_KEY_ID%" -var="aws_secret_key=%AWS_SECRET_ACCESS_KEY%" -var="region=%AWS_REGION%"
                    '''
                }
            }
        }

        stage('Apply Terraform') {
            steps {
                dir(env.TERRAFORM_DIR) {
                    echo 'Applying Terraform configuration...'
                    bat '''
                        terraform apply -auto-approve -var="aws_access_key=%AWS_ACCESS_KEY_ID%" -var="aws_secret_key=%AWS_SECRET_ACCESS_KEY%" -var="region=%AWS_REGION%"
                    '''
                }
            }
        }

        stage('Post-Provisioning') {
            steps {
                echo '''
                Post-provisioning tasks (if required):
                - Configure additional settings
                - Notify team
                '''
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}
