// Author: Sebastian Warnholz
pipeline {
    agent { label 'eh2' }
    options { disableConcurrentBuilds() }
    triggers {
        cron('H 0 * * *')
    }
    environment {
        LABEL = sh(script: '''
        if [ $BRANCH_NAME = "master" ]; then
            echo "latest"
        else
            echo $BRANCH_NAME
        fi
        ''', , returnStdout: true).trim()
    }
    stages {

        stage('R Version with Ubuntu') {
            steps {
                sh '''
                docker build --pull -t inwt/r-ver-ubuntu:$LABEL r-ver-ubuntu
                docker push inwt/r-ver-ubuntu:$LABEL
                '''
            }
        }
        stage('r-base') {
            steps {
                sh '''
                docker build -t inwt/r-base:$LABEL r-base
                docker push inwt/r-base:$LABEL
                '''
            }
        }
        stage('r-batch') {
            steps {
                sh '''
                docker build -t inwt/r-batch:$LABEL r-batch
                docker push inwt/r-batch:$LABEL
                '''
            }
        }
        stage('r-shiny') {
            steps {
                sh '''
                docker build -t inwt/r-shiny:$LABEL r-shiny
                docker push inwt/r-shiny:$LABEL
                '''
            }
        }
    }
}
