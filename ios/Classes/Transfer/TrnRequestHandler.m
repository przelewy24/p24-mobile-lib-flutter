#import "TrnRequestHandler.h"

@implementation TrnRequestHandler

- (void)start:(UIViewController *)controller dictionary:(NSDictionary *) dictionary delegate:(id<P24TransferDelegate>) delegate {
    bool isSandbox = [[dictionary objectForKey:@"isSandbox"] boolValue];
    NSString* token = [dictionary objectForKey:@"token"];
    
    P24TrnRequestParams* params = [[P24TrnRequestParams alloc] initWithToken: token];
    params.sandbox = isSandbox;
    
    [P24 startTrnRequest:params inViewController: controller delegate: delegate];
}

@end
