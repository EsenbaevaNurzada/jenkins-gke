pipeline {
agent any
environment {
    PROJECT_ID = 'triple-poetry-351115'
    CLUSTER_NAME = 'cluster-1'
    LOCATION = 'us-central1-c'
    CREDENTIALS_ID = 'service-account'
}

stages {
    stage('Checkout') {
        steps {
            checkout scm
        }
    }
    stage('Build image') {
        steps {
            script {
                app = docker.build("beknazar007/to_do_image:${env.BUILD_ID}")
                }
        }
    }
    
    stage('Push image') {
        steps {
            script {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'pass', usernameVariable: 'name')]) {
                    sh ('docker login -u $name -p $pass ')
                }
                app.push("${env.BUILD_ID}")
             }
                             
        }
    }

        


    stage('Deploy to K8s') {
        steps{
            sh "sed -i 's/to_do_image:latest/to_do_image:${env.BUILD_ID}/g' deployment.yaml"
            step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
        
            }
        }
    }  
}  
