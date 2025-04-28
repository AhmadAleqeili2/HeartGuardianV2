buildscript {
    repositories {
        google()
        mavenCentral()
    }
dependencies {
    classpath("com.android.tools.build:gradle:8.1.1")
    classpath("com.google.gms:google-services:4.3.15") // Ensure this line is present
}
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)
rootProject.allprojects {
    tasks.withType<JavaCompile> {
        options.encoding = "UTF-8"
    }
}
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
