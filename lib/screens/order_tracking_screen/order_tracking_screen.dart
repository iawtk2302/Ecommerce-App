import 'package:ecommerce_app/common_widgets/custom_loading_widget.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/section_label.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/timestamp_extensions.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/models/order_product_detail.dart';
import 'package:ecommerce_app/models/order_status.dart';
import 'package:ecommerce_app/models/tracking_status.dart';
import 'package:ecommerce_app/repositories/order_repository.dart';
import 'package:ecommerce_app/screens/my_order_screen/widgets/order_item_widget.dart';
import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderModel order;
  final OrderProductDetail orderItem;
  const OrderTrackingScreen({
    super.key,
    required this.order,
    required this.orderItem,
  });

  static const String routeName = "/order-tracking-screen";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.defaultPadding, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.orderNumber, style: AppStyles.headlineLarge),
            const Text("Washington - Geiorgia", style: AppStyles.bodyMedium),
            const SizedBox(height: 10),
            OrderItemWidget(
                margin: const EdgeInsets.symmetric(vertical: 10),
                order: order,
                orderItem: orderItem),
            const SizedBox(height: 10),
            const SectionLabel(
              label: "Collection Point",
              margin: EdgeInsets.only(bottom: 8),
            ),
            const Text("10:11-11:00 - 25 June, 2021",
                style: AppStyles.bodyLarge),
            Text("${order.address.street}, ${order.address.country}",
                style: AppStyles.bodyLarge),
            const SizedBox(height: 8),
            const Divider(color: AppColors.greyColor),
            Row(
              children: [
                const Expanded(
                  child: Text(
                      "You can change pick-up time for your order by 10:00, 24 June",
                      style: AppStyles.bodyLarge),
                ),
                const SizedBox(width: 30),
                MyButton(
                    borderRadius: 8,
                    onPressed: () {},
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      "Change",
                      style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600),
                    )),
              ],
            ),
            const SizedBox(height: 50),
            const SectionLabel(
              label: "History",
              margin: EdgeInsets.only(bottom: 8),
            ),
            FutureBuilder<List<TrackingStatus>>(
              future: OrderRepository().fetchTrackingStatus(orderId: order.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CustomLoadingWidget();
                }

                final List<TrackingStatus> statuses = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: statuses.length,
                  itemBuilder: (_, index) {
                    final status = statuses[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${status.createAt.getMonth()} ${status.createAt.toDate().day}",
                                style: AppStyles.labelMedium,
                              ),
                              Text(
                                  "${status.createAt.toDate().hour}:${status.createAt.toDate().minute}",
                                  style: AppStyles.bodyMedium),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.primaryColor),
                            ),
                            if (index < statuses.length - 1)
                              Container(
                                height: 50,
                                width: 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.primaryColor),
                              ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${trackingStatusTitle[status.status]}",
                              style: AppStyles.labelMedium,
                            ),
                            if (status.currentLocation != null)
                              Text("${status.currentLocation}",
                                  style: AppStyles.bodyMedium),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
