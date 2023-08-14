import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/extensions/string_extensions.dart';
import 'package:ecommerce_app/models/payment_card.dart';
import 'package:ecommerce_app/models/payment_method.dart';
import 'package:ecommerce_app/screens/add_payment_card_screen/add_payment_card_screen.dart';
import 'package:ecommerce_app/screens/cart_screen/widgets/cart_item_background.dart';
import 'package:flutter/material.dart';

class PaymentItemCard extends StatelessWidget {
  final bool isSelected;
  final PaymentMethod paymentMethod;
  final PaymentCard? paymentCard;
  final VoidCallback onTap;

  const PaymentItemCard({
    super.key,
    required this.isSelected,
    required this.paymentMethod,
    required this.paymentCard,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CartItemBackground(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          backgroundColor:
              isSelected ? AppColors.primaryColor : AppColors.whiteColor,
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(paymentMethod.imageAsset)),
                  color: AppColors.greyColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paymentMethod.name,
                    style: AppStyles.labelMedium.copyWith(
                        color: isSelected
                            ? AppColors.whiteColor
                            : AppColors.primaryColor),
                  ),
                  if (paymentCard != null)
                    Text(
                      paymentCard!.cardNumber.maskCardNumber(),
                      style: AppStyles.bodyLarge.copyWith(
                          color: isSelected
                              ? AppColors.whiteColor
                              : AppColors.primaryColor),
                    )
                ],
              ),
              const Spacer(),
              if (paymentCard == null &&
                  paymentMethod.code != "cash_on_delivery")
                TextButton(
                    onPressed: () => _navigateToAddPaymentCardScreen(context),
                    child: const Text("Add"))
            ],
          )),
    );
  }

  _navigateToAddPaymentCardScreen(BuildContext context) {
    Navigator.pushNamed(context, AddPaymentCardScreen.routeName);
  }
}
