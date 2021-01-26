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
                sh "rm -rf /home/ubuntu/react-main/"
                sh "cp -r ${WORKSPACE}/build/ /home/ubuntu/react-main/"
            }
        }
    }
}