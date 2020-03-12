//
//  P24ExtraFeturesConfig.h
//  Przelewy24
//
//  Created by Przelewy24 on 08.09.2017.
//  Copyright © 2017 PayPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface P24ExtraFeaturesConfig : NSObject

+ (NSString*) getRemoteConfigUrl;
+ (void) setRemoteConfigUrl: (NSString*) url;
+ (void) enableExpressFeatures: (NSString *) id;
+ (void) disableExpressFeatures;

@end
