import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class PromotionRepository {
  Future<List<Promotion>> fetchMyPromotions() async {
    try {
      final QuerySnapshot snaps = await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("promotions")
          .where("endTime", isGreaterThan: Timestamp.fromDate(DateTime.now()))
          .get();

      return snaps.docs
          .map((e) => Promotion.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addToMyPromotions({required Promotion promotion}) async {
    try {
      final doc = usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("promotions")
          .doc();
      promotion = promotion.copyWith(id: doc.id);
      await doc.set(promotion.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Promotion>> fetchPromotionsInHome() async {
    try {
      List<Promotion> promotions = [];
      await promotionsRef.get().then((value) {
        promotions.addAll(value.docs
            .map((e) => Promotion.fromMap(e.data() as Map<String, dynamic>)));
      });
      return promotions
          .where((element) => element.endTime.isAfter(DateTime.now()))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<bool> isPromotionReceived(String promotionCode) {
    return usersRef
        .doc(firebaseAuth.currentUser!.uid)
        .collection("promotions")
        .where('code', isEqualTo: promotionCode)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.isNotEmpty);
  }
}
