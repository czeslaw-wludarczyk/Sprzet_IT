def JOB_NAME = currentBuild.projectName.toLowerCase()
def subTypeScript = getSubTypeScript(JOB_NAME)

properties([
   parameters([
      [
         $class: 'ChoiceParameter',
         choiceType: 'PT_SINGLE_SELECT',
         description: "Select which type",
         filterLength: 1,
         filterable: false, 
         name: 'TYPE', 
         script: [
            $class: 'GroovyScript', 
            fallbackScript: [
               classpath: [], 
               sandbox: true,
               script: "return['']"
            ], 
            script: [
               classpath: [], 
               sandbox: true,
               script: "return ['TYPE1', 'TYPE2', 'TYPE3', 'TYPE4']"
            ]
         ]
      ],
      [
         $class: 'CascadeChoiceParameter',
         choiceType: 'PT_SINGLE_SELECT', 
         description: 'Select which sub type',
         name: 'SUB_TYPE', 
         referencedParameters: 'TYPE',
         script: [
            $class: 'GroovyScript', 
            fallbackScript: [
               classpath: [], 
               sandbox: true, 
               script: "return['Select which type']"
            ], 
            script: [
               classpath: [], 
               sandbox: true,
               script: "$subTypeScript"
            ] 
         ]
      ]
   ])
])

pipeline {
    agent any
    stages {
       stage ('BUILD') {
          steps {
             script {
                println "BUILD here"
             }
          }
       }
       stage ('TEST') {
          steps {
              script {
                 println "Testing here"
              }
          }
       }
       stage('DEPLOY') {
          steps {
             script {
                println "Deployment here"
             }
          }
       }
    }
}

def getSubTypeScript(JOB_NAME) {
    
   def jsonFile = "/var/jenkins_home/workspace/${JOB_NAME}.json"
   def LOADING_JSON_SCRIPTS = """      
      import groovy.json.JsonSlurper
      def jsonContent = "cat $jsonFile".execute()
      def mapsFromJSON = new JsonSlurper().parseText(jsonContent.text)
   """

   def PARAM_SCRIPTS = '''
        if (TYPE.equals('TYPE1')) {
            return getSubTypes(mapsFromJSON, "TYPE1")
        } else if (TYPE.equals('TYPE2')) {
            return getSubTypes(mapsFromJSON, "TYPE2")
        } else if (TYPE.equals('TYPE3')) {
            return getSubTypes(mapsFromJSON, "TYPE3")
        } else if (TYPE.equals('TYPE4')) {
            return getSubTypes(mapsFromJSON, "TYPE4")
        }
        
        def getSubTypes(mapsFromJson, type) {
            def paramList = []
            // ... logic here to finalize the choices.
            return paramList
        }
   '''
   return "${LOADING_JSON_SCRIPTS}\n${PARAM_SCRIPTS}"
}