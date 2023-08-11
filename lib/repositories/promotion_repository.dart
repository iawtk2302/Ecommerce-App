import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class PromotionRepository {
  Future<List<Promotion>> fetchPromotionsInHome() async {
    try {
      List<Promotion> promotions = [];
      await promotionsRef.get().then((value) {
        promotions.addAll(value.docs
            .map((e) => Promotion.fromJson(e.data() as Map<String, dynamic>)));
      });
      return promotions
          .where((element) => element.endDate.isBefore(DateTime.now()))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
