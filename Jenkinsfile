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
                                        docker.withRegistry('https://registry.hub.docker.com', 'yzznjzz') {
                                                myapp.push("latest")
                                                myapp.push("${env.BUILD_ID}")
                                        }
                                }
                        }
                }
                
        }
}

