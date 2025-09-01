pipeline {
    agent any

    environment {
        DEV_REPO  = "balajiyuva/dev"
        PROD_REPO = "balajiyuva/prod"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                      echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                      chmod +x ./build.sh
                      ./build.sh "${BRANCH_NAME}" "${BUILD_NUMBER}" "$DOCKER_USER" "$DOCKER_PASS" "${DEV_REPO}" "${PROD_REPO}"
                      docker logout
                    """
                }
            }
        }

       stage('Deploy') {
    when { anyOf { branch 'dev'; branch 'master' } }
    steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh """
              chmod +x ./deploy.sh
              ./deploy.sh "${BRANCH_NAME}" "${BUILD_NUMBER}" "${DEV_REPO}" "${PROD_REPO}" "$DOCKER_USER" "$DOCKER_PASS"
            """
        }
    }
}


    post {
        success { echo "✅ Build & push successful for ${env.BRANCH_NAME}" }
        failure { echo "❌ Build failed for ${env.BRANCH_NAME}" }
    }
}
