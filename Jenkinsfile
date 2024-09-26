properties([
                            parameters([

                                separator(name: "BUILD_ENVIRONMENT", sectionHeader: "Set build parameters",
			                    separatorStyle: "border-width: 0",
			                        sectionHeaderStyle: """
				                        background-color: #333333;
                                        text-align: center;
                                        padding: 4px;
                                        color: #000000;
                                        font-size: 12px;
                                        text-transform: uppercase;
                                        letter-spacing: 1px;
                                    """
		                            ),

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
                                separator(name: "BUILD_ENVIRONMENT", sectionHeader: "Version set",
			                    separatorStyle: "border-width: 0",
			                        sectionHeaderStyle: """
				                        background-color: #333333;
                                        text-align: center;
                                        padding: 4px;
                                        color: #000000;
                                        font-size: 12px;
                                        text-transform: uppercase;
                                        letter-spacing: 1px;
                                    """
		                            ),

                                string(name: 'MajorVersion',  defaultValue: '1', description: ''),
			                    string(name: 'MinorVersion',  defaultValue: '0', description: ''),
			                    string(name: 'BugfixVersion', defaultValue: '1', description: '')
                                
                            ])               
])

pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "${params.Agent}"
                echo "${params.Platform}"
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
