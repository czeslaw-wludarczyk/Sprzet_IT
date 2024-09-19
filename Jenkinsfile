properties([
                    parameters([
                    choice(choices: [script{return_list()}
                    ],
                    description: 'This is the branch that we will build',
                    name: 'param3')
                    ])
                ])
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}