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
				dir('/home/ubuntu/react-main/'){

				pwd(); //Log current directory

					withAWS(region:'ap-south-1',credentials:'aws-himanshu') {

						def identity=awsIdentity();//Log AWS credentials

						// Upload files from working directory 'dist' in your project workspace
						s3Upload(bucket:"test-26-01", workingDir:'/home/ubuntu/react-main/', includePathPattern:'**/*');
					}

				};
			}
        }
    }
}