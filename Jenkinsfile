pipeline {
  environment {
    imagename = "docker_angular"
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
        echo "Construyendo Imagen: ${imagename}"
        script {
          dockerImage = docker.build "${imagename}"
        }
      }
    }
    
    stage('Deploy Image') {
      steps{
        echo 'Deploy...'
        //script {
        //  docker.withRegistry( '', registryCredential ) {
        //    dockerImage.push("$BUILD_NUMBER")
        //     dockerImage.push('latest')

        //  }
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