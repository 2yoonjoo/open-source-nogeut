pipeline {
    agent any
    environment {
        PROJECT_ID = 'open-source-441510'       // GCP 프로젝트 ID
        CLUSTER_NAME = 'kube'                  // GKE 클러스터 이름
        LOCATION = 'asia-northeast3-a'         // 클러스터 위치
        CREDENTIALS_ID = '052e9d7a-9816-484e-b7b8-fe0a6a3812dc'     // GCP  인증 정보 (Jenkins에서 설정한 Google 서비스 계정 키 파일)
        DOCKER_IMAGE = 'yzznjzz/open-sw-nogeut:${BUILD_ID}'  // Docker 이미지  이름
    }
    stages {
        stage("Checkout code") {
            steps {
                script {
                    // Git 리포지토리에서 코드를 체크아웃합니다.
                    git url: 'https://github.com/2yoonjoo/open-source-nogeut.git', branch: 'main'
                }
            }
        }

        stage("Build image") {
            steps {
                script {
                    // Docker 이미지를 빌드합니다.
                    sh "docker build -t yzznjzz/open-sw-nogeut:${BUILD_ID} ."
                }
            }
        }

        stage("Push Docker image") {
            steps {
                script {
                    // Docker Hub에 이미지를 푸시합니다.
                    withDockerRegistry([credentialsId: 'yzznjzz', url: 'https://index.docker.io/v1/']) {
                        sh "docker push yzznjzz/open-sw-nogeut:${BUILD_ID}"
                    }
                }
            }
        }

        stage('Deploy to GKE') {
		when {
			branch 'main'
		}
		steps {
                script {
			sh "sed -i 's/yzznjzz\\/open-sw-nogeut:latest/yzznjzz\\/open-sw-nogeut:${BUILD_ID}/g' deployment.yaml"
                    // 배포 전에 deployment.yaml 파일의 이미지를 최신 빌드 ID로 교체합니다.	

                    // Kubernetes Engine에 배포합니다.
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
    }

}
