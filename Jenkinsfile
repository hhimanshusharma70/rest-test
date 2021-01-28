pipeline {
     agent { dockerfile true }
     node {
             def customImage = docker.build("test:${env.BUILD_ID}")
             docker.image("test:${env.BUILD_ID}").withRun('-p 7000:80') {
            /* do things */
               }
	   }
}