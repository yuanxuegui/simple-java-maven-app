pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }
    stage('Test') {
      when { branch 'master' }
      steps {
        sh 'mvn test'
      }
      post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
      }
    }
    stage('Deploy') {
        when {
            anyOf {
                environment name: 'DEPLOY_TO', value: 'prod'
                environment name: 'DEPLOY_TO', value: 'uat'
            }
        }
        steps {
            echo 'Deploying'
        }
     }
    stage('Deliver') {
      steps {
        sh './jenkins/scripts/deliver.sh'
      }
    }
  }
  post {        
        always {            
            echo 'One way or another, I have finished'            
            deleteDir() /* clean up our workspace */        
        }        
        success {            
            echo 'I succeeeded!'        
        }        
        unstable {            
            echo 'I am unstable :/'        
        }        
        failure {            
            echo 'I failed :('        
        }        
        changed {            
            echo 'Things were different before...'        
        }    
  }
  environment {
    JAVA_HOME = '/usr/local/java/jdk1.8.0_131'
  }
}
