allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    val configureAndroid = Action<Project> {
        if (hasProperty("android")) {
            val androidExt = extensions.findByName("android")
            androidExt?.let { ext ->
                try {
                    // Try compileSdkVersion(int)
                    val method = ext.javaClass.getMethod("compileSdkVersion", Int::class.javaPrimitiveType)
                    method.invoke(ext, 36)
                } catch (e: Exception) {
                    try {
                        // Try setCompileSdk(Integer)
                        val method = ext.javaClass.getMethod("setCompileSdk", java.lang.Integer::class.java)
                        method.invoke(ext, 36)
                    } catch (e2: Exception) {}
                }
            }
        }
    }
    if (state.executed) {
        configureAndroid.execute(this)
    } else {
        afterEvaluate(configureAndroid)
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
