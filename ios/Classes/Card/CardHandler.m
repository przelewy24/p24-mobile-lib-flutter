#import "CardHandler.h"

@implementation CardHandler {
    FlutterResult flutterResult;
}

- (void) start : (NSDictionary *) dictionary result: (FlutterResult) result {
    
    flutterResult = result;
    UIViewController * viewController = [RootViewControllerProvider get];
    
    NSString* url = [dictionary objectForKey:@"url"];
    P24CardData* data = [self parseCardData: dictionary];
    
    P24RegisterCardParams* params = [[P24RegisterCardParams alloc] initWithUrl: url data:data];
    [P24 startRegisterCard:params inViewController: viewController delegate: self];
}

- (P24CardData *) parseCardData:(NSDictionary *) dictionary {
    
    NSDictionary* cardData = [dictionary objectForKey:@"cardData"];
    NSString* number = [cardData objectForKey:@"number"];
    int expiryMonth = [[cardData valueForKey:@"expiryMonth"] intValue];
    int expiryYear = [[cardData valueForKey:@"expiryYear"] intValue];
    NSString* cvv = [cardData objectForKey:@"cvv"];

    return [[P24CardData alloc] initWithCardNumber: number month: expiryMonth year:expiryYear cvv: cvv];
}

- (void)p24RegisterCardCancel {
    flutterResult(@{ @"status" : @"cancel"});
}

- (void)p24RegisterCardError:(NSString *)errorCode {
    flutterResult(@{ @"status" : @"error", @"payload" : errorCode});
}

- (void)p24RegisterCardSuccess:(P24RegisterCardResult *)registerCardResult {
    flutterResult(@{ @"status" : @"success", @"payload" : [registerCardResult cardToken]});
}

@end
