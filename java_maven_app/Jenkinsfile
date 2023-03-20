pipeline {
    agent any
    tools {
        maven 'maven-3.6'
    }
    stages {
        stage("build jar") {
            steps {
                script {
                    echo 'buiding the application...'
                    sh 'mvn package'
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    echo 'buiding the docker image'
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-wandexdev', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'docker build -t wandexdev/wandek8s:1.0 .'
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh 'docker push wandexdev/wandek8s:1.0'
                    }
                }
            }
        }        
        stage("deploy") {
            steps {
                script {
                    echo 'deploy the application...'
                }
            }
        }
    }
}