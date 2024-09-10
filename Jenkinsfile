pipeline {
    agent any
	parameters {
    		choice(
        	 name: 'myParameter',
        	 choices: "Option1\Option2",
        	 description: 'interesting stuff' )
  		   }

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