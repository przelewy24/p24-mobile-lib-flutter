#import "P24SdkPlugin.h"
#if __has_include(<p24_sdk/p24_sdk-Swift.h>)
#import <p24_sdk/p24_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "p24_sdk-Swift.h"
#endif

@implementation P24SdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [P24SdkVersionPlugin registerWithRegistrar:registrar];
    [P24SdkConfigPlugin registerWithRegistrar:registrar];
    [P24MethodsPlugin registerWithRegistrar:registrar];
}
@end
