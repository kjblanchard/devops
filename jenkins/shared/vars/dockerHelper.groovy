def call(Map config = [:], ArrayList stage_list )
{
    stage_list.add(
    {
        stage('Push') {
            container('docker') {
                def changed_files = config.changed_files
                if (changed_files ==~ 'docker'){
                    echo 'DOCKER CHANGED'
                }
            sh """
            ls
            cd flask
                docker image build -t sg_flask:$BUILD_NUMBER .
            """
            }
        }
    }
    )
        // stage_map.docker = stage
}

