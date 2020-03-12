#import "ExpressHandler.h"

@implementation ExpressHandler

- (void) start : (UIViewController *) controller dictionary: (NSDictionary *) dictionary delegate: (id<P24TransferDelegate>) delegate {
      NSString* url = [dictionary objectForKey:@"url"];

      P24ExpressParams* params = [[P24ExpressParams alloc] initWithUrl: url];
      
      [P24 startExpress:params inViewController: controller delegate: delegate];
}

@end
