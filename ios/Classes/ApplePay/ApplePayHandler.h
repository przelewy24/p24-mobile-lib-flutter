#import <Flutter/Flutter.h>
#import "ApplePayRegistrarChannel.h"
#import "RootViewControllerProvider.h"
#import "P24.h"


@interface ApplePayHandler : NSObject<P24ApplePayDelegate>
- (void) start: (NSDictionary *) dictionary result:(FlutterResult) result;
@end
