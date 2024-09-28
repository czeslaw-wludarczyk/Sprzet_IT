//plugins needed installed: Parameter Separator, Active Choices

properties([
                            parameters([

                                separator(name: "BUILD_ENVIRONMENT", sectionHeader: "Set build parameters",
			                    separatorStyle: "border-width: 0",
			                        sectionHeaderStyle: """
				                        background-color: #333333;
                                        text-align: center;
                                        padding: 4px;
                                        color: #ffffff;
                                        font-size: 12px;
                                        text-transform: uppercase;
                                        letter-spacing: 1px;
                                    """
		                            ),

                                [$class: 'ChoiceParameter', 
                                    choiceType: 'PT_SINGLE_SELECT', 
                                    description: 'Select an Agent to build the job:', 
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
                                    description: 'Choose architecture:', 
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
                                                if (Agent.equals ('QT6')) {return ['Win32 Qmake:selected\',\'Win64 QMake:selected\', 'Win32 CMake', 'Win64 Cmake', 'iOS', 'Android']}
                                                if (Agent.equals ('QT5')) {return [\'Win32 QMake:selected\',\'Win64 QMake:selected\', 'Win32 CMake', 'Win64 Cmake', 'iOS','Android']}
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
                                        color: #ffffff;
                                        font-size: 12px;
                                        text-transform: uppercase;
                                        letter-spacing: 1px;
                                    """
		                            ),
                                //Load parameter version from file version.txt
                                //File will be create on appVersioning script
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
                when {
                    environemnts name: 'Agent', value: 'DELPHI' 
                }
                steps {
                    echo "${params.Agent}"
                }
                
                //echo "${params.Platform}"
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
