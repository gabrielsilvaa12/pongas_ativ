plugins {
    id "com.android.application"
    id "kotlin-android"
    id "com.google.gms.google-services"
}

android {
    namespace "com.example.pongas_ativ"
    compileSdk 34

    defaultConfig {
        applicationId "com.example.pongas_ativ"
        minSdk 21
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            minifyEnabled false
            shrinkResources false
            proguardFiles getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro"
        }
    }
}

dependencies {
    implementation platform('com.google.firebase:firebase-bom:33.1.1')
    implementation 'com.google.firebase:firebase-auth'

    implementation 'com.google.android.gms:play-services-auth:20.7.0'

    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.9.10"
}
