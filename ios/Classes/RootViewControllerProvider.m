#import "RootViewControllerProvider.h"

@implementation RootViewControllerProvider
    + (UIViewController *) get  {
       return [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    }
@end
