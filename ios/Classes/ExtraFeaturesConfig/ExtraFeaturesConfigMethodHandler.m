#import "ExtraFeaturesConfigMethodHandler.h"

@implementation ExtraFeaturesConfigMethodHandler

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
  if ([@"setRemoteConfigUrl" isEqualToString:call.method]) {
      NSString* url = call.arguments;
      [P24ExtraFeaturesConfig setRemoteConfigUrl: url];
      result(@"");
  } else if ([@"enableExpressFeatures" isEqualToString:call.method]) {
      NSString* merchantId = call.arguments;
      [P24ExtraFeaturesConfig enableExpressFeatures: merchantId];
      result(@"");
  } else if ([@"disableExpressFeatures" isEqualToString:call.method]) {
      [P24ExtraFeaturesConfig disableExpressFeatures];
      result(@"");
  }
}

@end

