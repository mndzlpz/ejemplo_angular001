pipeline {
  environment {
    nameImage = "mndzdocker/ejemplo-angular"
    registryCredential = 'e1dd5e3f-4b2a-4416-97e3-591570b879d7'
    dockerImage = ''
    k3s ='kubernetes_config_cluster'
    ambiente=""
    

  }

  agent any
  stages {

    stage('cmd prueba') {
      steps{
        //sh "kubectl config view"
        sh 'echo ${HOME}'
        echo "Build Number:  $BUILD_NUMBER"
        //echo "Branch:  env.BRANCH_NAME"

        script {
        if (env.BRANCH_NAME == 'master') {
            echo 'I only execute on the master branch'
            nameImage=nameImage+"_prod"
            ambiente="Produccion"
        } else {
            echo 'I execute elsewhere'
            nameImage=nameImage+"_dev"
            ambiente="Desarrollo"
        }
      }

      echo "Pipeline de: ${ambiente} version: $BUILD_NUMBER"
      sshagent(['ssh_k3s']) {
        sh "ssh azureuser@52.150.16.236 hostname"
    
      }

      }
    }

    stage('Building image:') {
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

    stage("Deploy App K8S"){
      steps{
        echo 'Deploy K8S...'

	      //sh ("kubectl apply -f deploy_app.yaml")
        kubernetesDeploy( configs : "deploy_app.yaml" , kubeconfigId : K3s_connect, enableConfigSubstitution: true)
	      
      }
    }

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