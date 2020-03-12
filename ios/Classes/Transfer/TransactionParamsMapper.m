#import "TransactionParamsMapper.h"

@implementation TransactionParamsMapper

+ (P24TransactionParams *) buildTransaction: (NSDictionary *) transactionParams {
    P24TransactionParams *p24Payment = [P24TransactionParams new];
    
     int merchantId = [[transactionParams valueForKey:@"merchantId"] intValue];
     NSString* crc = [transactionParams objectForKey:@"crc"];
     NSString* sessionId = [transactionParams objectForKey:@"sessionId"];
     int amount = [[transactionParams valueForKey:@"amount"] intValue];
     NSString* currency = [transactionParams objectForKey:@"currency"];
     NSString* description = [transactionParams objectForKey:@"description"];
     NSString* email = [transactionParams objectForKey:@"email"];
     NSString* country = [transactionParams objectForKey:@"country"];
     NSString* client = [transactionParams objectForKey:@"client"];
     NSString* address = [transactionParams objectForKey:@"address"];
     NSString* zip = [transactionParams objectForKey:@"zip"];
     NSString* city = [transactionParams objectForKey:@"city"];
     NSString* phone = [transactionParams objectForKey:@"phone"];
     NSString* language = [transactionParams objectForKey:@"language"];
     int method = [[transactionParams valueForKey:@"method"] intValue];
     NSString* urlStatus = [transactionParams objectForKey:@"urlStatus"];
     int timeLimit = [[transactionParams valueForKey:@"timeLimit"] intValue];
     int channel = [[transactionParams valueForKey:@"channel"] intValue];
     int shipping = [[transactionParams valueForKey:@"shipping"] intValue];
     NSString* transferLabel = [transactionParams objectForKey:@"transferLabel"];
     
    NSArray* itemsList = [transactionParams objectForKey:@"passageCart"];
    
    if(merchantId) { p24Payment.merchantId = merchantId; }
    if(crc) { p24Payment.crc = crc; }
    if(sessionId) { p24Payment.sessionId = sessionId; }
    if(amount) { p24Payment.amount = amount; }
    if(currency) { p24Payment.currency = currency; }
    if(description) { p24Payment.desc = description; }
    if(email) { p24Payment.email = email; }
    if(country) { p24Payment.country = country; }
    if(client) { p24Payment.client = client; }
    if(address) { p24Payment.address = address; }
    if(zip) { p24Payment.zip = zip; }
    if(city) { p24Payment.city = city; }
    if(phone) { p24Payment.phone = phone; }
    if(language) { p24Payment.language = language; }
    if(method) { p24Payment.method = method; }
    if(urlStatus) { p24Payment.urlStatus = urlStatus; }
    if(timeLimit) { p24Payment.timeLimit = timeLimit; }
    if(channel) { p24Payment.channel = channel; }
    if(shipping) { p24Payment.shipping = shipping; }
    if(transferLabel) { p24Payment.transferLabel = transferLabel; }

    if (itemsList || itemsList.count){
        P24PassageCart * cart = [self buildPassageCart: itemsList];
        p24Payment.passageCart = cart;
        p24Payment.amount = [cart getSummaryPrice];
    }
    
    return p24Payment;
}

+ (P24PassageCart *) buildPassageCart: (NSArray *) itemsList {
    P24PassageCart* passageCart = [P24PassageCart new];
      int counter = 1;
      for (id item in itemsList) {
          P24PassageItem* passageItem = [self buildPassageItem: item];
          [passageCart addItem: passageItem];
          counter++;
      }
    return passageCart;
}

+ (P24PassageItem *) buildPassageItem: (NSDictionary *) dictionary {
    P24PassageItem* passageItem = [[P24PassageItem alloc] initWithName: @"item"];

    NSString* name = [dictionary objectForKey:@"name"];
    NSString* description = [dictionary objectForKey:@"description"];
    int quantity = [[dictionary valueForKey:@"quantity"] intValue];
    int price = [[dictionary valueForKey:@"price"] intValue];
    int number = [[dictionary valueForKey:@"number"] intValue];
    int targetAmount = [[dictionary valueForKey:@"targetAmount"] intValue];
    int targetPosId = [[dictionary valueForKey:@"targetPosId"] intValue];
    
    passageItem.name = name;
    passageItem.desc = description;
    passageItem.quantity = quantity;
    passageItem.price = price;
    passageItem.number = number;
    passageItem.targetAmount = targetAmount;
    passageItem.targetPosId = targetPosId;
    
    return passageItem;
}
@end
