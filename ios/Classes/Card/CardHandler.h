#import <Flutter/Flutter.h>
#import "RootViewControllerProvider.h"
#import "P24.h"

@interface CardHandler : NSObject<P24RegisterCardDelegate>
- (void) start : (NSDictionary *) dictionary result: (FlutterResult) result;
@end
