#import "P24MethodHandler.h"

@implementation P24MethodHandler {
    TransferExecutor* executor;
    CardHandler* cardHandler;
    ApplePayHandler* applePayHandler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        executor = [TransferExecutor new];
        cardHandler = [CardHandler new];
        applePayHandler = [ApplePayHandler new];
    }
    return self;
}
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
        
  if ([@"trnRequest" isEqualToString:call.method]) {
      [executor execute: call.arguments result: result handler: [TrnRequestHandler new]];
  } else if ([@"trnDirect" isEqualToString:call.method]) {
      [executor execute: call.arguments result: result handler: [TrnDirectHandler new]];
  } else if ([@"transferExpress" isEqualToString:call.method]) {
      [executor execute: call.arguments result: result handler: [ExpressHandler new]];
  } else if ([@"transferPassage" isEqualToString:call.method]) {
      [executor execute: call.arguments result: result handler: [PassageHandler new]];
  } else if ([@"applePay" isEqualToString:call.method]) {
      [applePayHandler start: call.arguments result: result];
  } else if ([@"registerCard" isEqualToString:call.method]) {
      [cardHandler start: call.arguments result: result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
