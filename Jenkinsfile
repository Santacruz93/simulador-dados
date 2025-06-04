pipeline {
    agent any

    environment {
        registry = "josesantacruz1993/simulador-dados"
        registryCredentials = "dockerhub"
        project = "Actividad_3"
        repository = "https://github.com/Santacruz93/simulador-dados.git"
        repositoryCredentials = "github"
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout code') {
            steps {
                script {
                    git branch: 'feature/rol',
                        credentialsId: repositoryCredentials,
                        url: repository
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build(registry)
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    try {
                        sh 'docker run --name $project -e "LENGTH=20" $registry'
                    } finally {
                        sh 'docker rm $project'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('', registryCredentials) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Cleaning Up') {
            steps {
                script {
                    sh 'docker rmi $registry'
                }
            }
        }
    }

    post {
        always {
            echo 'Registrar Build'
        }
        failure {
            echo 'El pipeline ha fallado.'
        }
    }
}
