enum PaymentMethod { wallet, visa, paypal }

extension PaymentMethodExtension on PaymentMethod {
  String get name {
    switch (this) {
      case PaymentMethod.wallet:
        return 'Wallet';
      case PaymentMethod.visa:
        return 'Visa';
      case PaymentMethod.paypal:
        return 'PayPal';
    }
  }
}
