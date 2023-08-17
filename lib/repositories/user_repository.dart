import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/models/user_profile.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class UserRepository {
  Future<UserProfile> fetchUser() async {
    try {
      final DocumentSnapshot doc =
          await usersRef.doc(firebaseAuth.currentUser!.uid).get();
      return UserProfile.fromMap(doc.data() as Map<String, dynamic>);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateUser(UserProfile user) async {
    try {
      await usersRef.doc(firebaseAuth.currentUser!.uid).update(user.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createNewUser({
    required String id,
    required String email,
    required String name,
  }) async {
    final UserProfile userProfile = UserProfile(
        id: firebaseAuth.currentUser!.uid,
        name: name,
        gender: null,
        age: null,
        email: email);
    try {
      await usersRef.doc(id).set(userProfile.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateDefaultShippingAddress(
      {required ShippingAddress newDefaultAddress}) async {
    try {
      await usersRef
          .doc(firebaseAuth.currentUser!.uid)
          .update({"defaultShippingAddress": newDefaultAddress.toMap()});
    } catch (e) {
      throw Exception(e);
    }
  }
}
