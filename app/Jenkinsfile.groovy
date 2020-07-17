pipeline {
  agent {
    node {
      label 'docker'
    }
  }

  stages {
    stage('Build') {
      steps {
        sh "docker build -t 100-jokes:0.1.${env.BUILD_NUMBER} -f ./app/Dockerfile ./app"
      }
    }

    stage('Deploy') {
      steps {
        sh "docker kill app"
        sh "docker run -p 3000:3000 --name app 100-jokes:0.1.${env.BUILD_NUMBER}"
      }
    }
  }
}