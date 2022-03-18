properties([
    parameters([string(defaultValue: 'apply', description: 'Apply/Destroy', name: 'ACTION'), 
    choice(choices: ['dev', 'qa', 'stage', 'prod'], description: 'Please provide environments', name: 'ENVIR')]), 
    pipelineTriggers([cron('* * * * *')])]
    )






node {
    stage('Preparation') {
        timestamps {
            echo "Hello World"
        }
    }
    stage('Build') {
        build 'Freestyle1'
    }
    stage('Results') {
    }
}
