import 'package:ecommerce_app/models/review.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class ReviewRepository {
  Future<List<Review>> fetchReviews(String productId) async {
    try {
      List<Review> reviews = [];
      await productsRef
          .doc(productId)
          .collection('reviews')
          .get()
          .then((value) {
        reviews.addAll(value.docs.map((e) => Review.fromMap(e.data())));
      });
      return reviews;
    } catch (e) {
      throw Exception(e);
    }
  }
}
