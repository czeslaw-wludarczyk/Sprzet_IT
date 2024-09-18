pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['Development', 'Testing', 'Staging', 'Production'],
            description: 'Select the environment'
        )
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                // Add your build commands here
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                // Add your test commands here
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying to environment: ${params.ENVIRONMENT}"
                // Add your deploy commands here
            }
        }
    }
}