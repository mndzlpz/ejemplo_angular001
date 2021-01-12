pipeline {
  environment {
    nameImage = "mndzdocker/ejemplo-angular"
    registryCredential = 'e1dd5e3f-4b2a-4416-97e3-591570b879d7'
    dockerImage = ''
    k3s ='kubernetes_config_cluster'
    ambiente=""
    config_cluster="/var/lib/jenkins/.kube/"
    

  }

  agent any
  stages {


    stage('Checkout') {
      steps{
        //sh "kubectl config view"
        sh 'echo ${HOME}'
        echo "Build Number:  $BUILD_NUMBER"
        //echo "Branch:  env.BRANCH_NAME"
      }
    }

    stage('Set Environment') {
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
            config_cluster="${config_cluster}config_prod"
        } else {
            echo 'I execute elsewhere'
            nameImage=nameImage+"_dev"
            ambiente="Desarrollo"
            config_cluster="${config_cluster}config_dev"
        }
      }

      echo "Pipeline de: ${ambiente} version: $BUILD_NUMBER sobre el archivo de configuracion:  ${config_cluster}"
      //sshagent(credentials:['ssh_k3s']) {
      //  sh 'ssh azureuser@52.150.16.236 hostname'
      //}

      }
    }

//stage('Test') {
//stages {  
//parallel{
  
stage('Code Analysis') {
 
      steps{
        //sh "kubectl config view"
        sh 'echo ${HOME}'
        echo "Build Number:  $BUILD_NUMBER"
        //echo "Branch:  env.BRANCH_NAME"
      }
    }
stage('Testing') {

      steps{
        //sh "kubectl config view"
        sh 'echo ${HOME}'
        echo "Build Number:  $BUILD_NUMBER"
        //echo "Branch:  env.BRANCH_NAME"
      }
    }    


  

    stage('Build') {
      steps{
        echo "Construyendo Imagen: ${nameImage}"
        script {
          dockerImage = docker.build "${nameImage}"
        }
      }
    }
    
    stage('Publish') {
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

    stage("Deploy K8S"){
      steps{

        
        echo "Deploy K8S...: ${config_cluster}"
        //sh 'echo ${KUBECONFIG}'

        sh ("kubectl --kubeconfig ${config_cluster} config view")
	      sh ("kubectl --kubeconfig ${config_cluster} apply -f deploy_app.yaml")
        //kubernetesDeploy( configs : 'deploy_app.yaml' , kubeconfigId : 'config_K3s', enableConfigSubstitution: true)
      }
    }

     stage('Clean') {
      steps{
        //echo "Borrando Imagen: docker rmi ${registry}:$BUILD_NUMBER"
        //sh "docker rmi ${registry}:$BUILD_NUMBER"
        
        sh "docker rmi ${nameImage}:${BUILD_NUMBER}"
        sh "docker rmi ${nameImage}:latest"

      }
    }
    
  }
}