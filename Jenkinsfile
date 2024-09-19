pipeline {
    agent any
        stages {
            stage('Parameters'){
                steps {
                    script {
                    properties([
                            parameters([
                                [$class: 'ChoiceParameter', 
                                    choiceType: 'PT_SINGLE_SELECT', 
                                    description: 'Select the Environemnt from the Dropdown List', 
                                    filterLength: 1, 
                                    filterable: false, 
                                    name: 'Env', 
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
                                    choiceType: 'PT_SINGLE_SELECT', 
                                    description: 'Select the AMI from the Dropdown List',
                                    name: 'PLATFORM', 
                                    referencedParameters: 'Env', 
                                    script: 
                                        [$class: 'GroovyScript', 
                                        fallbackScript: [
                                                classpath: [], 
                                                sandbox: false, 
                                                script: "return['Could not get Environment from Env Param']"
                                                ], 
                                        script: [
                                                classpath: [], 
                                                sandbox: false, 
                                                script: '''
                                                if (Env.equals("DELPHI")){
                                                    return["Win32bit", "Win64bit", "iOS"]
                                                }
                                                else if(Env.equals("QT6")){
                                                    return["Win32Bit", "Win64Bit", "Android"]
                                                }
                                                else if(Env.equals("QT5")){
                                                     return["Win32Bit", "Win64Bit", "Android"]

                                                }
                                                '''
                                            ] 
                                    ]
                                ],
                                [$class: 'DynamicReferenceParameter', 
                                    choiceType: 'ET_ORDERED_LIST', 
                                    description: 'Select the  AMI based on the following information', 
                                    name: 'Information', 
                                    referencedParameters: 'Env', 
                                    script: 
                                        [$class: 'GroovyScript', 
                                        script: 'return["Could not get AMi Information"]', 
                                        script: [
                                            script: '''
                                                    if (Env.equals("DELPHI")){
                                                        return["Win32Bit with DELPHI", "Win64Bit with DELPHI", "iOS with DELPHI"]
                                                    }
                                                    else if(Env.equals("stage")){
                                                        return["ami-sd34sdf:  AMI with Java", "ami-sdf345sdc: AMI with Python", "ami-sdf34sdf: AMI with Groovy"]
                                                    }
                                                    else if(Env.equals("prod")){
                                                        return["ami-sdf34sdf:  AMI with Java", "ami-sdf34ds: AMI with Python", "ami-sdf3sf3: AMI with Groovy"]
                                                    }
                                                    '''
                                                ]
                                        ]
                                ]
                            ])
                        ])
                    }
                }
            }
        }   
}