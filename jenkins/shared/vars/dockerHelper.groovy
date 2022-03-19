def call(Map config = [:], ArrayList stage_list ) {
    def buildable_projects_map = [
        flask: 'flask',
        nginx: 'nginx'

    ]
    stage_list.add({
        stage('Determine Builds') {
            def changed_files = config.changed_git_files
            buildable_projects_map.each({key, value ->
                if(changed_files.contains("images/${key}")) {
                    docker_image_builder(stage_list, "sg_${value}",value)
                    docker_image_pusher(stage_list, "sg_${value}")
                }
            })
        }
    })
}

def docker_image_builder(ArrayList stage_list, String build_name, String folder_name) {
    stage_list.add({
        stage("Build ${build_name} image") {
            container('docker') {
                sh """
                    cd ${folder_name}
                    docker image build -t enf3rno/${build_name}:$BUILD_NUMBER .
                """
            }
        }
    })
}

def docker_image_pusher(ArrayList stage_list, String build_name) {
    stage_list.add({
        stage("Push ${build_name} image") {
            container('docker') {
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh """
                        docker login -u ${username} -p ${password}
                        docker image push ${username}/${build_name}:$BUILD_NUMBER
                    """
                }
            }
        }
    })
}

