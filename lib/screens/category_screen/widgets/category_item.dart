import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://www.elle.vn/wp-content/uploads/2017/01/18/th%E1%BA%BF-gi%E1%BB%9Bi-th%E1%BB%9Di-trang-River-Island-1-elle-vietnam.jpg"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Clothes",
                style:
                    AppStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            Text("123 Product",
                style: AppStyles.labelMedium.copyWith(fontSize: 11),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
