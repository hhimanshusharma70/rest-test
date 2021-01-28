pipeline {
     agent { dockerfile true }
     stages {
        stage("Build Docker") {
            steps {
             def customImage = docker.build("test:${env.BUILD_ID}")
             docker.image("test:${env.BUILD_ID}").withRun('-p 7000:80') {
            /* do things */
        }
            }
        }
        stage("Deploy") { 
            steps {
              
            }
        }
	}
}