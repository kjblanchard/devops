def call(Map config_map = [:], Map stage_list = [:])
{
    stage_list.add(
    {
        stage('Push') {
            container('docker') {
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

