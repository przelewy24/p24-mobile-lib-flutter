#import "P24.h"
#import "TransferHandler.h"
#import "RootViewControllerProvider.h"
#import <Flutter/Flutter.h>

@interface TransferExecutor : NSObject<P24TransferDelegate>
- (void) execute: (NSDictionary *) dictionary result: (FlutterResult) result handler: (id<TransferHandler>) handler;
@end
