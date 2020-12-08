pipeline {
  environment {
    imagename = "nombre"
    registryCredential = ''
    dockerImage = ''
  }
  agent any
  stages {
    /*
    stage('Cloning Git') {
      steps {
        git([url: 'URL', branch: 'master', credentialsId: 'Name_credenciales'])

      }
    }
    */
    stage('Building image') {
      steps{
        sh 'docker -v'
        echo "Database engine is ${imagename}"
        //script {
        //  dockerImage = docker.build imagename
        //}
      }
    }
    /*
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
             dockerImage.push('latest')

          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:$BUILD_NUMBER"
         sh "docker rmi $imagename:latest"

      }
    }
    */
  }
}