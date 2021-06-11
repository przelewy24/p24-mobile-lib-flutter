import 'package:p24_sdk/apple_pay/payment_item.dart';

class ApplePayParams {
	String _appleMerchantId;
	String _currency;
	bool _isSandbox;
	List<PaymentItem> _items;

	factory ApplePayParams.withSingleItem({
		required String appleMerchantId,
		required int amount,
		required String currency,
		required String description,
		bool isSandbox = true}) => ApplePayParams._([PaymentItem(amount: amount, description: description)], currency, appleMerchantId, isSandbox);

	factory ApplePayParams.withMultipleItems({
		required List<PaymentItem> items,
		required String appleMerchantId,
		required String currency,
		bool isSandbox = true}) => ApplePayParams._(items, currency, appleMerchantId, isSandbox);

	ApplePayParams._(this._items, this._currency, this._appleMerchantId, this._isSandbox);

	String get appleMerchantId => _appleMerchantId;
	String get currency => _currency;
	bool get isSandbox => _isSandbox;
	List<PaymentItem>  get items => _items;

	Map<String, dynamic> toMap() {
		return {
			"items": itemsToMap(),
			"currency": _currency,
			"appleMerchantId": _appleMerchantId,
			"isSandbox": _isSandbox
		};
	}

	List<dynamic> itemsToMap() {
		return _items.map((element) => element.toMap()).toList();
	}
}
