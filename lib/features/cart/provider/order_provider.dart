import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/src/models/credit_card_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPaymentProvider = StateProvider<String>(
  (ref) {
    return 'Payment on Delivery';
  },
);

final momoProvider = StateProvider<String?>(
  (ref) {
    return null;
  },
);

class CardDetails {
  String? cardNumber;

  /// Expiry date of the card.
  String? expiryDate;

  /// Name of the card holder.
  String? cardHolderName;

  /// Cvv code on card.
  String? cvvCode;

  CardDetails(
      {this.cardHolderName, this.cardNumber, this.cvvCode, this.expiryDate});

  CardDetails copyWith({
    ValueGetter<String?>? cardNumber,
    ValueGetter<String?>? expiryDate,
    ValueGetter<String?>? cardHolderName,
    ValueGetter<String?>? cvvCode,
  }) {
    return CardDetails(
      cardNumber: cardNumber != null ? cardNumber() : this.cardNumber,
      expiryDate: expiryDate != null ? expiryDate() : this.expiryDate,
      cardHolderName:
          cardHolderName != null ? cardHolderName() : this.cardHolderName,
      cvvCode: cvvCode != null ? cvvCode() : this.cvvCode,
    );
  }
}

final cardDetailsProvider =
    StateNotifierProvider<CardDetailsProvider, CardDetails>((ref) {
  return CardDetailsProvider();
});

class CardDetailsProvider extends StateNotifier<CardDetails> {
  CardDetailsProvider() : super(CardDetails());

  void setCardDetails(CreditCardModel creditCardModel) {}
}
