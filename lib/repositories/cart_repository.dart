import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class CartRepository {
  Future<List<CartItem>> fetchMyCart() async {
    List<CartItem> result = [];

    try {
      final QuerySnapshot snapshot = await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .get();
      for (var doc in snapshot.docs) {
        final DocumentSnapshot productSnapshot =
            await productsRef.doc(doc.id).get();
        result.add(CartItem(
          id: doc.id,
          product:
              Product.fromMap(productSnapshot.data() as Map<String, dynamic>),
          quantity: productSnapshot['quantity'],
        ));
      }
    } catch (e) {
      throw Exception(e);
    }

    return result;
  }
}
