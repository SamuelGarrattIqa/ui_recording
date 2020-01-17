pipeline {
    agent {
        label 'master'
    }
    stages {
        stage('matrix') {
            matrix {
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
                    }
                }
            }
        }
    }
    post {
        always {
            junit 'logs/*.xml'
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: true, reportDir: 'tmp', reportFiles: 'dashboard.html',
                        reportName: 'Video recording', reportTitles: ''])
            archiveArtifacts artifacts: 'manual/test.docx', onlyIfSuccessful: true
        }
    }
}