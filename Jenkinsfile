properties([
                            parameters([
                                [$class: 'ChoiceParameter', 
                                    choiceType: 'PT_SINGLE_SELECT', 
                                    description: 'Wybierz Agenta do budowania zadania:', 
                                    filterLength: 1, 
                                    filterable: false, 
                                    name: 'Agent', 
                                    script: [
                                        $class: 'GroovyScript', 
                                        fallbackScript: [
                                            classpath: [], 
                                            sandbox: true, 
                                            script: 
                                                "return['Could not get The environemnts']"
                                        ], 
                                        script: [
                                            classpath: [], 
                                            sandbox: false, 
                                            script: 
                                                "return['DELPHI','QT6','QT5','C#','ANDROID']"
                                        ]
                                    ]
                                ],

                             [$class: 'CascadeChoiceParameter', 
                                    choiceType: 'PT_CHECKBOX', 
                                    description: 'Wybierz platforme na ktorej ma zbudowac sie projekt:', 
                                    filterLength: 1, 
                                    filterable: false, 
                                    name: 'Platform', 
                                    referencedParameters: 'Agent',
                                    script: [
                                        $class: 'GroovyScript', 
                                        fallbackScript: [
                                            classpath: [], 
                                            sandbox: true, 
                                            script: 
                                                "return['Could not get The environemnts']"
                                        ], 
                                        script: [
                                            classpath: [], 
                                            sandbox: false, 
                                            script: '''
                                                if (Agent.equals ("DELPHI")) {return [\'Win32:selected\', \'Win64:selected\', "iOS"]}
                                                if (Agent.equals ('QT6')) {return ['Win32:selected\',\'Win64:selected\','iOS','Android']}
                                                if (Agent.equals ('QT5')) {return [\'Win32:selected\',\'Win64:selected\','iOS','Android']}
                                                if (Agent.equals ('C#')) {return ['Win32',\'Win64:selected\']}
                                                if (Agent.equals ('ANDROID')) {return [\'Android:selected\']}
                                                '''
                                        ]
                                    ]
                                ],

                                string(name: 'MajorVersion',  defaultValue: '1', description: 'Major version'),
			                    string(name: 'MinorVersion',  defaultValue: '0', description: 'Minor version'),
			                    string(name: 'BugfixVersion', defaultValue: '1', description: 'Bugfix version')
                                
                            ])               
])

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "${params.Agent}"
                echo "${params.Platform}"
                script {
                    def jobDescription = currentBuild.rawBuild.getParent().getDescription()
                    echo "Job Description: ${jobDescription}"
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
