#import "P24.h"

@protocol TransferHandler <NSObject>
- (void) start : (UIViewController *) controller dictionary: (NSDictionary *) dictionary delegate: (id<P24TransferDelegate>) delegate;
@end
