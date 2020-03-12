#import "TransferExecutor.h"

@implementation TransferExecutor {
    FlutterResult flutterResult;
}

- (void) execute: (NSDictionary *) dictionary result: (FlutterResult) result handler: (id<TransferHandler>) handler {
    flutterResult = result;
    
    UIViewController * viewController = [RootViewControllerProvider get];
    [handler start: viewController dictionary: dictionary delegate: self];

}

- (void)p24TransferOnCanceled {
    flutterResult(@{ @"status" : @"cancel"});
}

- (void)p24TransferOnError:(NSString *)errorCode {
    flutterResult(@{ @"status" : @"error", @"payload" : errorCode});
}

- (void)p24TransferOnSuccess {
    flutterResult(@{ @"status" : @"success"});
}

@end
