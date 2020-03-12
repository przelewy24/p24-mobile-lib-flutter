#import "P24.h"

@interface TransactionParamsMapper : NSObject
 + (P24TransactionParams *) buildTransaction : (NSDictionary *) transactionParams;
@end
