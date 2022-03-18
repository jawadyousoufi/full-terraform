node {
	properties([
		buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '5')), 
			pipelineTriggers([cron('H/15 * * * *')]),
				parameters(
					[string(defaultValue: 'apply', description: 'Should I build or destroy? ', name: 'TF_ACTION', trim: true),
					choice(choices: [
						'dev', 
					], 
					description: 'Which Environment should we deploy?', 
					name: 'ENVIR')])])






                    
	stage("Clone a Repo"){
		checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/farrukh90/jenkins-class.git']]])
		}
	stage("Build VPC"){
		ws("${workspace}/AWS/VPC"){
			sh "ENVIRONMENT=${ENVIR} make tf-fmt tf-init tf-plan tf-apply"
			}
		}
	stage("Send Notification"){
		echo "hello"
	}
}
