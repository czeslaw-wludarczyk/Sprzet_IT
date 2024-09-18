pipeline {
    agent any

    parameters {
        activeChoiceParam(
            name: 'ENVIRONMENT',
            description: 'Select the environment',
            choiceType: 'SINGLE_SELECT',
            groovyScript: [
                classpath: [],
                fallbackScript: [
                    script: 'return ["Could not fetch environments"]',
                    sandbox: true
                ],
                script: [
                    script: 'return ["Development", "Testing", "Staging", "Production"]',
                    sandbox: true
                ]
            ]
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