def call(Map config_map, ArrayList stage_list){
    stage_list.add({
        stage('Git Helper')
        {
            container('git')
            {
                echo 'Just got into the githelper call'
                def changed_files = sh(
                    script: """
                    ls
                    git status
                    git log --oneline
                        git diff --name-only HEAD HEAD~1
                    """,
                    returnStdout: true
                ).trim()
                config_map.changed_files = changed_files
                // get_changed_files(config_map)
            }
        }
    })
}

void get_changed_files(Map config_map){
    def changed_files = sh(
        script: """
        ls
        git status
        git log --oneline
            git diff --name-only HEAD HEAD~1
        """,
        returnStdout: true
    ).trim()
    config_map.changed_files = changed_files
}