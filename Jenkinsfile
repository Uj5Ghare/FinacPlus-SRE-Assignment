pipeline {
    agent any

    environment {
        REGISTRY_REPO = 'public.ecr.aws/w6y6h1q9'
        IMAGE_TAG = "$BUILD_NUMBER"
        IMAGE_NAME = 'uj5ghare/finacplus'
        AWS_USER = 'AWS'
        AWS_REGION = 'ap-south-2'
        CLUSTER_NAME = 'finacplus-cluster'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Uj5Ghare/FinacPlus-SRE-Assignment.git', branch: 'k8s'
            }
        }

        stage('Build_Docker_Img') {
            steps {
                script {
                sh 'docker build -t $REGISTRY_REPO/$IMAGE_NAME:$IMAGE_TAG .'
                }
            }
        }

        stage('Login_To_ECR') {
            steps {
                script {
                sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username $AWS_USER --password-stdin $REGISTRY_REPO'
                }
            }
        }

        stage('Push_To_ECR') {
            steps {
                script {
                sh 'docker push $REGISTRY_REPO/$IMAGE_NAME:$IMAGE_TAG'
                }
            }
        }

        stage('Update_Kubeconfig') {
            steps {
                script {
                    sh "aws eks --region $AWS_REGION update-kubeconfig --name $CLUSTER_NAME"
                }
            }
        }

        stage('Deploy_To_EKS') {
            steps {
                script {
                    sh """
                        kubectl apply -f k8s/namespace.yml,k8s/deployment.yml,k8s/service.yml
                        kubectl set image deployment/finacplus-deployment finacplus-con=$REGISTRY_REPO/$IMAGE_NAME:$IMAGE_TAG -n finacplus
                    """
                }
            }
        }
    }
    post {
      success {
          script {
              // Actions to take if the pipeline is successful
              echo 'Pipeline completed successfully!'
            }
        }
      failure {
          script {
              // Actions to take if the pipeline fails
              echo 'Pipeline failed!'
            }
        }
    }
}
