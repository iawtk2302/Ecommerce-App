enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
  returned,
  refunded,
  onHold,
  outForDelivery,
  failedDelivery,
}

final Map<OrderStatus, String> orderStatusToString = {
  OrderStatus.pending: "pending",
  OrderStatus.processing: "processing",
  OrderStatus.shipped: "shipped",
  OrderStatus.delivered: "delivered",
  OrderStatus.cancelled: "cancelled",
  OrderStatus.returned: "returned",
  OrderStatus.refunded: "refunded",
  OrderStatus.onHold: "on_hold",
  OrderStatus.outForDelivery: "out_for_delivery",
  OrderStatus.failedDelivery: "failed_delivery",
};

final Map<String, OrderStatus> stringToOrderStatus = {
  "pending": OrderStatus.pending,
  "processing": OrderStatus.processing,
  "shipped": OrderStatus.shipped,
  "delivered": OrderStatus.delivered,
  "cancelled": OrderStatus.cancelled,
  "returned": OrderStatus.returned,
  "refunded": OrderStatus.refunded,
  "on_hold": OrderStatus.onHold,
  "out_for_delivery": OrderStatus.outForDelivery,
  "failed_delivery": OrderStatus.failedDelivery,
};
