import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class PromotionRepository {
  Future<List<Promotion>> fetchPromotions() async {
    List<Promotion> result = [];

    try {
      final QuerySnapshot snaps = await promotionsRef
          // .where("endDate", isGreaterThan: DateTime.now())
          .get();

      result = snaps.docs
          .map((e) => Promotion.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }

    return result;
  }
}
