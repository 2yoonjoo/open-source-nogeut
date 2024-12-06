pipeline {
    agent any
    environment {
        PROJECT_ID = 'open-source-441510'
        CLUSTER_NAME = 'kube'
        LOCATION = 'asia-northeast3-a'
        CREDENTIALS_ID = '052e9d7a-9816-484e-b7b8-fe0a6a3812dc'
        GITHUB_TOKEN = credentials('github') //
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
		    myapp = docker.build("yzznjzz/nogeut:${env.BUILD_ID}")
		    echo "*Built image: ${image.id}*"
                }
            }
        }
        stage("Push image") {
            steps {
                script {
		    echo "*Pushing image yzznjzz/nogeut:${env.BUILD_ID}*"
                    docker.withRegistry('https://registry.hub.docker.com', 'yzznjzz') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
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
                    sh "sed -i 's/yzznjzz\\/nogeut:latest/yzznjzz\\/nogeut:${env.BUILD_ID}/g' deployment.yaml"

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
