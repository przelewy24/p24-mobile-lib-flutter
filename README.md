# Przelewy24 library documentation - Flutter

For general information on the operation of Przelewy24 mobile libraries, visit:

- [https://github.com/przelewy24/p24-mobile-lib-doc](https://github.com/przelewy24/p24-mobile-lib-doc)

## 1. Project configuration

|For iOS only|
|-|
|In project Xcode settings set „iOS Deployment Target” ( „Info” project settings bookmark) to version 9.0 or newer. Version 9.0 is the minimum requirement for the library to work properly with the iOS. |
|![](img/ios_config.png)|

### Adding dependencies

For correct import of dependencies it is necessary to add code

```  
p24_sdk: ^x.x.x
```

to `pubspec.yaml` of project in `dependencies` section.

To use the library, you must import the file `p24_sdk`:

``` import 'package:p24_sdk/p24_sdk.dart'; ```

## 2. SSL Pinning

The library has a Pinning SSL mechanism that can be activated globally for webview calls.
If you want use this feature, please make sure configuration is setup before any library methods calls. Example:

```dart
await SdkConfig.setCertificatePinningEnabled(true);
```

**NOTE!!**

 > When activating SSL Pinning, keep in mind that the certificates embedded in the library have their validity time. Before time of their expiry, Przelewy24 will be sending out appropriate information and updating.

## 3. Finish on back button

The library makes possible to control behaviour of back button when WebView was called. Function is disabled by default - back button in library behaves similarly to back button in Web browser. Change param configuration on true makes, that after back button is clicked, WebView will be closed.
Params settings should take place before call any methods of P24 library. Change default configuration could be triggered by method:

```dart
await SdkConfig.setFinishOnBackButtonEnabled(true);
```

## 4. trnRequest transaction call

During the registration with the "trnRegister" method, additional parameters should be provided:
- `p24_mobile_lib=1`
- `p24_sdk_version=X` – where X is a moibile lib version provided by 
```dart
P24SdkVersion.value().then((value) => print("Sdk version: $value"));
```

This parameters allows Przelewy24 to classify the transaction as a mobile transaction. A Token registered without this parameter will not work in the mobile application (an error will appear upon return to the bank and the library file will not detect payment completion).

**NOTE!**

 > When registering a transaction which is to be carried out in a mobile library, remember about the additional parameters:
- `p24_channel` – unless set, the library will feature the payment options „traditional transfer” and „use prepayment”, which are unnecessary in case of mobile payments. In order to deactivate them, use flags that disregard these forms (e.g. value 3 – payments and cards, default entry setting, directly with parameters)
- `p24_method` – if a given transaction in the library is to have a specific, preset method of payment, this method must be selected during the registration
- `p24_url_status` - the address to be used for transaction verification by the partner’s server once the payment process in the mobile library is finished

The transaction parameters must be set using the token of a transaction registered earlier. Optionally, you could set `isSandbox` flag depending on transaction environment (default `isSandbox` param is set to `false`):

```dart
TrnRequestParams params = TrnRequestParams(token: _token, isSandbox: true);
```

Next, call the `trnRequest` method:

```dart
P24SDK.trnRequest(params).then((response) {
    // handle response
});
```

Response is `SdkResult` object consist of `payload` field (optional, containing error code) and `SdkStatus` object receiving one of three type: **success** | **error** | **cancel**

## 5. trnDirect transaction call

Firstly, `TransactionParams` object should be created. Object contructor looks like:

```dart
TransactionParams({@required int merchantId, @required String crc,
  @required String sessionId, @required int amount,
  @required String currency, @required String description,
  @required String email, @required String country,
  String client, String address, String zip, String city, String phone,
  String language, int method, String urlStatus, int timeLimit,
  int channel, int shipping, String transferLabel, String methodRefId, PassageCart passageCart})
```

Params marked with `@required` adnotations are mandatory, which must be filled. Another params are optional. PassageCart object should be passed in passage transaction (paragraph 7). 

After creation of `TransactionParams` object, should be created another object with params for transaction call, suitable for mentioned method - optionally, transaction can be called on sandbox environment.

```dart
TrnDirectParams params = TrnDirectParams(transactionParams: transactionParams, isSandbox: true);
```

At the end, call the `TrnDirectMethod` with `TrnDirectParams`:

```dart
P24SDK.trnDirect(params).then((response) {
    // handle response
});
```

Object `SdkResult` is returned as response (described at paragh 4).

## 6. Express transaction call

Firstly, `ExpressParams` object should be created:

```dart
ExpressParams params = ExpressParams(url: _expressUrl);
```

where `_expressUrl` was received during transaction register at Express system.

After creation of `ExpressParams` object `Express` method could be called:

```dart
P24SDK.transferExpress(params).then((response) {
    // handle response
});
```

Object `SdkResult` is returned as response (described at paragh 4).

## 7. Passage 2.0 transaction call

Firstly, `TrnDirectParams` object should be created, similarly to TrnDirect, adding `PassageCart` object:

``` dart

List<PassageItem> _items = List<PassageItem>();

// loop for items list
PassageItem item = PassageItem(
          name: "Product name",
          description: "Product description",
          number: 1,
          price: 100,
          quantity: 2,
          targetAmount: 2,
          targetPosId: XXXXX
      );

_items.addItem(item);
// end of loop

PassageCart cart = PassageCart(_items);
```

At above example amount from `targetAmount` will be passed on billing acount XXX `targetPosId`. Fields `description` and `number` regarding to documentation of `Pasaż 2.0` service are optional.

```dart
//earlier created object TrnDirectParams
trnDirectParams.passageCart = cart;
```

Transaction call and parsing result are processed same as in `trnDirect` case.

## 8. Google Pay (Android)

The data flow process using this payment method looks as follows:

![](img/gpay_eng.png) 

To use the Google Pay payment you must first make an additional configuration of the project according to official Google documentation:

**[https://developers.google.com/pay/api/android/overview](https://developers.google.com/pay/api/android/overview)**

To initiate a transaction, you must pass the transaction parameters and the `GooglePayTransactionRegistrar` object that is used to register the transaction:

```dart
GooglePayParams params = GooglePayParams(
    merchantId: MERCHANT_ID,
    amount: AMOUNT_IN_GR,
    currency: CURRENCY,
    isSandbox: IS_SANDBOX
);
P24SDK.googlePay(params, getGooglePayTransactionRegistrar()).then((response) {
    //handle response
});
```

Transaction registration should take place in accordance with the documentation:

**[https://docs.przelewy24.pl/Google_Pay](https://docs.przelewy24.pl/Google_Pay)**

The `GooglePayTransactionRegistrar` interface allows you to implement the exchange of the token received from Google Pay into the P24 transaction token. When the `exchange` method is called, communicate with the P24 servers, pass the Google Pay payment token as the `p24_method_ref_id` param, and then pass the transaction token to the library using the callback:

```dart
@override
    Future<GooglePayExchangeResult> exchange(String methodRefId) {
        //In this place your backend should register transaction in P24 and retrieve transaction token.
        var result = GooglePayTransactionRegistered(transactionToken: "CD77A8A04F-3E83BC-7C1044-0EFF8933DF");
        return Future.value(result);
    }
```

Object `SdkResult` is returned as response (described at paragh 4).

## 9. Apple Pay (iOS)

The data flow process using this payment method looks as follows:

![](img/apple_pay_diagram_eng.png) 

To use the Apple Pay payment you must first make an additional configuration of the project according to official Apple documentation:

**[https://developer.apple.com/documentation/passkit/apple_pay/](https://developer.apple.com/documentation/passkit/apple_pay/)**

To initiate a transaction, you must pass the transaction parameters and the `ApplePayTransactionRegistrar` object that is used to register the transaction:

```dart
ApplePayParams params = ApplePayParams.withSingleItem(
    appleMerchantId: APPLE_MERCHANT_ID,
    amount: AMOUNT_IN_GR,
    currency: CURRENCY,
    description: DESCRIPTION,
    isSandbox: IS_SANDBOX
);

P24SDK.applePay(params, getApplePayTransactionRegistrar()).then((response) {
    //handle response
});
```

Alternatively, in `ApplePayParams` object instead of amount and description can be passed objects list of type `PaymentItem`:

```dart
ApplePayParams params = ApplePayParams.withMultipleItems(
    appleMerchantId: APPLE_MERCHANT_ID,
    items: [exampleItem, exampleItem2],
    currency: CURRENCY,
    isSandbox: IS_SANDBOX
);

P24SDK.applePay(params, getApplePayTransactionRegistrar()).then((response) {
    //handle response
});
```

Object `PaymentItem` consists of `itemDescription` and `amount` fields:

```dart
PaymentItem exampleItem = PaymentItem(description: DESCRIPTION, amount: AMOUNT);
```

**NOTE**

>*The parameter `appleMerchantId` is the ID obtained from the Apple Developer console. You should pay attention that this is not the same as the `merchant_id` from Przelewy24.*


The `ApplePayTransactionRegistrar` interface allows you to implement the exchange of the token received from Google Pay into the P24 transaction token. When the `exchange` method is called, communicate with the P24 servers, pass the Google Pay payment token as the `p24_method_ref_id` param, and then pass the transaction token to the library using the callback:

```dart
@override
    Future<ApplePayExchangeResult> exchange(String methodRefId) {
        //In this place your backend should register transaction in P24 and retrieve transaction token.
        var result = ApplePayTransactionRegistered(transactionToken: "CD77A8A04F-3E83BC-7C1044-0EFF8933DF");
        return Future.value(result);
    }
```

Object `SdkResult` is returned as response (described at paragh 4).

## 10. Card Register

P24 mobile library enable card registration in P24 system. Firstly, you need to create `CardData` object:

```dart
CardData cardData = CardData(
    number: CARD_NUMBER,
    cvv: CVV,
    expiryMonth: EXPIRY_MONTH,
    expiryYear: EXPIRY_YEAR
);
```

Then, create `RegisterCardParams` object. `RegisterCardParams` object has two kinds of initialization.

The default contructor only requires URL:

```dart
RegisterCardParams params = RegisterCardParams(
    url: REGISTER_CARD_URL
);
```

The second, static, gives possibility to pass previously filled card data with URL received from P24 backend: 

```dart
RegisterCardParams params = RegisterCardParams.prefilled(
    cardData: cardData,
    url: REGISTER_CARD_URL
);
```

In the last step, it is neccessary to invoke `registerCard` method:

```dart
P24SDK.registerCard(params).then((response){
    //handle response
});
```

Response is object of type `SdkResult`, consisting of `SdkStatus` object, taking one of three values: **success** | **error** | **cancel** and `payload` field, which contains registrated card token (when `SdkResult` is success) or error code (when `SdkResult` is error).