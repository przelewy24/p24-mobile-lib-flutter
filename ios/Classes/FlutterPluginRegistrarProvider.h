#import <Flutter/Flutter.h>

@interface FlutterPluginRegistrarProvider : NSObject
+ (void) set: (NSObject<FlutterPluginRegistrar> *) registrar;
+ (NSObject<FlutterPluginRegistrar>*) get;
@end

