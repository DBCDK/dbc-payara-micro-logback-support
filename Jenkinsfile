#!groovy

def workerNode = 'devel8'
def imageName = 'dbc-payara-micro-logback'

def current_4_version="4.1.2.181"
def current_5_version="5.0.0.Alpha3"
def next_4_version="4.1.2.183"
def next_5_version="5.0.0.Beta2"

void tag_and_push(imageName, tagName, branch){
    name = imageName.toLowerCase()
    if(branch=='master') {
        sh "docker tag docker.dbc.dk/${name} docker.dbc.dk/${tagName}"
        sh "docker push docker.dbc.dk/${tagName}"
    }
}


void build_and_push( imageName, version, buildnum ){
    name = imageName.toLowerCase()
    image=docker.build( "${name}:${version}-${buildnum}",
                        "--build-arg PAYARA_MICRO_VERSION=${version} --pull --no-cache ." )
    docker.withRegistry( 'https://docker.dbc.dk', 'docker' ) {
        image.push()
    }
}

pipeline {

    agent {label workerNode}

    stages {

        stage('build_and_push') {
            parallel {

                    stage("payara4-current") {
                        steps {
                            build_and_push( imageName, current_4_version, env.BUILD_NUMBER )

                            tag_and_push( "${imageName}:${current_4_version}-${env.BUILD_NUMBER}",
                                            "${imageName}:${current_4_version}",
                                            env.BRANCH_NAME )

                            tag_and_push( "${imageName}:${current_4_version}-${env.BUILD_NUMBER}",
                                            "${imageName}:4",
                                            env.BRANCH_NAME  )
                        }
                    }


                    stage("payara4-next") {
                        steps {
                            build_and_push( imageName, next_4_version, env.BUILD_NUMBER )

                            tag_and_push( "${imageName}:${next_4_version}-${env.BUILD_NUMBER}",
                                            "${imageName}:${next_4_version}",
                                            env.BRANCH_NAME  )
                        }
                    }

                    stage("payara5-current") {
                        steps {
                            build_and_push( imageName, current_5_version, env.BUILD_NUMBER )

                            tag_and_push( "${imageName}:${current_5_version}-${env.BUILD_NUMBER}",
                                            "${imageName}:${current_5_version}",
                                            env.BRANCH_NAME  )

                            tag_and_push( "${imageName}:${current_5_version}-${env.BUILD_NUMBER}",
                                            "${imageName}:5",
                                            env.BRANCH_NAME  )
                        }
                    }

                    stage("payara5-next") {
                        steps {
                            build_and_push( imageName, next_5_version, env.BUILD_NUMBER )

                            tag_and_push( "${imageName}:${next_5_version}-${env.BUILD_NUMBER}",
                                            "${imageName}:${next_5_version}",
                                            env.BRANCH_NAME  )
                        }
                    }


                }

            }

        }
}
