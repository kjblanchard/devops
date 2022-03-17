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
                        container('git')
                        {
                            echo 'Just got to the changed files section'
                            def changed_files = sh(
                                script: """
                                echo hi
                                ls
                                    git diff-tree --no-commit-id --name-only -r HEAD
                                """,
                                returnStdout: true
                            ).trim()
                            echo 'just finished this'
                            config_map.changed_files = changed_files
                            echo 'now just finished this'

                        }
                        // stages_map.docker(config_map)

                    }

                }
            }
        }
    }
}