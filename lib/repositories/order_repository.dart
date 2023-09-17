import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/extensions/color_extensions.dart';
import 'package:ecommerce_app/models/cart_item.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/models/order_status.dart';
import 'package:ecommerce_app/models/promotion.dart';
import 'package:ecommerce_app/models/tracking_status.dart';
import 'package:ecommerce_app/repositories/statistics_repository.dart';
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

  Stream<List<OrderProductDetail>> streamOrderItem({required String orderId}) {
    return ordersRef.doc(orderId).collection("items").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => OrderProductDetail.fromMap(doc.data()))
            .toList());
  }

  Future<String> addOrder(
      {required OrderModel order,
      required List<CartItem> items,
      required Promotion? promotion}) async {
    final DateTime createdTime = DateTime.now();
    try {
      // add order
      final orderDoc = ordersRef.doc();
      order = order.copyWith(id: orderDoc.id);
      await orderDoc.set(order.toMap());

      // this list is used to hold tasks
      // purpose: run these tasks concurrently and only finish when both of them finish
      List<Future> futures = [];
      WriteBatch batch = firestore.batch();

      // add order items
      for (var item in items) {
        final itemDoc = ordersRef.doc(orderDoc.id).collection("items").doc();
        final productDoc = productsRef.doc(item.product.id);
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
        batch.set(itemDoc, convertedItem.toMap());
        // Update number of products in stock and sold
        batch.update(productDoc, {
          "stockCount": FieldValue.increment(-item.quantity),
          "soldCount": FieldValue.increment(item.quantity),
        });
      }

      // add tracking list
      final trackingDoc =
          ordersRef.doc(orderDoc.id).collection("tracking").doc();
      batch.set(
          trackingDoc,
          TrackingStatus(
                  id: trackingDoc.id,
                  status: OrderStatus.pending,
                  createAt: Timestamp.fromDate(createdTime))
              .toMap());

      // Update orders statistics
      futures.add(StatisticsRepository()
          .updateStatistics(orderValue: order.orderSummary.total));

      // Update monthly sales
      futures.add(StatisticsRepository().updateMonthlySales(
          time: createdTime, orderValue: order.orderSummary.total));

      // Update number of promotions if user used promotion in order
      if (promotion != null) {
        batch.update(promotionsRef.doc(promotion.id), {
          "usedQuantity": FieldValue.increment(1),
        });
      }

      // Update product statistics
      final soldCount = items.fold(
          0, (previousValue, element) => previousValue + element.quantity);
      batch.update(productsStatisticsDocRef, {
        "soldQuantity": FieldValue.increment(soldCount),
      });

      // wait for all tasks to complete
      futures.add(batch.commit());
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

  Future<OrderModel?> getOrderByOrderNumber(String orderNumber) async {
    try {
      final snapshot = await ordersRef
          .where("orderNumber", isEqualTo: orderNumber.trim())
          .get();
      if (snapshot.docs.isNotEmpty) {
        return OrderModel.fromMap(
            snapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
