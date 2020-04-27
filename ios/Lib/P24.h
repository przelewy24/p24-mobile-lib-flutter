//
//  P24.h
//  Przelewy24
//
//  Created by Przelewy24 on 08.09.2017.
//  Copyright © 2017 PayPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface P24CardData : NSObject

@property (nonatomic, copy, readonly) NSString * number;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int year;
@property (nonatomic, copy, readonly) NSString * cvv;


- (id) initWithCardNumber:(NSString *) number month:(int) month year:(int) year cvv:(NSString *) cvv;

@end

@interface P24RegisterCardParams : NSObject

@property (nonatomic, copy, readonly) NSString * url;
@property (nonatomic, copy, readonly) P24CardData * data;

- (id) initWithUrl:(NSString *) url;
- (id) initWithUrl:(NSString *) url data:(P24CardData *) data;

@end

@interface P24RegisterCardResult : NSObject

@property (nonatomic, assign, readonly) NSString * cardToken;

- (id) initWithCardToken:(NSString*) cardToken;

@end


@protocol P24RegisterCardDelegate <NSObject>

- (void) p24RegisterCardSuccess:(P24RegisterCardResult *) registerCardResult;
- (void) p24RegisterCardCancel;
- (void) p24RegisterCardError:(NSString*) errorCode;

@end

@interface P24RpcParams: NSObject

@property (nonatomic, copy, readonly) NSString *token;
@property (nonatomic, copy, readonly) NSString *blikCode;
@property (nonatomic, assign, readwrite) BOOL sandbox;

- (id) initWithToken:(NSString *) token;
- (id) initWithToken:(NSString *) token blikCode:(NSString *) blikCode;
- (BOOL) hasBlikCodeSet;

@end


@protocol P24RpcDelegate <NSObject>

- (void) p24RpcCompleted;
- (void) p24RpcCanceled;
- (void) p24RpcError: (NSString*) errorCode;

@end

@interface P24 : NSObject

+ (NSString *) sdkVersion;
+ (void) startRegisterCard:(P24RegisterCardParams *)params inViewController:(UIViewController *)viewController delegate:(id<P24RegisterCardDelegate>) delegate;
+ (void) startRpc:(P24RpcParams *) params inViewController:(UIViewController *) viewController delegate:(id<P24RpcDelegate>) delegate;

@end

@interface P24SdkConfig : NSObject

+ (BOOL) isCertificatePinningEnabled;
+ (BOOL) isExitOnBackButtonEnabled;

+ (void) setCertificatePinningEnabled: (BOOL) isEnabled;
+ (void) setExitOnBackButtonEnabled: (BOOL) isEnabled;

@end



@interface P24PassageItem : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, assign) int quantity;
@property (nonatomic, assign) int price;
@property (nonatomic, assign) int number;
@property (nonatomic, assign) int targetAmount;
@property (nonatomic, assign) int targetPosId;

- (instancetype) initWithName: (NSString*) name;

@end

@interface P24PassageCart : NSObject

@property (nonatomic, strong, readonly) NSArray* items;

- (void) addItem: (P24PassageItem*) item;
- (int) getSummaryPrice;
@end

@interface P24TransactionParams : NSObject

//required
@property (nonatomic, assign) int merchantId;
@property (nonatomic, copy) NSString *crc;
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, assign) int amount;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *country;

//optional
@property (nonatomic, copy) NSString *client;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *zip;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *language;
@property (nonatomic, assign) int method;
@property (nonatomic, copy) NSString *urlStatus;
@property (nonatomic, assign) int timeLimit;
@property (nonatomic, assign) int channel;
@property (nonatomic, assign) int shipping;
@property (nonatomic, copy) NSString *transferLabel;
@property (nonatomic, strong) P24PassageCart* passageCart;

@end

@interface P24TrnRequestParams: NSObject

@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign, readwrite) BOOL sandbox;

- (instancetype)initWithToken:(NSString *)token;

@end

@interface P24TrnDirectParams: NSObject

@property (nonatomic, strong) P24TransactionParams *transactionParams;
@property (nonatomic, assign, readwrite) BOOL sandbox;

- (instancetype)initWithTransactionParams:(P24TransactionParams *)transactionParams;

@end

@interface P24ExpressParams: NSObject

@property (nonatomic, copy) NSString *url;

- (instancetype)initWithUrl:(NSString *)url;

@end

@protocol P24ApplePayTransactionRegistrarDelegate <NSObject>

@required

- (void) onRegisterSuccess: (NSString*) token;
- (void) onRegisterCanceled;

@end

@protocol P24ApplePayTransactionRegistrar <NSObject>

@required

- (void)exchange: (NSString*) applePayToken delegate: (id<P24ApplePayTransactionRegistrarDelegate>) delegate;

@end

@interface P24ApplePayParams: NSObject

@property (nonatomic, copy) NSString *appleMerchantId;
@property (nonatomic, assign) int amount;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *payeeName;
@property (weak) id<P24ApplePayTransactionRegistrar> registrar;
@property (nonatomic, assign, readwrite) BOOL sandbox;

- (instancetype)initWithAppleMerchantId:(NSString *)appleMerchantId
                                 amount:(int)amount
                               currency:(NSString *)currency
                              payeeName:(NSString *)payeeName
                              registrar:(id<P24ApplePayTransactionRegistrar>) registrar;

@end

@protocol P24TransferDelegate <NSObject>

@required

- (void)p24TransferOnSuccess;
- (void)p24TransferOnCanceled;
- (void)p24TransferOnError: (NSString*) errorCode;

@end

@protocol P24ApplePayDelegate <NSObject>

@required

- (void)p24ApplePayOnSuccess;
- (void)p24ApplePayOnCanceled;
- (void)p24ApplePayOnError: (NSString*) errorCode;

@end

@interface P24 (Secure)

+ (void)startTrnRequest:(P24TrnRequestParams *)params inViewController:(UIViewController *)parent delegate:(id<P24TransferDelegate>) delegate;

+ (void)startTrnDirect:(P24TrnDirectParams *)params inViewController:(UIViewController *)parent delegate:(id<P24TransferDelegate>) delegate;

+ (void)startExpress:(P24ExpressParams *)params inViewController:(UIViewController *)parent delegate:(id<P24TransferDelegate>) delegate;

+ (void)startApplePay:(P24ApplePayParams *)params inViewController:(UIViewController *)parent delegate:(id<P24ApplePayDelegate>) delegate;

@end
