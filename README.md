## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help on getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

- https://github.com/flutter/flutter/blob/master/.gitignore

- https://opensourcelibs.com/lib/flutter-architecture-blueprints

To update to the latest version, run "flutter upgrade".
## List Git untracked files

    git ls-files . --exclude-standard --others

## Flutter 

Step 1. flutter build apk --debug

Step 2. flutter build apk --profile

Step 3. flutter build apk --release

- flutter run --release

## Pub Commands

flutter pub outdated

## Generate Json

- to generate json classes
`flutter packages pub run build_runner build`
- after a directory change
`flutter packages pub run build_runner build --delete-conflicting-outputs`

convert to serialise

- https://app.quicktype.io/
- https://javiercbk.github.io/json_to_dart/

## Generate copyWith()

- https://pub.dev/packages/copy_with_extension_gen


    import 'package:copy_with_extension/copy_with_extension.dart';

    part 'basic_class.g.dart';

    @CopyWith()
    class BasicClass {
        BasicClass({this.id});

        final String id;
    }

- If you want to prevent a particular field from modifying with copyWith method you can add an annotation like this:


    @CopyWithField(immutable: true)
    final int myImmutableField;


## Mounted

I assume the problem is caused by the response from the server arrives after the widget is disposed.

Check if the widget is mounted before you call setState. This should prevent the error you are seeing:

    // Before calling setState check if the state is mounted.
    if (mounted) {
        setState (() => _noDataText = 'No Data'); 
    }


## Images In Browser

    flutter run -d chrome --web-renderer html

    flutter run -d chrome --no-sound-null-safety --web-renderer=html

    flutter build web --no-sound-null-safety --web-renderer=html


## Stripe

- https://pcipolicyportal.com/white-papers/need-pci-compliance-stripe-question-answer/
- https://pub.dev/packages/flutter_stripe
- https://github.com/jonasbark/flutter_stripe_payment/blob/master/migration.md
- https://www.reddit.com/r/flutterhelp/comments/koau8c/how_to_use_stripe_elements_in_flutter/

