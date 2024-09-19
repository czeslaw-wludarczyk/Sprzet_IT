properties([
            [
            $class: 'RebuildSettings', autoRebuild: false, rebuildDisabled: false],
            parameters
            (
                [
                    choice(choices: ['opt1', 'opt2', 'opt3'], description: 'desc', name: 'bla'),
                    choice(choices: script{return_list()}, description: 'some letter', name: 'ble')
                ]
        )
    ]
 )

pipeline {
    agent{
        label "Linux"
    }

    stages{
        stage("frist"){
            steps{
                echo "${params.bla}"
                echo "${params.ble}"
            }
        }
    }
}

def return_list(){
    if ("${JOB_NAME}".contains("bla")){
        env.list_users = "1\n 2\n 3\n"
    }else{
        env.list_users = "a\n b\n c\n"
    }
    return env.list_users
}