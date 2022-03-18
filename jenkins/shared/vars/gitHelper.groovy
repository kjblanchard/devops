def call(Map config_map, ArrayList stage_list){
    stage_list.add({
        stage('Git Helper')
        {
            container('git')
            {
                script{
                    get_changed_files(config_map)

                }
            }
        }
    })
}

void get_changed_files(Map config_map){
    config_map.hi = sh(script: 'git diff --name-only HEAD HEAD~1', returnStdout: true)
    echo config_map.hi
}