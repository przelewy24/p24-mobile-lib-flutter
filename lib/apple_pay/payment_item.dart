class PaymentItem {
	final String _description;
	final int _amount;

	PaymentItem({required String description, required int amount}):
			_description = description,
			_amount = amount;

	String get description => _description;
	int get amount => _amount;

	Map<String, dynamic> toMap() {
		return {
			"description": _description,
			"amount" : _amount
		};
	}


}
