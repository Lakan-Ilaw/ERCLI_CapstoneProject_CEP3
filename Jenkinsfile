pipeline {
    agent any

    stages {
        stage('Code Checkout') {
            steps {
                catchError {
                    echo 'Code Checkout'
                    checkout scm
                }
            }
        }
        stage('Terraform Initialization & Planning') {
            steps {
              echo 'Initializing Terraform'
              sh "terraform init"
              echo 'Terraform Planning'
              sh "terraform plan"
              echo 'Terraform Initialization complete'
            }
        }
        stage('Terraform Application') {
            steps {
              echo 'Applying Terraform configuration'
              sh "terraform apply --auto-approve"
              echo 'Terraform apply complete'
            }
        }
    }
}
