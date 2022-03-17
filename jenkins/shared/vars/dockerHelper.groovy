def call(Map config_map = [:], Map stage_map = [:])
{
        def stage = {stage ('Get git info'){
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

        stage_map.docker = stage

    }