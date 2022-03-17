def call(Map config_map = [:], Map stage_map = [:])
{
    Closure stage =
    {
        gitHelper(config_map)
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
        stage_map.docker = stage
}

