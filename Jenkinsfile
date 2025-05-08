pipeline {
    agent any

    environment {
        IMAGE = 'your-dockerhub-username/fastapi-app'
    }

    stages {

        stage('Checkout') {
  steps {
    git url: 'https://github.com/your-org/fastapi-cicd.git',
        credentialsId: 'github-creds'
  }
}

        stage('Quality Checks') {
            parallel {
                stage('Lint') {
                    steps {
                        sh 'pip install flake8 && flake8 app/'
                    }
                }
                stage('Unit Tests') {
                    steps {
                        sh 'pip install -r requirements.txt && pytest tests/'
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE}:${BUILD_NUMBER} ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo $PASS | docker login -u $USER --password-stdin
                        docker push ${IMAGE}:${BUILD_NUMBER}
                    '''
                }
            }
        }

        stage('Deploy to Staging') {
            steps {
                sh './scripts/deploy_staging.sh'
            }
        }

        stage('Approval for Prod') {
            steps {
                input message: 'Deploy to production?', ok: 'Deploy now!'
            }
        }

        stage('Deploy to Production') {
            steps {
                sh './scripts/deploy_prod.sh'
            }
        }
    }

    post {
        success {
            echo "🎉 CI/CD complete!"
        }
        failure {
            echo "❌ CI/CD failed!"
        }
    }
}
