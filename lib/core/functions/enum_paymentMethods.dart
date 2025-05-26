enum PaymentMethod { visa, paypal, cash }

extension PaymentMethodExtension on PaymentMethod {
  String get name {
    switch (this) {
      case PaymentMethod.visa:
        return 'Visa';
      case PaymentMethod.paypal:
        return 'PayPal';
      case PaymentMethod.cash:
        return 'Cash';
    }
  }
}
