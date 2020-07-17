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

    // ToDo add unit testing, vulnerability scanning

    stage('Deploy') {
      steps {
        sh "docker kill app || true && docker rm app || true"
        sh "docker run -d -p 3000:3000 --name app 100-jokes:0.1.${env.BUILD_NUMBER}"
      }
    }
  }
}
