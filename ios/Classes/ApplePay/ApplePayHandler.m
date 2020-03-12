#import "ApplePayHandler.h"

@implementation ApplePayHandler {
    FlutterResult flutterResult;
    ApplePayRegistrarChannel* channel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        channel = [ApplePayRegistrarChannel new];
    }
    return self;
}

- (void) start: (NSDictionary *) dictionary result:(FlutterResult) result {
    
    flutterResult = result;
    UIViewController * viewController = [RootViewControllerProvider get];
    
    bool isSandbox = [[dictionary objectForKey:@"isSandbox"] boolValue];
    P24ApplePayParams* params = [self parseApplePayParams: dictionary];
    
    params.sandbox = isSandbox;
    [P24 startApplePay:params inViewController: viewController delegate:self];
}

- (P24ApplePayParams *) parseApplePayParams: (NSDictionary *) dictionary {
    NSString* appleMerchantId = [dictionary valueForKey:@"appleMerchantId"];
    int amount = [[dictionary objectForKey:@"amount"] intValue];
    NSString* currency = [dictionary objectForKey:@"currency"];
        
    return [[P24ApplePayParams alloc] initWithAppleMerchantId: appleMerchantId amount: amount currency: currency registrar: channel];
}

- (void)p24ApplePayOnCanceled {
    flutterResult(@{ @"status" : @"cancel"});
}

- (void)p24ApplePayOnError:(NSString *)errorCode {
    flutterResult(@{ @"status" : @"error", @"payload" : errorCode});
}

- (void)p24ApplePayOnSuccess {
    flutterResult(@{ @"status" : @"success"});
}


@end
