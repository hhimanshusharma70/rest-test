pipeline {
     agent any
     stages {
        stage("Build") {
            steps {
                sh "npm install"
                sh "npm run build"
            }
        }
        stage("Deploy") {
            steps {
                sh "sudo rm -rf /home/ubuntu/react-main/" 
                sh "sudo cp -r ${WORKSPACE}/build/ /home/ubuntu/react-main/"
            }
        }
		
		stage("Upload to S3") {
			steps {
					withAWS(region:'ap-south-1',credentials:'aws-himanshu') {
						s3Upload(bucket:"test-26-01", workingDir:'/home/ubuntu/react-main/',path:'rest-test/main/${BUILD_NUMBER}' includePathPattern:'**/*')
					}
			}
         }
	}
}