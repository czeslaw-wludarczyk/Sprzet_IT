pipeline {
    agent any

    parameters {
        extendedChoice(
            name: 'ENVIRONMENT',
            description: 'Select the environment',
            type: 'PT_SINGLE_SELECT',
            groovyScript: '''
                return ["Development", "Testing", "Staging", "Production"]
            '''
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