pipeline {
     agent { dockerfile true }
     stages {
        stage("Build Docker") {
            steps {
             script { 

                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 

                }
            }
        }
        stage("Deploy") { 
            steps {
              
            }
        }
	}
}