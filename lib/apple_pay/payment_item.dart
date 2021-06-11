class PaymentItem {
	String _description;
	int _amount;

	PaymentItem({required String description, required int amount}):
			this._description = description,
			this._amount = amount;

	String get description => _description;
	int get amount => _amount;

	Map<String, dynamic> toMap() {
		return {
			"description": _description,
			"amount" : _amount
		};
	}


}
