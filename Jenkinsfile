pipeline {
     agent any
     stages {
        stage("Build Docker") {
            steps {
               sh 'docker build -t rest-test .'
            }
        }
        stage("Deploy") { 
            steps {
               sh 'docker run -d -it  -p 7000:80/tcp --name rest-test rest-test'
            }
        }
	}
}