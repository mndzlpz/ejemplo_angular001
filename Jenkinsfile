pipeline {
  environment {
    registry = "mndzdocker/ejemplo-angular"
    registryCredential = 'dockerhub'
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
        echo "Construyendo Imagen: ${registry}"+ ":$BUILD_NUMBER"
        script {
          dockerImage = docker.build "${registry}"+ ":$BUILD_NUMBER"
        }
      }
    }
    
    stage('Deploy Image') {
      steps{
        echo 'Deploy...'
        //script {
        //  docker.withRegistry( '', registryCredential ) {
            //-dockerImage.push("$BUILD_NUMBER")
         //    dockerImage.push()

         // }
        //}
      }
    }
    /*
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:$BUILD_NUMBER"
         sh "docker rmi $imagename:latest"

      }
    }
    */
  }
}