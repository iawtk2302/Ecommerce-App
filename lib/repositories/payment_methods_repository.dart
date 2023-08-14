import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/models/payment_method.dart';

final paymentMethods = [
  PaymentMethod(
    id: "1",
    name: "Credit Card",
    imageAsset: AppAssets.imgCreditCard,
    code: "mastercard",
  ),
  PaymentMethod(
    id: "2",
    name: "Paypal",
    imageAsset: AppAssets.imgPaypal,
    code: "paypal",
  ),
  PaymentMethod(
    id: "3",
    name: "Visa",
    imageAsset: AppAssets.imgVisa,
    code: "visa",
  ),
  PaymentMethod(
    id: "4",
    name: "Google Pay",
    imageAsset: AppAssets.imgGooglePay,
    code: "google_pay",
  ),
  PaymentMethod(
    id: "5",
    name: "Cash on delivery",
    imageAsset: AppAssets.imgCashOnDelivery,
    code: "cash_on_delivery",
  ),
];
