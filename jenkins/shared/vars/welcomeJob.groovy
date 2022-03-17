//This is a jenkins shared library, it must be in a vars folder.
// When a shared library is referred from the Jenkins job, Jenkins, by default, will invoke the call() function within our Groovy file. Consider the call() function like the main() method in Java. We can also specify parameters for the call() function if we want to.
def call(String name = 'User') {
 echo "Welcome, ${name}."
}