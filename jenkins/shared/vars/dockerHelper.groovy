def call(Map config = [:], ArrayList stage_list )
{
    stage_list.add(
    {
        stage('Determine Builds') {
                def changed_files = config.changed_git_files
                if (changed_files =~ /docker/){
                    docker_image_builder(stage_list, 'sg_flask', 'flask')
                    docker_image_pusher(stage_list, 'sg_flask')
                }
                if(changed_files =~ /git/){
                    echo 'GIT CHANGED'
                }
        }
    }
    )
        // stage_map.docker = stage
}

def docker_image_builder(ArrayList stage_list, String build_name, String folder_name) {
    stage_list.add({
        stage("Build ${build_name} image")
            container('docker') {

                sh """
                    cd ${folder_name}
                    docker image build -t ${build_name}:$BUILD_NUMBER .
                """
            }
    })
}
def docker_image_pusher(ArrayList stage_list, String build_name) {
    stage_list.add({
        stage("Push ${build_name} image")
            container('docker') {

                sh """
                    docker image push ${build_name}:$BUILD_NUMBER
                """
            }
    })
}

