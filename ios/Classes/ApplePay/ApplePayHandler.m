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
    NSString* currency = [dictionary objectForKey:@"currency"];
    NSArray<PaymentItem *> * items = [self getItemsList: dictionary];

    return [[P24ApplePayParams alloc]
            initWithItems: items
            currency: currency
            appleMerchantId: appleMerchantId
            registrar: channel];
}

- (NSArray<PaymentItem *> *) getItemsList: (NSDictionary *) dictionary {
    NSArray<NSDictionary *> * itemsDictionary = [dictionary valueForKey:@"items"];
    NSMutableArray<PaymentItem *> * paymentItemsList = [[NSMutableArray<PaymentItem *> alloc] init];

    for(NSDictionary * singleItem in itemsDictionary){
        PaymentItem * item = [[PaymentItem alloc] init];
        item.amount = [[singleItem objectForKey:@"amount"] intValue];
        item.itemDescription = [singleItem objectForKey:@"description"];
        [paymentItemsList addObject: item];
    }

    return paymentItemsList;
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
