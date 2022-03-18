import groovy.transform.Field
// @Field changed_files


def call(Map config_map, List stage_list){
    stage_list.add({
        stage('Git Helper')
        {
            container('git')
            {
                echo 'Just got into the githelper call'
                get_changed_files(config_map)
            }
        }
    })
}

void get_changed_files(Map config_map){
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