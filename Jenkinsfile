def getKubernetesConfig(branch) {
  def tmpKubernetesConfig = "/var/lib/jenkins/.kube/"
  if (branch == 'development') {
    tmpKubernetesConfig = "${tmpKubernetesConfig}config_dev"
  } else if (branch == 'qa'){
    tmpKubernetesConfig = "${tmpKubernetesConfig}config_qa"
  } else if (branch == 'master'){
    tmpKubernetesConfig = "${tmpKubernetesConfig}config_prod"
  }
  return tmpKubernetesConfig
}

pipeline {
  environment {
    nameImage = "mndzdocker/ejemplo-angular"
    registryCredential = 'e1dd5e3f-4b2a-4416-97e3-591570b879d7'
    dockerImage = ''
    k3s ='kubernetes_config_cluster'
    ambiente=""
    nameKubeConfig = getKubernetesConfig(env.GIT_BRANCH)

  }

  agent any
  stages {


    stage('Checkout') {
      steps{

        sh 'echo ${HOME}'
        echo "Build Number:  $BUILD_NUMBER"
        echo "Branch:  ${env.BRANCH_NAME}"
        echo "Branch:  ${nameKubeConfig}"

      }
    }

    stage('Set Environment') {
      steps{

        script {
        if (env.BRANCH_NAME == 'master') {
            echo 'I only execute on the master branch'
            nameImage=nameImage+"_prod"
            ambiente="Produccion"

        } else if (env.BRANCH_NAME == 'qa'){
            echo 'I execute elsewhere'
            nameImage=nameImage+"_qa"
            ambiente="Calidad"

        } else if (env.BRANCH_NAME == 'development'){
            echo 'I execute elsewhere'
            nameImage=nameImage+"_dev"
            ambiente="Desarrollo"

        }

      }
      
      
      echo "Pipeline de: ${ambiente} version: $BUILD_NUMBER sobre el archivo de configuracion:  ${nameKubeConfig}"
      
      //sshagent(credentials:['ssh_k3s']) {
      //  sh 'ssh azureuser@52.150.16.236 hostname'
      //}

      }
    }

//stage('Test') {
//stages {  
//parallel{
  /*
  
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

*/
  

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

        
        echo "Deploy K8S...:"
        //sh 'echo ${KUBECONFIG}'

        sh ("kubectl --kubeconfig ${nameKubeConfig} config view")
	      sh ("kubectl --kubeconfig ${nameKubeConfig} apply -f deploy_app.yaml")
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