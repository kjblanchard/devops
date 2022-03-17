import groovy.transform.Field
import groovy.transform.SourceURI
import java.nio.file.Path
import java.nio.file.Paths

class ScriptSourceUri {
    @SourceURI
    static URI uri
}
@Field changed_files

def get_path(){
    Path scriptLocation = Paths.get(ScriptSourceUri.uri)
    return scriptLocation.getParent().getParent().resolve('resources').toString()
}

def call(){
    echo 'Just got into the githelper call'
    get_changed_files()
}
void get_changed_files(){
    def path = get_path()
    echo path
    echo 'Just got to the changed files section'
    def script_content = libraryResource('get_changed_files.sh')
    writeFile file: './get_changed_files.sh', text: script_content
    def changed_files = sh(
        script: './get_changed_files.sh',
        returnStdout: True
    ).split()
    echo changed_files

}