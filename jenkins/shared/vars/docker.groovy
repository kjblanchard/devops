def call(Map config_map = [:])
{
    pipeline {
    agent {
        kubernetes {
        defaultContainer 'jnlp'
        yaml """
    apiVersion: v1
    kind: Pod
    metadata:
    labels:
    component: ci
    spec:
    serviceAccountName: jenkins
    containers:
    - name: docker
        image: docker:latest
        command:
        - cat
        tty: true
        volumeMounts:
        - mountPath: /var/run/docker.sock
        name: docker-sock
    - name: git
        image: alpine/git:latest
        command:
        - cat
        tty: true
    volumes:
        - name: docker-sock
        hostPath:
            path: /var/run/docker.sock
    """
    }
    }
    stages {
        stage ('Get git info'){
        steps {
            container('git')
            {
            gitHelper(config_map)
            }
        }
        }
        stage('Push') {
        steps {
            container('docker') {
            sh """
            ls
            cd flask
                docker image build -t sg_flask:$BUILD_NUMBER .
            """
            }
        }
        }
    }
    }

}