import groovy.transform.Field
@Field changed_files


def call(Map config_map){
    echo 'Just got into the githelper call'
    get_changed_files(config_map)
}

void get_changed_files(Map config_map){
    echo 'Just got to the changed files section'
    changed_files = sh(
        script: """
            git diff-tree --no-commit-id --name-only -r HEAD
        """,
        returnStdout: true
    ).trim()
    config_map.changed_files = changed_files

    echo changed_files

}