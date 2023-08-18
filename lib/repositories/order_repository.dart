import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/extensions/color_extensions.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/models/order_status.dart';
import 'package:ecommerce_app/models/tracking_status.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';

class OrderRepository {
  Future<List<OrderModel>> fetchMyOrders({required bool isCompleted}) async {
    try {
      final QuerySnapshot snapshot = await ordersRef
          .where("customerId", isEqualTo: firebaseAuth.currentUser!.uid)
          .where("isCompleted", isEqualTo: isCompleted)
          .orderBy("createdAt", descending: true)
          .get();
      return snapshot.docs
          .map((e) => OrderModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<OrderProductDetail>> fetchOrderItems(
      {required String orderId}) async {
    try {
      final QuerySnapshot snapshot =
          await ordersRef.doc(orderId).collection("items").get();
      return snapshot.docs
          .map((e) =>
              OrderProductDetail.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> addOrder(
      {required OrderModel order, required List<CartItem> items}) async {
    try {
      // add order
      final orderDoc = ordersRef.doc();
      order = order.copyWith(id: orderDoc.id);
      await orderDoc.set(order.toMap());

      // this list is used to hold 2 tasks (adding items and adding tracking list)
      // purpose: run these tasks concurrently and only finish when both of them finish
      List<Future> futures = [];

      // add order items
      for (var item in items) {
        final itemDoc = ordersRef.doc(orderDoc.id).collection("items").doc();
        final convertedItem = OrderProductDetail(
            id: itemDoc.id,
            productId: item.product.id,
            productName: item.product.name,
            productPrice: item.product.price,
            productImgUrl: item.product.imgUrl,
            productBrand: item.product.brand,
            color: item.color.toColorCode(),
            size: item.size,
            quantity: item.quantity);
        futures.add(itemDoc.set(convertedItem.toMap()));
      }

      // add tracking list
      final trackingDoc =
          ordersRef.doc(orderDoc.id).collection("tracking").doc();
      futures.add(trackingDoc.set(TrackingStatus(
          id: trackingDoc.id,
          status: OrderStatus.pending,
          createAt: Timestamp.fromDate(
            DateTime.now(),
          )).toMap()));

      // wait for all tasks to complete
      await Future.wait(futures);
      return orderDoc.id;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<OrderModel?> getOrderById(String id) async {
    return null;
  }

  Future<List<TrackingStatus>> fetchTrackingStatus(
      {required String orderId}) async {
    try {
      final QuerySnapshot snapshot =
          await ordersRef.doc(orderId).collection("tracking").get();
      return snapshot.docs
          .map((e) => TrackingStatus.fromMap(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
