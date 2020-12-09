pipeline {
  environment {
    registry = "mndzdocker/ejemplo-angular"
    registryCredential = 'e1dd5e3f-4b2a-4416-97e3-591570b879d7'
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
        script {
          docker.withRegistry( '', registryCredential ) {
            //-dockerImage.push("$BUILD_NUMBER")
            dockerImage.push()

          }
        }
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

    /*
    stage("Deploy App K8S"){
      steps{
        echo 'Deploy K8S...'
	      kubernetesDeploy(
		      configs:'deploy_app.yaml',
		      kubeconfigId: 'kubernetes_config_cluster',
		      enableConfigSubstitution: true
	      )
      }
    }
    */
  }
}