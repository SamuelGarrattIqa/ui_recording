pipeline {
    agent {
        label 'docker-compose'
    }
    options { buildDiscarder(logRotator(numToKeepStr: '2')) }
    stages {
        stage('matrix') {
            matrix {
                agent {
                    node {
                        label 'master'
                        customWorkspace "~/.jenkins/workspace/recording_${BROWSER}"
                    }
                }
                axes {
                    axis {
                        name 'BROWSER'
                        values 'chrome', 'firefox'
                    }
                }
                stages {
                    stage('Test') {
                        steps {
                            sh 'docker-compose up --abort-on-container-exit --exit-code-from test'
                            sh 'docker run -v $PWD/manual:/source jagregory/pandoc --from=markdown --to=docx --output=test.docx training.md'
                        }
                        post {
                            always {
                                junit 'logs/*.xml'
                                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'tmp', reportFiles: 'dashboard.html',
                                            reportName: "Video recording ${BROWSER}"])
                                archiveArtifacts artifacts: 'manual/test.docx', onlyIfSuccessful: true
                            }
                        }
                    }
                }
            }
        }
    }
}