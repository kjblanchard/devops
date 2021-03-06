def call(Map config_map, ArrayList stage_list){
    stage_list.add({
        stage('Git Helper')
        {
            container('git')
            {
                    get_changed_files(config_map)

            }
        }
    })
}

void get_changed_files(Map config_map){
    config_map.changed_git_files = sh(script: 'git diff-tree --no-commit-id --name-only -r HEAD', returnStdout: true)
}