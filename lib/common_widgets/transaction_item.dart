import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final String label;
  final String number;

  const TransactionItem({
    super.key,
    required this.label,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(number),
        ],
      ),
    );
  }
}
