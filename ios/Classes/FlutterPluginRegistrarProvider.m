#import "FlutterPluginRegistrarProvider.h"

static NSObject<FlutterPluginRegistrar> * flutterPluginRegistrar;

@implementation FlutterPluginRegistrarProvider

+ (void) set: (NSObject<FlutterPluginRegistrar> *) registrar {
    flutterPluginRegistrar = registrar;
}

+ (NSObject<FlutterPluginRegistrar>*) get {
    return flutterPluginRegistrar;
}

@end
