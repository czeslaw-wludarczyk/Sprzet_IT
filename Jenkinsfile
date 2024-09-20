properties([
                            parameters([
                                [$class: 'ChoiceParameter', 
                                    choiceType: 'PT_SINGLE_SELECT', 
                                    description: 'Select the Environemnt from the Dropdown List', 
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
                                                "return['DELPHI','QT6','QT5','C#']"
                                        ]
                                    ]
                                ],

                             [$class: 'CascadeChoiceParameter', 
                                    choiceType: 'PT_RADIO', 
                                    description: 'Select the Environemnt from the Dropdown List', 
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
                                                if (Agent.equals ("DELPHI")) {return ["Win32", "Win64", "iOS"]}
                                                if (Agent.equals ('QT6')) {return ['Win32','Win64','iOS','Android']}
                                                '''
                                        ]
                                    ]
                                ]


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
