import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference usersRef = firestore.collection("users");
final DocumentReference currentUserRef =
    usersRef.doc(firebaseAuth.currentUser!.uid);
final CollectionReference categoriesRef = firestore.collection("categories");
final CollectionReference productsRef = firestore.collection("products");
final CollectionReference promotionsRef = firestore.collection("promotions");
final CollectionReference ordersRef = firestore.collection("orders");
