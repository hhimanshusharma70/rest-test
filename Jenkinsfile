pipeline {
     agent any
     stages {
        stage("Clean Up") {
            steps {

              script {
                    if (sh  'docker ps -aq --filter "name=rest-test*"') {
                      sh 'docker container stop $(docker ps -aq --filter "name=rest-test*")'
                    } else {
                        echo 'No Build with name rest-test'
                    }
                }

               sh 'docker container rm $(docker ps -aq --filter "name=rest-test*")'

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