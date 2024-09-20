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
                                                "return['DELPHI','QT6','QT5','C#']"
                                        ]
                                    ]
                                ],

                             [$class: 'CascadeChoiceParameter', 
                                    choiceType: 'PT_RADIO', 
                                    description: 'Wybierz platformę na której ma zbudować się projekt:', 
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
                                                if (Agent.equals ("DELPHI")) {return [\'Win32:selected\', "Win64", "iOS"]}
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
