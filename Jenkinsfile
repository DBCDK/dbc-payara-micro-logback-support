#!groovy

def workerNode = 'devel8'
def imageName = 'dbc-payara-micro-logback'

def current_4_version="4.1.2.181"
def current_5_version="5.0.0.Alpha3"
def next_4_version="4.1.2.183"
def next_5_version="5.0.0.Alpha4"

void build_and_push(imageName, version, buildnum, branchName, tagName){
    image=docker.build( "${imageName}-${version}-${branchName}:${buildnum}".toLowerCase(),
                        "--build-arg PAYARA_MICRO_VERSION=${version} --pull --no-cache ." )
    docker.withRegistry( 'https://docker.dbc.dk', 'docker' ) {
        image.push()
        sh "docker tag docker.dbc.dk/${imageName.toLowerCase()}-${version.toLowerCase()}-${branchName.toLowerCase()}:${buildnum} docker.dbc.dk/${tagName}"
        sh "docker push docker.dbc.dk/${tagName}"
    }
}

pipeline {

    agent {label workerNode}

    stages {
        stage("checkout") {
            steps {
                checkout scm
            }
        }

        stage('build_and_push') {
            parallel {

                    stage("payara4-current") {
                        steps {
                            build_and_push( imageName, current_4_version, env.BUILD_NUMBER, env.BRANCH_NAME, "dbc-payara-micro-4-logback:latest" )
                        }
                    }

                    stage("payara4-next") {
                        steps {
                            build_and_push( imageName, next_4_version, env.BUILD_NUMBER, env.BRANCH_NAME, "dbc-payara-micro-4-logback:next" )
                        }
                    }

                    stage("payara5-current") {
                        steps {
                            build_and_push( imageName, current_5_version, env.BUILD_NUMBER, env.BRANCH_NAME, "dbc-payara-micro-5-logback:latest" )
                        }
                    }

                    stage("payara5-next") {
                        steps {
                            build_and_push( imageName, next_5_version, env.BUILD_NUMBER, env.BRANCH_NAME, "dbc-payara-micro-5-logback:next" )
                        }
                    }

                }

            }

        }
}
