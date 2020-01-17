pipeline {
    agent {
        label 'master'
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