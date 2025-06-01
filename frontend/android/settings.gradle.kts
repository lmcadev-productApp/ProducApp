pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        val localPropertiesFile = file("local.properties")

        if (localPropertiesFile.exists()) {
            localPropertiesFile.inputStream().use { properties.load(it) }
            properties.getProperty("flutter.sdk")
                ?: error("flutter.sdk not set in local.properties")
        } else {
            // Si no está local.properties, lee la variable de entorno
            System.getenv("FLUTTER_SDK_PATH")
                ?: error("local.properties not found and FLUTTER_SDK_PATH env var not set")
        }
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
}

include(":app")
