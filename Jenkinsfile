pipeline {
  agent any
  environment {
    JAVA_HOME = '/usr/local/java/jdk1.8.0_131'
  }
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
	  when { branch 'dev' }
      steps {
        sh './jenkins/deploydev.sh'
      }
    }
    stage('Deploy - UAT') {
	  when { expression { return BRANCH_NAME =~ 'uat_.*' } }
	  steps {
		sh './jenkins/deployuat.sh'
	  }
    }
	stage('Deploy - PROD') {
	  when { branch 'master' }
      steps {
        sh './jenkins/deployprod.sh'
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
}
