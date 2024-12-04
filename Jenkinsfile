pipeline {
        
        stages {
                stage("Checkout code") {
                        steps {
                                checkout scm
                        }
                }
                stage("Build image") {
                        steps {
                                script {
                                        myapp = docker.build("yzznjzz/open-sw-nogeut")
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

