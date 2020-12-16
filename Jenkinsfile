pipeline {
  environment {

    nameImage = "mndzdocker/ejemplo-angular"
    registryCredential = 'e1dd5e3f-4b2a-4416-97e3-591570b879d7'
    dockerImage = ''
    k3s ='kubernetes_config_cluster'
  }
  agent any
  stages {

    stage('cmd prueba') {
      steps{
        //sh "kubectl config view"
        sh 'echo ${HOME}'
        echo "Push Image... $BUILD_NUMBER"
        echo "Branch:  $BRANCH_NAME"
      }
    }

    stage('Building image') {
      steps{
        echo "Construyendo Imagen: ${nameImage}"
        script {
          dockerImage = docker.build "${nameImage}"
        }
      }
    }
    
    stage('Push Image-Registry') {
      steps{
        echo "Push Image... $BUILD_NUMBER"
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
            dockerImage.push('latest')
          }
        }
      }
    }
    /*
    stage("Deploy App K8S"){
      steps{
        echo 'Deploy K8S...'

	      sh ("kubectl apply -f deploy_app.yaml")
        //kubernetesDeploy( configs : "deploy_app.yaml" , kubeconfigId : k3s )
		    //  enableConfigSubstitution: true)
	      
      }
    }
*/
     stage('Remove images') {
      steps{
        //echo "Borrando Imagen: docker rmi ${registry}:$BUILD_NUMBER"
        //sh "docker rmi ${registry}:$BUILD_NUMBER"
        
        sh "docker rmi ${nameImage}:${BUILD_NUMBER}"
        sh "docker rmi ${nameImage}:latest"

      }
    }
    
  }
}