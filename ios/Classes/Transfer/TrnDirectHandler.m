#import "TrnDirectHandler.h"


@implementation TrnDirectHandler

- (void)start:(UIViewController *)controller dictionary:(NSDictionary *) dictionary delegate:(id<P24TransferDelegate>) delegate {
      bool isSandbox = [[dictionary objectForKey:@"isSandbox"] boolValue];
      NSDictionary* transactionParamsDictionary = [dictionary objectForKey:@"transactionParams"];
      
      P24TransactionParams * transactionParams = [TransactionParamsMapper buildTransaction: transactionParamsDictionary];
      P24TrnDirectParams* params = [[P24TrnDirectParams alloc] initWithTransactionParams: transactionParams];
      params.sandbox = isSandbox;
      
      [P24 startTrnDirect:params inViewController: controller delegate: delegate];
}

@end
