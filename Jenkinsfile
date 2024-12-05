pipeline {
    agent any
    stages {
        stage("Clone repository") {
            steps {
                git branch: 'main', url: 'https://github.com/2yoonjoo/open-source-nogeut.git'
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


