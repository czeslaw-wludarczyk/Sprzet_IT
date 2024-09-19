
def INPUT_1 = ""
def INPUT_2 = ""

pipeline {
    agent any
    stages {
     stage("Get File Name") {
                steps{
                    timeout(time: 300, unit: 'SECONDS') {
                    script {
                        // The Initial Choice
                        INPUT_1 = input message: 'Please select', ok: 'Next',
                                        parameters: [
                                        choice(name: 'PRODUCT', choices: ['NEW','EXISTING'], description: 'Please select')]
                              
                        if(INPUT_1.equals("NEW")) {
                              INPUT_2 = input message: 'Please Name the file', ok: 'Next',
                                              parameters: [string(name: 'File Name', defaultValue: 'abcd.txt', description: 'Give me a name for the file?')] 
                        } else {
                              INPUT_2 = input message: 'Please Select the File', ok: 'Next',
                                        parameters: [
                                        choice(name: 'File Name', choices: ["file1","file2","filen"], description: 'Select the file')]              
                        }

                        echo "INPUT 1 ::: ${INPUT_1}"
                        echo "INPUT 2 ::: ${INPUT_2}"
                        }
                    }
                }
            }
    }
    post {
        success {
            echo 'The process is successfully Completed....'
        }
    }
}