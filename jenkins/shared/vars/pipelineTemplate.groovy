import groovy.transform.Field
@Field agent_yaml
agent_yaml = """
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

def call(Map config_map = [:], Map stages_map = [:], String agent_yaml_string = agent_yaml)
{
    pipeline {
        agent {
            kubernetes {
                defaultContainer 'jnlp'
                yaml agent_yaml
            }
        }
        stages {
            stage('Initialize Pipeline Template') {
                steps{
                    script{
                        stages_map.docker(config_map)

                    }

                }
            }
        }
    }
}