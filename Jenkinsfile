pipeline { 

    environment { 
        registry = "himanshu1170/node_demo" 
        registryCredential = 'docker_hub_id' 
        dockerImage = '' 
    }
    agent any 
    stages { 
           stage('Building our image') { 

            steps { 
                script { 
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 

                }
            } 

        }
        stage('Deploy our image') { 
            steps { 
                script { 
                   docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push()
                        dockerImage.push('latest') 
                    }
                } 

            }
        } 

        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        } 
        
        stage('Deploying to EC2') {
            steps {
              sshagent(credentials: ['ems']){
		echo "Starting to EC2 deploy "
		sh 'ssh -t -t ubuntu@ec2-13-232-192-86.ap-south-1.compute.amazonaws.com -o StrictHostKeyChecking=no " docker pull $registry:latest" '
                sh 'ssh -t -t ubuntu@ec2-13-232-192-86.ap-south-1.compute.amazonaws.com -o StrictHostKeyChecking=no " docker ps -q --filter  ancestor=$registry | xargs -r docker stop "'
                sh 'ssh -t -t ubuntu@ec2-13-232-192-86.ap-south-1.compute.amazonaws.com -o StrictHostKeyChecking=no "docker run -d -p 7000:80 $registry:$BUILD_NUMBER" '
                }
             }
         }
    }

}


