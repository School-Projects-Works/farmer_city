import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedPaymentProvider = StateProvider<String>(
  (ref) {
    return 'Payment on Delivery';
  },
);
class MomoPayment {
  String? phoneNumber;
  String? network;
  MomoPayment({this.phoneNumber, this.network});
  MomoPayment copyWith({
    ValueGetter<String?>? phoneNumber,
    ValueGetter<String?>? network,
  }) {
    return MomoPayment(
      phoneNumber: phoneNumber != null ? phoneNumber() : this.phoneNumber,
      network: network != null ? network() : this.network,
    );
  }
}
final momoProvider = StateNotifierProvider<MomoPaymentProvider, MomoPayment>(
  (ref) {
    return MomoPaymentProvider();
  },
);

class MomoPaymentProvider extends StateNotifier<MomoPayment> {
  MomoPaymentProvider() : super(MomoPayment());

  void setProvider(String value) {
    state = state.copyWith(network:()=> value);
  }

  void setPhone(String value) {
    state = state.copyWith(phoneNumber:()=> value);
  }

  void clear() {
    state = state.copyWith(phoneNumber:()=> null, network:()=> null);
  }
}

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

  void setCardHolderName(String? name) {
    state = state.copyWith(cardHolderName: () => name);
  }

  void setCvvCode(String? cvv) {
    state = state.copyWith(cvvCode: () => cvv);
  }

  void setExpiryDate(String? date) {
    state = state.copyWith(expiryDate: () => date);
  }

  void setCardNumber(String? card) {
    state = state.copyWith(cardNumber: () => card);
  }

  void clear() {
    state = state.copyWith(
        cardHolderName: () => null,
        cardNumber: () => null,
        cvvCode: () => null,
        expiryDate: () => null);
  }

}


final isPickUpProvider = StateProvider<bool>((ref) {
  return false;
});