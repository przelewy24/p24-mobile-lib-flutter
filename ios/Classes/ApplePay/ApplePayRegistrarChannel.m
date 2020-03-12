#import "ApplePayRegistrarChannel.h"

@implementation ApplePayRegistrarChannel
- (void)exchange:(id)applePayToken delegate:(id<P24ApplePayTransactionRegistrarDelegate>)delegate {
    NSObject<FlutterPluginRegistrar> * registrar = [FlutterPluginRegistrarProvider get];
    
    FlutterBasicMessageChannel * channel = [FlutterBasicMessageChannel messageChannelWithName: @"apple_pay_exchange" binaryMessenger: [registrar messenger] codec: [FlutterStringCodec sharedInstance]];

    [channel sendMessage: applePayToken reply: ^(id response) {
        NSData *responseData = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * responseDictionary = [NSJSONSerialization JSONObjectWithData: responseData options:kNilOptions error:nil];
        
        if([[responseDictionary objectForKey:@"status"] isEqual: @"transaction_registered"]) {
            [delegate onRegisterSuccess: [responseDictionary objectForKey:@"transactionToken"]];
        } else if ([[responseDictionary objectForKey:@"status"] isEqual: @"exchange_canceled"]) {
            [delegate onRegisterCanceled];
        }
        
    }];
}

@end
