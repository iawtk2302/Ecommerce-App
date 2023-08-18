import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class AddressRepository {
  Future<List<ShippingAddress>> fetchShippingAddresses() async {
    try {
      final snapshot = await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("addresses")
          .get();

      return snapshot.docs
          .map((e) => ShippingAddress.fromMap(e.data()))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addShippingAddress(
      {required ShippingAddress address, bool? setAsDefault}) async {
    try {
      await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection("addresses")
          .doc()
          .set(address.toMap());

      if (setAsDefault == true) {
        await usersRef
            .doc(firebaseAuth.currentUser!.uid)
            .update({"defaultAddress": address.toMap()});
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
