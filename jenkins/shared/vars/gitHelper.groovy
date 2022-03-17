import groovy.transform.Field
@Field changed_files


def call(){
    echo 'Just got into the githelper call'
    get_changed_files()
}
void get_changed_files(){
    echo 'Just got to the changed files section'
    def script_content = libraryResource('get_changed_files.sh')
    writeFile file: './get_changed_files.sh', text: script_content
    sh(script: 'chmod +x get_changed_files.sh')
    def changed_files_1 = sh(
        script: """
            ls
            git diff --name-only HEAD HEAD~1
        """
        returnStdout: true
    )
    echo changed_files_1
    def changed_files = sh(
        script: './get_changed_files.sh',
        returnStdout: true
    ).split()
    echo changed_files

}