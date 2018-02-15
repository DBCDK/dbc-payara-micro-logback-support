#!groovy​
node('devel8-head') {

    def app
    def tag = 'db-payara-micro-logback'

    stage("checkout") {
        checkout scm
    }

    stage('build') {
        app = docker.build("$tag:${env.BUILD_NUMBER}", '--pull --no-cache .')
    }
    stage('push') {
        if (currentBuild.resultIsBetterOrEqualTo('SUCCESS')) {
            docker.withRegistry('https://docker.dbc.dk', 'docker') {
                app.push env.BRANCH_NAME
                if( env.BRANCH_NAME == "master" ) {
                    app.push "latest"
                }
            }
        }
    }
}

