pipeline {
        agent any
        enviroment {
                PROJECT_ID = 'open-source-441510'
                CLUSTER_NAME = 'kube'
                LOCATION = 'asia-northeast3-a'
                CREDENTIALS_ID = 'gke'
        }
        stages {
                stage("Checkout code") {
                        steps {
                                checkout scm
                        }
                }
                stage("Build image") {
                        steps {
                                script {
                                        myapp = docker.build("yzznjzz/oepn-sw-nogeut:${env.BUILD_ID}")
                                }
                        }
                }
                stage("Push image") {
                        steps {
                                script {
                                        docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                                                myapp.push("latest")
                                                myapp.push("${env.BUILD_ID}")
                                        }
                                }
                        }
                }
                stage("Deploy to GKE") {
                        when {
                                branch 'main'
                        }
                        steps {
                                sh "sed -i 's/open-sw-nogeut:latest/open-sw-nogeut:${env.BUILD_ID}/g' deployment.yaml"
                                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME,location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
                        }
                }
        }

