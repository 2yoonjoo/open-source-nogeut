pipeline {
    agent any
    environment {
        PROJECT_ID = 'open-source-441510'
        CLUSTER_NAME = 'kube'
        LOCATION = 'asia-northeast3-a'
        CREDENTIALS_ID = '052e9d7a-9816-484e-b7b8-fe0a6a3812dc'
	DOCKER_IMAGE = "yzznjzz/opne-sw-nogeut:${BUILD_ID}"
    }
    stages {
       stage("Checkout code") {
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/2yoonjoo/open-source-nogeut.git'
                }
            }
        }
        stage("Build image") {
            steps {
                script {
		    //myapp = docker.build("yzznjzz/open-sw-nogeut:${BUILD_ID}")
		      sh "docker build -t yzznjzz/opne-sw-nogeut:${BUILD_ID} ."
                }
            }
        }
        stage("Push image") {
            steps {
                script {
                    //docker.withRegistry('https://registry.hub.docker.com', 'yzznjzz') {
                            //myapp.push("latest")
                            //myapp.push("${BUILD_ID}")
		     withDockerRegistry([credentialsId: 'yzznjzz', url: 'https://index.docker.io/v1/']) {
			sh "docker push yzznjzz/open-sw-nogeut:${BUILD_ID}"
                    }
                }
            }
        }
        stage('Deploy to GKE') {
            when {
		    expression {
			    return (env.BRANCH_NAME == 'main') || (env.CHANGE_TARGET == 'main')
		    }
            }
            steps {
                script {
                    sh "sed -i 's/yzznjzz\\/opne-sw-nogeut:latest/yzznjzz\\/open-sw-nogeut:${BUILD_ID}/g' deployment.yaml"

                    step([$class: 'KubernetesEngineBuilder',
                          projectId: env.PROJECT_ID,
                          clusterName: env.CLUSTER_NAME,
                          location: env.LOCATION,
                          manifestPattern: 'deployment.yaml',
                          credentialsId: env.CREDENTIALS_ID,
                          verifyDeployments: true])
                }
            }
        }
	    
    }    
}
