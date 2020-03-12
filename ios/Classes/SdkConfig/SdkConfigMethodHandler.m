#import "SdkConfigMethodHandler.h"

@implementation SdkConfigMethodHandler

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
  if ([@"setCertificatePinningEnabled" isEqualToString:call.method]) {
        bool isPinningEnabled = [call.arguments boolValue];
        [P24SdkConfig setCertificatePinningEnabled: isPinningEnabled];
        result(@"");
  } else if ([@"setFinishOnBackButtonEnabled" isEqualToString:call.method]) {
        bool isFinishOnBackButtonEnabled = [call.arguments boolValue];
        [P24SdkConfig setExitOnBackButtonEnabled: isFinishOnBackButtonEnabled];
        result(@"");
  } else if ([@"getCertificatePinningEnabled" isEqualToString:call.method]) {
        bool isCertificatePinningEnabled = [P24SdkConfig isCertificatePinningEnabled];
        result(@(isCertificatePinningEnabled));
  } else if ([@"getFinishOnBackButtonEnabled" isEqualToString:call.method]) {
        bool isExitOnBackButtonEnabled = [P24SdkConfig isExitOnBackButtonEnabled];
        result(@(isExitOnBackButtonEnabled));
  }
}

@end