Android
- Android 5.0 (API level 21) and above
- Kotlin version 1.5.0 and above: [example](https://github.com/flutter-stripe/flutter_stripe/blob/79b201a2e9b827196d6a97bb41e1d0e526632a5a/example/android/build.gradle#L2)
- android/build.gradle
- Using a descendant of Theme.AppCompact for your activity: [example](https://github.com/flutter-stripe/flutter_stripe/blob/384d390c8a90d19dc62c73faa5226fa931fd6d44/example/android/app/src/main/res/values/styles.xml#L15)
- android/app/src/main/res/values/styles.xml
- Using FlutterFragmentActivity instead of FlutterActivity in MainActivity.kt: [example](https://github.com/flutter-stripe/flutter_stripe/blob/79b201a2e9b827196d6a97bb41e1d0e526632a5a/example/android/app/src/main/kotlin/com/flutter/stripe/example/MainActivity.kt#L6)
- android/app/src/main/kotlin/com/freeflowhub/ffhStoreApp/ffh_store_app/MainActivity.kt
- This is caused by the Stripe SDK requires the use of the AppCompact theme for their UI components and the Support Fragment Manager for the Payment Sheets

iOS
- Compatible with apps targeting iOS 11 or above.
- Cocoapods users must update to Cocoapods 1.10.
- Podfile platform :ios, '11.0'

## Circle CI

- https://github.com/FlorisDevreese/Flutter-CI-CD/tree/master
- https://circleci.com/blog/deploy-flutter-android/?utm_medium=SEM&utm_source=gnb&utm_campaign=SEM-gb-DSA-Eng-japac&utm_content=&utm_term=dynamicSearch-&gclid=CjwKCAjw64eJBhAGEiwABr9o2L3tOqV9ylE1fJ_4QllBVvy1ESkXIpCQFonZGDK8OnkymIi8yFTa7BoC48AQAvD_BwE

## Google Maps

https://pub.dev/packages/google_maps_flutter

// original AIzaSyARKzTvsYuQr8SvxvdPXMcpImSsNGbhQVo

// new AIzaSyC_jVVpSbcMa-Hw8Wj86qIdgmHSmjwnHOU


## Rename Package

flutter pub run change_app_package_name:main com.new.package.name

## Version Update

Version update requires a build.

- flutter build apk
- flutter build ipa

## Firebase

- 

- https://firebase.flutter.dev/docs/overview
- https://firebase.flutter.dev/docs/installation/android
- https://firebase.flutter.dev/docs/installation/ios
- https://pub.dev/packages/firebase_analytics
- https://firebase.flutter.dev/docs/messaging/usage/#background-messages

- Code magic app distribution set up the service account with an editor role
- Testers select apk.



## Firebase cli

- firebase login
- flutterfire configure
- https://firebase.flutter.dev/docs/cli
- https://firebase.flutter.dev/docs/messaging/apple-integration/
- 

## Reactive Form

- https://pub.dev/packages/reactive_forms

### ReactiveForm
    final FormGroup form = fb.group(<String, Object>{
        'firstName': [
        'Gary',
        Validators.required,
        ],
        'lastName': [
        'Haywood',
        Validators.required,
        ],
    }

    ReactiveForm(
        formGroup: form,
        child: Column(
    ),

### FormBuilder
    ReactiveFormBuilder(
    form: buildForm,
    builder: (formContext, form, child) {

    }

    FormGroup buildForm() => fb.group(<String, Object>{
        'firstName': [
        'Gary',
        Validators.required,
        ],
        'lastName': [
        'Haywood',
        Validators.required,
        ],
    }

### Get Form
    final form = ReactiveForm.of(context)

### Get Control Values
    this.form.control('name').value;

### Set Control Values
    this.form.control('name').value = 'John';

### Controls


- https://pub.dev/packages/flutter_typeahead
- https://pub.dev/packages/pin_input_text_field
- https://pub.dev/packages/direct_select
- 

## PinPut

- https://pub.dev/packages/pinput

## Responsive Layout

- https://blog.codemagic.io/building-responsive-applications-with-flutter
- https://blog.logrocket.com/achieving-responsive-design-flutter/

### LayoutBuilder
- https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html

### MediaQuery
- https://api.flutter.dev/flutter/widgets/MediaQuery/of.html

### AspectRatio
- https://api.flutter.dev/flutter/widgets/AspectRatio-class.html


## Responsive Sizer
- https://github.com/CoderUni/responsive_sizer

### Widget Size
    Container(
        width: 20.w,    // This will take 20% of the screen's width
        height: 30.5.h     // This will take 30.5% of the screen's height
    )

.h - Returns a calculated height based on the device (Does the same thing as Adaptive.h)

.w - Returns a calculated width based on the device (Does the same thing as Adaptive.w)

### Font Size
    Text(
        'Responsive Sizer',
        style: TextStyle(fontSize: 15.sp),
    )


.sp - Returns a calculated sp based on the device (Does the same thing as Adaptive.sp)

### Orientation

    Device.orientation == Orientation.portrait
        ? Container(   // Widget for Portrait
            width: 100.w,
            height: 20.5.h,
        )
        : Container(   // Widget for Landscape
            width: 100.w,
            height: 12.5.h,
        )

Device.orientation - Returns the Screen Orientation (portrait or landscape)

### Screen Type

    Device.screenType == ScreenType.tablet
        ? Container(   // Widget for Tablet
            width: 100.w,
            height: 20.5.h,
        )
        : Container(   // Widget for Mobile
            width: 100.w,
            height: 12.5.h,
        )

Device.screenType - Returns the Screen Type (mobile or tablet)

### Box Constraints
Device.boxConstraints - Returns the Device's BoxConstraints

### Aspect Ratio
Device.aspectRatio - Returns the Device's aspect ratio

### Pixel Ratio
Device.pixelRatio - Returns the Device's pixel ratio

## Screen Sizes

For example, the smallest screen size in active use is currently the iPhone 5, which comes in at 320 pixels wide.

From there, most subsequent iPhone models toggle between 375 and 414 pixels wide, with increasing viewport sizes as you move into the Galaxy phones and tablets.

- ###Desktop - 1024×768 -> 1920×1080
- ###Tablet - 601×962 -> 1280×800
- ###Mobile - 360×640 -> 414×896

## Automated Screenshots
- https://medium.com/@nocnoc/automated-screenshots-for-flutter-f78be70cd5fd

## Device Preview

- https://pub.dev/packages/device_preview
- https://aloisdeniel.github.io/flutter_device_preview/#/
- https://cogitas.net/creating-flavors-of-a-flutter-app/#section3

### Small Phone
320x569: density 2

### Large Phone
800x1280: density 3


## Flutter Studio

- https://flutterstudio.app/

## Theme Info

### Platform
- platform

### Text
- textTheme

### Common Colours
- primaryColor -> primaryTextColor
- primaryColorDark -> primaryDarkTextColor
- primaryColorLight -> primaryLightTextColor
- secondaryHeaderColor -> secondaryHeaderTextColor
- primaryVariantColor -> primaryVariantTextColor
- secondaryColor -> secondaryTextColor
- toggleableActiveColor -> toggleableActiveTextColor
- secondaryVariant -> secondaryVariantTextColor
- appBarColor -> appBarTextColor
- bottomAppBarColor -> bottomAppBarTextColor
- dividerColor -> dividerTextColor
- backgroundColor -> backgroundTextColor
- canvasColor -> canvasTextColor
- surfaceColor ->  surfaceTextColor
- cardColor -> cardTextColor
- dialogBackgroundColor -> dialogTextColor
- scaffoldBackgroundColor -> scaffoldTextColor
- error -> errorTextColor


### Color Schemes
- colorScheme:primary 
- colorScheme:primaryVariant 
- colorScheme:secondary
- colorScheme:secondaryVariant
- colorScheme:surface

- colorScheme:background
- colorScheme:brightness
- colorScheme:error

### on Contrast e.g. for text
- colorScheme:onBackground
- colorScheme:onError
- colorScheme:onPrimary
- colorScheme:onSecondary
- colorScheme:onSurface
  

    ThemeData.estimateBrightnessForColor(
        theme.secondaryHeaderColor) ==
        Brightness.dark
        ? Colors.white
        : Colors.black,


### Accent - deprecated use secondary
- accentColor
- accentColorBrightness
- accentIconTheme:color
- accentTextTheme

### Primary
- primaryColor
- primaryColorBrightness
- primaryColorDark
- primaryColorLight
- primaryIconTheme:color
- primaryTextTheme

### Misc Colors
- backgroundColor
- canvasColor:
- cursorColor
- dialogBackgroundColor
- disabledColor
- dividerColor
- errorColor
- focusColor
- highlightColor
- hintColor
- hoverColor
- iconTheme: color
- indicatorColor
- inputDecorationTheme: fillColor
- scaffoldBackgroundColor
- secondaryHeaderColor
- selectedRowColor
- shadowColor
- splashColor
- textSelectionColor
- textSelectionHandleColor
- toggleableActiveColor
- unselectedWidgetColor



### Appbar
- appBarTheme
- bottomAppBarColor

### Bottom Nav
- bottomNavigationBarTheme:selectedIconTheme:color
- bottomNavigationBarTheme:selectedItemColor

### Button
- buttonColor
- buttonTheme:colorScheme
- buttonTheme:height
- buttonTheme:minWidth

### Card
- cardColor:

### Chip
- chipTheme:backgroundColor
- chipTheme:deleteIconColor
- chipTheme:disabledColor
- chipTheme:labelStyle:color
- chipTheme:selectedColor
- chipTheme:secondaryLabelStyle:color
- chipTheme:secondarySelectedColor


### Tab Bar
- tabBarTheme:labelColor
- tabBarTheme:unselectedLabelColor

## Mason
- https://github.com/felangel/mason

### Installation on Machine

    dart pub global activate mason

### Installation for project

    mason init

### Create Bricks

    mason new <BRICK_NAME>

### Get Bricks to Cache

- Add bricks to the cache


    mason get

### Clear Brick Cache

    mason cache clear

### List Cached Bricks

    mason list

### Make Brick

    mason make bloc_view -c .\bricks\bloc_view\config.json -o .\.generated\bloc_view
    mason make read_bloc_view -c .\bricks\read_bloc_view\config.json -o .\.generated\bloc_view


| Name          | Example       | Usage|
|:------------- |:-------------:|: -----|
| camelCase | helloWorld | {{#camelCase}}{{variable}}{{/camelCase}} |
| constantCase | HELLO_WORLD | {{#constantCase}}{{variable}}{{/constantCase}} |
| dotCase | hello.world | {{#headerCase}}{{variable}}{{/headerCase}} |
|headerCase	|Hello-World| {{#headerCase}}{{variable}}{{/headerCase}}|
|lowerCase	|hello world| {{#lowerCase}}{{variable}}{{/lowerCase}}|
|pascalCase	|HelloWorld| {{#pascalCase}}{{variable}}{{/pascalCase}}|
|paramCase	|hello-world| {{#paramCase}}{{variable}}{{/paramCase}}|
|pathCase	|hello/world| {{#pathCase}}{{variable}}{{/pathCase}}|
|sentenceCase|Hello world| {{#sentenceCase}}{{variable}}{{/sentenceCase}}|
|snakeCase	|hello_world| {{#snakeCase}}{{variable}}{{/snakeCase}}|
|titleCase	|Hello World| {{#titleCase}}{{variable}}{{/titleCase}}|
|upperCase	|HELLO WORLD| {{#upperCase}}{{variable}}{{/upperCase}}|

## DateTime Formatting

- https://api.flutter.dev/flutter/intl/DateFormat-class.html
- https://flutteragency.com/format-datetime-in-flutter/
- https://github.com/dart-lang/intl
- https://github.com/dart-lang/intl
- https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html

ICU Name                   Skeleton
 --------                   --------
DAY                          d
ABBR_WEEKDAY                 E
WEEKDAY                      EEEE
ABBR_STANDALONE_MONTH        LLL
STANDALONE_MONTH             LLLL
NUM_MONTH                    M
NUM_MONTH_DAY                Md
NUM_MONTH_WEEKDAY_DAY        MEd
ABBR_MONTH                   MMM
ABBR_MONTH_DAY               MMMd
ABBR_MONTH_WEEKDAY_DAY       MMMEd
MONTH                        MMMM
MONTH_DAY                    MMMMd
MONTH_WEEKDAY_DAY            MMMMEEEEd
ABBR_QUARTER                 QQQ
QUARTER                      QQQQ
YEAR                         y
YEAR_NUM_MONTH               yM
YEAR_NUM_MONTH_DAY           yMd
YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
YEAR_ABBR_MONTH              yMMM
YEAR_ABBR_MONTH_DAY          yMMMd
YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
YEAR_MONTH                   yMMMM
YEAR_MONTH_DAY               yMMMMd
YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
YEAR_ABBR_QUARTER            yQQQ
YEAR_QUARTER                 yQQQQ
HOUR24                       H
HOUR24_MINUTE                Hm
HOUR24_MINUTE_SECOND         Hms
HOUR                         j
HOUR_MINUTE                  jm
HOUR_MINUTE_SECOND           jms
HOUR_MINUTE_GENERIC_TZ       jmv
HOUR_MINUTE_TZ               jmz
HOUR_GENERIC_TZ              jv
HOUR_TZ                      jz
MINUTE                       m
MINUTE_SECOND                ms
SECOND                       s

## Audio

- https://github.com/ryanheise/just_audio/tree/master/just_audio
- https://pub.dev/packages/just_audio_background
- 


## Icons

- https://fonts.google.com/icons
- https://api.flutter.dev/flutter/material/Icons-class.html

## Connectivity

- https://www.youtube.com/watch?v=P2vaBZDSqzg&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=101

## Collections

- https://www.youtube.com/watch?v=Ymw9xfRucK0&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=106

## Refresh Indication

- https://www.youtube.com/watch?v=ORApMlzwMdM&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=109

## Checkbox ListTile

- https://www.youtube.com/watch?v=RkSqPAn9szs&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=83

## Index Stack

- https://www.youtube.com/watch?v=_O0PPD1Xfbk&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=48

## Hero Transitions

- https://www.youtube.com/watch?v=Be9UH1kXFDw&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=19

## Sliver List

- https://www.youtube.com/watch?v=ORiTTaVY6mM&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=14

## url launcher

- https://www.youtube.com/watch?v=qYxRYB1oszw&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=86

## Publishing New
- firebase API Key found in Prject Settings -> Users and Permissions -> Cloud Messaging Tab


## Publishing General Info

- flutter build apk --obfuscate --split-debug-info=/hubCafe/hubCafe not doing this!

- flutter_launcher_icons

- dependencies {
  // ...
  implementation 'com.google.android.material:material:<version>'
  // ...
  }
  https://maven.google.com/web/index.html#com.google.android.material:material

## pubspec.yaml
- version

## Publishing Google Maps -> not yet
hubcafe -> AIzaSyC_jVVpSbcMa-Hw8Wj86qIdgmHSmjwnHOU

https://developers.google.com/maps/documentation/android-sdk/get-api-key
https://console.cloud.google.com/

- geo.API_KEY
- Firebase -> Settings -> Authentication -> Get started

## Publishing Step Clean

    flutter clean


## Publishing Step Logo

- replace the logo in assets/icons/logo.png


[comment]: <> (## Publishing Step AndroidManifest.xml)

[comment]: <> (- package in debug and profile)

[comment]: <> (for main)

[comment]: <> (- package)

[comment]: <> (- android:label)

[comment]: <> (## Publishing Step Kotlin Folder)

[comment]: <> (- add the kotlin folder)

[comment]: <> (- change package name in MainActivity)

[comment]: <> (## Publishing Step build.gradle)

[comment]: <> (-applicationId "au.com.freeflowhub.hubcafe")

## Publishing Step Firebase cli

- firebase login
- flutterfire configure

- flutterfire configure --project ffh-store-hub-cafe --ios-bundle-id au.com.freeflowhub.hubcafe --android-app-id au.com.freeflowhub.hubcafe

- flutterfire configure --project ffh-store-aces --ios-bundle-id au.com.freeflowhub.aces --android-app-id au.com.freeflowhub.aces 

## Publishing Step

    pub get


## Publishing Step App Icons

flutter pub run flutter_launcher_icons:main
flutter pub run flutter_native_splash:create

- https://flutter.dev/docs/development/ui/advanced/splash-screen



## Publishing Step Check on Phone

- flutter run --release


## Publish Command

    flutter build apk --split-per-abi

### upload the 3 files

- armeabi-v7a (ARM 32-bit)
- arm64-v8a (ARM 64-bit)
- x86-64 (x86 64-bit)

### Flutter Flavours

## iOS Defines

-https://itnext.io/flutter-1-17-no-more-flavors-no-more-ios-schemas-command-argument-that-solves-everything-8b145ed4285d
-https://github.com/f-prime/flutter_app_name
-https://github.com/flutter/flutter/tree/master/packages/flutter_tools

## Git

### Update gitignore

  Commit all changes before doing this!

    git rm -rf --cached .
    git add .


## Code Magic

-https://www.youtube.com/watch?v=zdJkvDANiuY
-https://github.com/codemagic-ci-cd/cli-tools
-https://blog.codemagic.io/environments-in-flutter-with-codemagic-cicd/#vs-code-launchjson
-https://www.jetbrains.com/help/idea/apply-changes-from-one-branch-to-another.html#copy-files-to-branch


### Set project locally

-> Git -> GitHub -> Share Project on GitHub

OR

-> Git -> Manage Remotes

    git checkout master
    git branch --set-upstream-to=origin/master

### Add subtree
    git subtree add --prefix single_store_app https://github.com/garyffh/single_store_app.git master --squash

### Update subtree
    git subtree pull --prefix single_store_app https://github.com/garyffh/single_store_app.git master --squash


# CodeMagic  setup

https://github.com/Shashikant86/Codemagic-Demo/blob/master/ios/Runner.xcodeproj/project.pbxproj

## Project path

  Build -> Project path

  ssa


## Run command arguments

    --dart-define=SINGLE_STORE_APP_APP_ID=au.com.freeflowhub.hubcafe --dart-define=SINGLE_STORE_APP_APP_NAME='Hub Cafe' --dart-define=SINGLE_STORE_APP_CLIENT_ID=rL3MNxisLkGvGpjia93V8A --dart-define=SINGLE_STORE_APP_WEB_SITE_URL=hub-cafe.freeflowhub.com.au --dart-define=SINGLE_STORE_APP_URL=hub-cafe-api.freeflowhub.com.au --dart-define=SINGLE_STORE_APP_API_SEGMENT=/api/ --dart-define=SINGLE_STORE_APP_API_LOGO_BACKGROUND_COLOUR=0xffffffff

## Place App Specific Files in Assets

- firebase_options.dart -> from single_store_app

  flutterfire configure --project ffh-store-hub-cafe --ios-bundle-id au.com.freeflowhub.hubcafe --android-app-id au.com.freeflowhub.hubcafe --out "..\single_store_app_customers\hubcafe\assets\firebase_options.dart"

- GoogleService-Info.plist -> https://console.firebase.google.com/

- logo.png


## App Specific Files to Code Magic variables

Save file as Base64 LOGO_PNG Variable

    [Convert]::ToBase64String([IO.File]::ReadAllBytes("assets/logo.png")) | Set-Clipboard

Save file as Base64 GOOGLE_SERVICE_INFO_PLIST Variable

    [Convert]::ToBase64String([IO.File]::ReadAllBytes("assets/GoogleService-Info.plist")) | Set-Clipboard

Save file as Base64 FIREBASE_OPTIONS_DART Variable

    [Convert]::ToBase64String([IO.File]::ReadAllBytes("assets/firebase_options.dart")) | Set-Clipboard


## Pre-build script

    cd ssa

    mkdir -p $FCI_BUILD_DIR/ssa/assets/icons
    echo $LOGO_PNG | base64 --decode > $FCI_BUILD_DIR/ssa/assets/icons/logo.png
    echo $GOOGLE_SERVICE_INFO_PLIST | base64 --decode > $FCI_BUILD_DIR/ssa/ios/Runner/GoogleService-Info.plist
    echo $FIREBASE_OPTIONS_DART | base64 --decode > $FCI_BUILD_DIR/ssa/lib/firebase_options.dart

    flutter pub run flutter_launcher_icons:main
    flutter pub run flutter_native_splash:create


## Android Distribution

Upload keystore file

Enter Keystore password
Enter Key alias
Enter Key password

## Google Play Publishing

Add permissions for app in API access

Upload api-access.json file

Check -> Do not send changes for review

## iOS code signing

  - Select Manual
  
  - upload the Code signing certificate (ios-distribution.p12)

  - enter the Code signing certificate password

  - upload the Provisioning profile file


## iOS publishing

  - check Enable App Store Connect publishing

  - Select ios-app-store-connect

## ios Dart Define Script

    function entry_decode() { echo &quot;${*}&quot; | base64 --decode; }&#10;&#10;IFS=&apos;,&apos; read -r -a define_items &lt;&lt;&lt; &quot;$DART_DEFINES&quot;&#10;&#10;&#10;for index in &quot;${!define_items[@]}&quot;&#10;do&#10;    define_items[$index]=$(entry_decode &quot;${define_items[$index]}&quot;);&#10;done&#10;&#10;printf &quot;%s\n&quot; &quot;${define_items[@]}&quot;|grep &apos;^SINGLE_STORE_APP_&apos; &gt; ${SRCROOT}/Flutter/DartDefines.xcconfig


## Firebase App Distribution

