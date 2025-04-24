pipeline {
    agent any

    environment {
        PROJECT_NAME = "Calculator"
        VERSION = "v1.0.0"
        REPO_NAME = "fcalculator"
        REPO = "pyapril15/${REPO_NAME}"

        FLUTTER_HOME = 'C:\\Users\\pytwl\\dev\\flutter'
        PATH = "${env.PATH};${FLUTTER_HOME}\\bin"
        ANDROID_HOME = 'C:\\Users\\pytwl\\AppData\\Local\\Android\\Sdk' // Added ANDROID_HOME
        KEYSTORE_PATH = 'android\\app\\calculator.jks'
        KEY_PROPERTIES = 'android\\key.properties'

        BUILD_DIR = "build"
        APP_NAME = "${PROJECT_NAME}.apk"
        ANDROID_RELEASE = "${BUILD_DIR}/app/outputs/apk/release"
        ANDROID_BUILD_PATH = "${ANDROID_RELEASE}\\${APP_NAME}"

        EXE_NAME = "${PROJECT_NAME}.exe"
        WINDOW_RELEASE = "${BUILD_DIR}/windows/x64/runner/Release"
        WINDOW_BUILD_PATH = "${WINDOW_RELEASE}\\${EXE_NAME}"

        RELEASE_NAME = "Calculator ${VERSION}"
        RELEASE_FILENAME = "release.json"
        RELEASE_NOTES_MD = "latest_version.md"

        GITHUB_API_URL = "https://api.github.com/repos/${REPO}/releases"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out branch..."
                checkout scm
            }
        }

        stage('Setup Flutter') {
            steps {
                bat """
                    set "PATH=%PATH%;${FLUTTER_HOME}\\bin"
                    flutter doctor
                """
            }
        }

        stage('Setup Keystore & Properties') {
            steps {
                withCredentials([
                    file(credentialsId: 'ANDROID_STORE_FILE', variable: 'KEYSTORE'),
                    string(credentialsId: 'ANDROID_KEYSTORE_PASSWORD', variable: 'STORE_PASSWORD'),
                    string(credentialsId: 'ANDROID_KEY_PASSWORD', variable: 'KEY_PASSWORD'),
                    string(credentialsId: 'ANDROID_KEY_ALIAS', variable: 'KEY_ALIAS')
                ]) {
                    bat """
                        mkdir android
                        copy \"%KEYSTORE%\" \"%KEYSTORE_PATH%\"
                        echo storePassword=%STORE_PASSWORD%> %KEY_PROPERTIES%
                        echo keyPassword=%KEY_PASSWORD%>> %KEY_PROPERTIES%
                        echo keyAlias=%KEY_ALIAS%>> %KEY_PROPERTIES%
                        echo storeFile=calculator.jks>> %KEY_PROPERTIES%
                    """
                }
            }
        }

        stage('Flutter Clean & Pub Get') {
            steps {
                echo "Cleaning and fetching dependencies..."
                bat """
                    set "PATH=%PATH%;${FLUTTER_HOME}\\bin"
                    flutter clean
                    flutter pub get
                """
            }
        }

        stage('Build Android APK') {
            steps {
                bat """
                    set "PATH=%PATH%;${FLUTTER_HOME}\\bin"
                    set "ANDROID_HOME=%ANDROID_HOME%" // Ensure ANDROID_HOME is set in the bat environment
                    flutter build apk --release
                """
            }
        }

        stage('Build Windows EXE') {
            steps {
                bat """
                    set "PATH=%PATH%;${FLUTTER_HOME}\\bin"
                    flutter build windows --release
                """
            }
        }

        stage('Rename Windows EXE') {
            steps {
                bat "rename \"${WINDOW_RELEASE}\\calculator.exe\" \"${EXE_NAME}\""
            }
        }

        stage('Archive Artifacts') {
            steps {
                archiveArtifacts artifacts: "**/${APP_NAME}, **/${EXE_NAME}", fingerprint: true
            }
        }

        stage('Git Tag & Push') {
            steps {
                echo "Tagging release..."
                withCredentials([string(credentialsId: 'GITHUB_TOKEN', variable: 'github_token')]) {
                    bat """
                        git config user.name "pyapril15"
                        git config user.email "praveen885127@gmail.com"
                        git remote set-url origin https://%github_token%@github.com/%REPO%.git
                        git fetch --tags
                        git tag -d %VERSION% 2>NUL
                        git tag %VERSION%
                        git push origin %VERSION%
                    """
                }
            }
        }

        stage('GitHub Release') {
            steps {
                echo "Creating GitHub release..."
                withCredentials([string(credentialsId: 'GITHUB_TOKEN', variable: 'github_token')]) {
                    bat """
                        setlocal EnableDelayedExpansion
                        set "BODY="
                        for /F "usebackq delims=" %%A in ("%RELEASE_NOTES_MD%") do (
                            set "LINE=%%A"
                            set "LINE=!LINE:\"=\\\"!"
                            set "BODY=!BODY!!LINE!\\n"
                        )
                        (
                            echo {
                            echo   "tag_name": "%VERSION%",
                            echo   "name": "%RELEASE_NAME%",
                            echo   "body": "!BODY!",
                            echo   "draft": false,
                            echo   "prerelease": false
                            echo }
                        ) > %RELEASE_FILENAME%

                        curl -s -X POST %GITHUB_API_URL% ^
                             -H "Authorization: token %github_token%" ^
                             -H "Accept: application/vnd.github.v3+json" ^
                             -d @%RELEASE_FILENAME% ^
                             -o response.json
                    """
                }
            }
        }

        stage('Upload .apk and .exe') {
            steps {
                echo "Uploading APK and EXE to release..."
                withCredentials([string(credentialsId: 'GITHUB_TOKEN', variable: 'github_token')]) {
                    bat """
                        setlocal enabledelayedexpansion
                        for /F "tokens=* delims=" %%A in ('powershell -Command "(Get-Content response.json | ConvertFrom-Json).upload_url"') do (
                            set "UPLOAD_URL=%%A"
                        )
                        set "UPLOAD_URL=!UPLOAD_URL:{?name,label}=!"

                        if not exist "%ANDROID_BUILD_PATH%" (
                            echo ERROR: APK not found!
                            exit /b 1
                        )

                        if not exist "%WINDOW_BUILD_PATH%" (
                            echo ERROR: EXE not found!
                            exit /b 1
                        )

                        echo Uploading APK...
                        curl -s -X POST "!UPLOAD_URL!?name=%APP_NAME%" ^
                             -H "Authorization: token %github_token%" ^
                             -H "Content-Type: application/octet-stream" ^
                             --data-binary "@%ANDROID_BUILD_PATH%"

                        echo Uploading EXE...
                        curl -s -X POST "!UPLOAD_URL!?name=%EXE_NAME%" ^
                             -H "Authorization: token %github_token%" ^
                             -H "Content-Type: application/octet-stream" ^
                             --data-binary "@%WINDOW_BUILD_PATH%"
                    """
                }
            }
        }

        stage('Merge to main & Cleanup') {
            steps {
                echo "Merging build into main and deleting build branch..."
                withCredentials([string(credentialsId: 'GITHUB_TOKEN', variable: 'github_token')]) {
                    bat """
                        REM Ensure we have both branches locally
                        git fetch origin main
                        git fetch origin build

                        REM Checkout main branch and pull latest
                        git checkout main
                        git pull origin main

                        REM Merge build into main
                        git merge origin/build --no-ff -m "Auto-merged build → main(Jenkins)"

                        REM Push updated main
                        git push origin main

                        REM Delete remote build branch only if merge succeeded
                        git push origin --delete build || echo "Could not delete build branch"
                    """
                }
            }
        }
    }

    post {
        success {
            echo "🎉 Build and release completed successfully!"
        }
        failure {
            echo "❌ Build failed. Check the logs."
        }
        cleanup {
            echo "🧹 Cleaning up secrets..."
            bat """
                del "${KEY_PROPERTIES}"
                del "${KEYSTORE_PATH}"
            """
        }
    }
}