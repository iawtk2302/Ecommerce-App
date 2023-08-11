import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class CategoryRepository {
  Future<List<Category>> fetchCategories() async {
    try {
      List<Category> categories = [];
      await categoriesRef.get().then((value) {
        categories.addAll(value.docs
            .map((e) => Category.fromJson(e.data() as Map<String, dynamic>)));
      });
      return categories;
    } catch (e) {
      throw Exception(e);
    }
  }
}
