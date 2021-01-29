pipeline {
     agent any
     stages {
        stage("Clean Up") {
            steps {

                   //sh "/home/ubuntu/script/cleanup.sh"
                  sh 'docker rm -f rest-test'
                  sh 'docker image prune -a --force --filter "until=5h"'
            }
        }
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