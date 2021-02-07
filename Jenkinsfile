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
                    }
                } 

            }
        } 

        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        } 
    }

}


