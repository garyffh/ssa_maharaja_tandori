# Build local Android apk

1 - `cd ssa`
2 - `flutter pub get`
3 - copy logo.png -> ssa/assets/icons
4 - copy firebase_options -> ssa/lib
5 - copy key.properties -> android
5 - `flutter pub run flutter_launcher_icons:main`
6 - `flutter pub run flutter_native_splash:create`
7 - `flutter build appbundle --release [build arguments from app_settings.txt]`

# Run local iOS

1 - `cd ssa`
2 - `flutter pub get`
3 - copy logo -> ssa/assets/icons
4 - copy firebase_options -> ssa/lib
5 - copy GoogleService-Info.plist -> ios/Runner/GoogleService-Info.plist
5 - copy DartDefines.xcconfig -> ios/Flutter/DartDefines.xcconfig
6 - cd ios -> pod install -> cd ../
6 - `flutter pub run flutter_launcher_icons:main`
7 - `flutter pub run flutter_native_splash:create`
8 - `flutter run [build arguments from app_settings.txt]`

# Update Codemagic Application

## Update App

- Update the app


    git subtree pull --prefix ssa https://github.com/garyffh/ssa.git master --squash


- Push to GitHub

# Add Codemagic Application

# Git

## Set project locally

-> Git -> GitHub -> Share Project on GitHub (ssa_hub_cafe)

OR

-> Git -> Manage Remotes

    git checkout master
    git branch --set-upstream-to=origin/master

## Add subtree
    git subtree add --prefix ssa https://github.com/garyffh/ssa.git master --squash

## Update subtree
    git subtree pull --prefix ssa https://github.com/garyffh/ssa.git master --squash



# CodeMagic Setup

Add application (ssa_hub_cafe)



## Place App Specific Files in Assets

1. app_settings

2. firebase service account json file

3. firebase_options.dart -> from single_store_app

flutterfire configure --project ffh-store-hub-cafe --ios-bundle-id au.com.freeflowhub.hubcafe --android-app-id au.com.freeflowhub.hubcafe --out "..\single_store_app_customers\hubcafe\assets\firebase_options.dart"

4. GoogleService-Info.plist -> https://console.firebase.google.com/

5. logo.png

6. DartDefines.xcconfig



## App Specific Files to Code Magic variables

Save file as Base64 DART_DEFINES_XCCONFIG Variable

    [Convert]::ToBase64String([IO.File]::ReadAllBytes("assets/DartDefines.xcconfig")) | Set-Clipboard

Save file as Base64 LOGO_PNG Variable

    [Convert]::ToBase64String([IO.File]::ReadAllBytes("assets/logo.png")) | Set-Clipboard

Save file as Base64 GOOGLE_SERVICE_INFO_PLIST Variable

    [Convert]::ToBase64String([IO.File]::ReadAllBytes("assets/GoogleService-Info.plist")) | Set-Clipboard

Save file as Base64 FIREBASE_OPTIONS_DART Variable

    [Convert]::ToBase64String([IO.File]::ReadAllBytes("assets/firebase_options.dart")) | Set-Clipboard


## Pre-build script

    cd ssa

    mkdir -p $FCI_BUILD_DIR/ssa/assets/icons
    echo $DART_DEFINES_XCCONFIG | base64 --decode > $FCI_BUILD_DIR/ssa/ios/Flutter/DartDefines.xcconfig
    echo $LOGO_PNG | base64 --decode > $FCI_BUILD_DIR/ssa/assets/icons/logo.png
    echo $GOOGLE_SERVICE_INFO_PLIST | base64 --decode > $FCI_BUILD_DIR/ssa/ios/Runner/GoogleService-Info.plist
    echo $FIREBASE_OPTIONS_DART | base64 --decode > $FCI_BUILD_DIR/ssa/lib/firebase_options.dart

    flutter pub run flutter_launcher_icons:main
    flutter pub run flutter_native_splash:create



## Project path

- Build -> Project path to ssa

## Android build format

- Android application package


## Run command arguments

    --dart-define=SINGLE_STORE_APP_APP_ID=au.com.freeflowhub.hubcafe --dart-define=SINGLE_STORE_APP_APP_NAME='Hub Cafe' --dart-define=SINGLE_STORE_APP_CLIENT_ID=rL3MNxisLkGvGpjia93V8A --dart-define=SINGLE_STORE_APP_WEB_SITE_URL=hub-cafe.freeflowhub.com.au --dart-define=SINGLE_STORE_APP_URL=hub-cafe-api.freeflowhub.com.au --dart-define=SINGLE_STORE_APP_API_SEGMENT=/api/ --dart-define=SINGLE_STORE_APP_API_LOGO_BACKGROUND_COLOUR=0xffffffff


## Android code signing

### From Android developers console (Select Java keystore)

- java -jar D:\single_store_app_customers\@certificates\android\pepk.jar --keystore=D:\single_store_app_customers\@certificates\android\android.keystore --alias=hubCafe --output=output.zip


### Codemagic

- upload keystore
- enter keystore password
- enter alias
- enter alias password



## Google Play publishing

- upload credentials (api-access.json)
- set Track to production
- set Do not send changes for review

## iOS code signing

- set signing method to Manual
- upload the Code signing certificate (ios-distribution.p12) and enter password
- upload the Provisioning profile

## App Store Connect

- Select the Codemagic Api Key (Key: CV5N4B39B)


## Firebase App Distribution

- Select Firebase service account
- Upload the Firebase json service account file
- Enter the Android app ID
- Enter the iOS app ID
- Enter the Tester group (Testers)
- Select the Android artifact type (APK)

