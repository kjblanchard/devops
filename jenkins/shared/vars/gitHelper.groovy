import groovy.transform.Field
@Field changed_files

def call(){
    echo 'Just got into the githelper call'
    get_changed_files()
}
void get_changed_files(){
    echo 'Just got to the changed files section'
    def script_content = libraryResource './bash/get_changed_files.sh'
    writeFile file: './get_changed_files.sh', text: script_content
    def changed_files = sh(
        script: './get_changed_files.sh',
        returnStdout: True
    ).split()
    echo changed_files

}