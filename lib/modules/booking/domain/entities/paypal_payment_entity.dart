class PaypalPaymentEntity {
  final String description;
  final String currency;
  final String amount;

  PaypalPaymentEntity({
    required this.description,
    required this.currency,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
        "amount": {
          "total": amount,
          "currency": currency,
        },
        "description": description,
      };
}
