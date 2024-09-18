properties([
    parameters([
        [$class: 'ChoiceParameter', 
            choiceType: 'PT_RADIO',
            description: 'Select a cluster',
            filterLength: 1,
            filterable: true,
            name: 'CLUSTER',
            script: [$class: 'GroovyScript',
                fallbackScript: [
                    classpath: [], 
                    sandbox: true, 
                    script: 'return ["ERROR"]'
                ],
                script: [
                    classpath: [], 
                    sandbox: true, 
                    script: 
       "return['PROD','DEV', 'QA']"
                ]
            ]
        ],
  [$class: 'CascadeChoiceParameter', 
            choiceType: 'PT_CHECKBOX', 
            description: 'select name space ',
            name: 'NAMESPACE', 
            referencedParameters: 'CLUSTER', 
            script: 
                [$class: 'GroovyScript', 
		fallbackScript: [
                        classpath: [], 
                        sandbox: true, 
                        script: 'return ["ERROR"]'
], 
		script: [
                    classpath: [], 
                    sandbox: true, 
                    script: 

			"
                        if (CLUSTER.equals("PROD")){
                            return['PROD-EAST', 'PROD-WEST']
                        }
                        else if (CLUSTER.equals("DEV")) {
                            return['DEV-EAST', 'DEV-WEST']
                        } 
                        else if (CLUSTER.equals("QA")){
                            return['QA-EAST', 'QA-WEST']
                        }              

                        "
                        ] 
                ]
            ]
    ])
])

pipeline {
   agent any  
   stages {

      stage('Printing selected choice') {

         steps {
              script {

            println CLUSTER
            println NAMESPACE


              }
         }
      }

   }
}