pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }
    stage('Test') {
      when { branch 'dev' }
      steps {
        sh 'mvn test'
      }
      post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
      }
    }
    stage('Deploy - DEV') {
      steps {
        echo 'Deploying DEV'
      }
    }
	stage('Sanity check - DEV') {
		steps {
			input "Does the DEV environment look ok?"
		}
    }
    stage('Deploy - UAT') {
        steps {
            echo 'Deploying UAT'
        }
    }
	stage('Sanity check - UAT') {
		steps {
			input "Does the UAT environment look ok?"
		}
    }
	stage('Deploy - PROD') {
        steps {
            echo 'Deploying PROD'
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
