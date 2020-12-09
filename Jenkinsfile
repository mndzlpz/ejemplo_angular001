pipeline {
  environment {
    registry = "mndzdocker/ejemplo-angular"
    registryCredential = 'e1dd5e3f-4b2a-4416-97e3-591570b879d7'
    nameImage="${registry}"+ ":$BUILD_NUMBER"
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
    stage('cmd prueba') {
      steps{
        sh "pwd"
        sh 'echo ${HOME}'

        
      }
    }

    stage('Building image') {
      steps{
        echo "Construyendo Imagen: "
        script {
          //dockerImage = docker.build "${nameImage}"
          dockerImage = docker.build "${registry}"
        }
      }
    }
    
    stage('Push Image-Registry') {
      steps{
        echo 'Push Image...'
        script {
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push("$BUILD_NUMBER")
            //dockerImage.push()

          }
        }
      }
    }
    
    stage('Remove Unused docker image') {
      steps{
        //echo "Borrando Imagen: docker rmi ${registry}:$BUILD_NUMBER"
        //sh "docker rmi ${registry}:$BUILD_NUMBER"
        sh "docker rmi ${registry}:$BUILD_NUMBER"

      }
    }
    

    
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
    
  }
}