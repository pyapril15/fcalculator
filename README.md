# 📱 Calculator App (Flutter)

A modern, cross-platform calculator application built using Flutter. This project supports Android and Windows builds with a full Jenkins-based CI/CD pipeline including GitHub Releases automation.

---

## 🚀 Features

- Simple, modern calculator UI
- Cross-platform support: Android & Windows
- Automated builds and releases using Jenkins
- Secure keystore management for Android
- GitHub release tagging and artifact uploads
- GitHub token-protected release notes via `latest_version.md`

---

## 🧱 Project Structure




---

## 🛠️ Getting Started

### ✅ Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Git & GitHub CLI
- Jenkins server (with Windows agent if building `.exe`)
- Required GitHub and Android credentials added in Jenkins:
    - `GITHUB_TOKEN`
    - `ANDROID_STORE_FILE`
    - `ANDROID_KEYSTORE_PASSWORD`
    - `ANDROID_KEY_PASSWORD`
    - `ANDROID_KEY_ALIAS`

---

## ⚙️ Jenkins CI/CD Workflow

This project uses a declarative `Jenkinsfile` that includes the following pipeline stages:

### Pipeline Stages:

1. **Checkout** – Clones the project repo.
2. **Setup Keystore & Properties** – Configures Android signing.
3. **Flutter Clean & Pub Get** – Cleans and installs dependencies.
4. **Build Android APK** – Builds release APK.
5. **Build Windows EXE** – Builds release `.exe` file.
6. **Rename Window EXE** – Renames the Windows binary.
7. **Archive Artifacts** – Stores build artifacts in Jenkins.
8. **Git Tag & Push** – Tags release in Git and pushes it.
9. **GitHub Release** – Creates a release using `latest_version.md`.
10. **Upload Artifacts** – Uploads `.apk` and `.exe` to GitHub release.
11. **Merge to Main & Cleanup** – Merges `build` to `main` and cleans up.

---

## 🧪 Local Development

```bash
flutter clean
flutter pub get
flutter run
flutter build apk --release
flutter build windows --release
```
