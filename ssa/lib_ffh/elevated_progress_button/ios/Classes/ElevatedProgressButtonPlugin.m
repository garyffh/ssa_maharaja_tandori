#import "ElevatedProgressButtonPlugin.h"
#if __has_include(<elevated_progress_button/elevated_progress_button-Swift.h>)
#import <elevated_progress_button/elevated_progress_button-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "elevated_progress_button-Swift.h"
#endif

@implementation ElevatedProgressButtonPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftElevatedProgressButtonPlugin registerWithRegistrar:registrar];
}
@end
