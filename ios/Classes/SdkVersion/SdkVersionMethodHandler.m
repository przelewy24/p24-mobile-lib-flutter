#import "SdkVersionMethodHandler.h"

@implementation SdkVersionMethodHandler

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getP24SdkVersion" isEqualToString:call.method]) {
      result([P24 sdkVersion]);
    }
}

@end
