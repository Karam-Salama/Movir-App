enum PaymentMethod { walletOrVisa, paypal }

extension PaymentMethodExtension on PaymentMethod {
  String get name {
    switch (this) {
      case PaymentMethod.walletOrVisa:
        return 'Wallet or Visa';
      case PaymentMethod.paypal:
        return 'PayPal';
    }
  }
}
