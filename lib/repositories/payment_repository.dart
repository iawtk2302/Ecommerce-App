import 'package:ecommerce_app/models/payment_card.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class PaymentRepository {
  Future<void> addPaymentCard({
    required String cardNumber,
    required String holderName,
    required String expiryDate,
    required String cvvCode,
    required String cardType,
  }) async {
    try {
      final doc = usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("payment_cards")
          .doc();
      final PaymentCard newCard = PaymentCard(
        id: doc.id,
        holderName: holderName,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cvvCode: cvvCode,
        cardType: cardType,
      );
      await doc.set(newCard.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PaymentCard>> fetchPaymentCards() async {
    try {
      final snapshot = await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("payment_cards")
          .get();
      List<PaymentCard> paymentCards = [];
      snapshot.docs.forEach((element) {
        print(element.data());
      });
      paymentCards =
          snapshot.docs.map((e) => PaymentCard.fromMap(e.data())).toList();
      return paymentCards;
    } catch (e) {
      throw Exception(e);
    }
  }
}
