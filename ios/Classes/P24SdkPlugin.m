#import "P24SdkPlugin.h"

@implementation P24SdkPlugin 

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    [FlutterPluginRegistrarProvider set: registrar];
    
    FlutterMethodChannel* channelSdk = [FlutterMethodChannel methodChannelWithName:@"p24_sdk" binaryMessenger:[registrar messenger]];
    P24MethodHandler* p24MethodHandler = [[P24MethodHandler alloc] init];
    [registrar addMethodCallDelegate: p24MethodHandler channel:channelSdk];
    
    FlutterMethodChannel* channelExtraConfig = [FlutterMethodChannel methodChannelWithName:@"p24_sdk/extra_features_config" binaryMessenger:[registrar messenger]];
    ExtraFeaturesConfigMethodHandler* extraFeaturesConfigMethodHandler = [[ExtraFeaturesConfigMethodHandler alloc] init];
    [registrar addMethodCallDelegate: extraFeaturesConfigMethodHandler channel: channelExtraConfig];
    
    FlutterMethodChannel* channelSdkConfig = [FlutterMethodChannel methodChannelWithName:@"p24_sdk/sdk_config" binaryMessenger:[registrar messenger]];
    SdkConfigMethodHandler* sdkConfigMethodHandler = [[SdkConfigMethodHandler alloc] init];
    [registrar addMethodCallDelegate: sdkConfigMethodHandler channel:channelSdkConfig];

 }

#pragma clang diagnostic pop

@end
