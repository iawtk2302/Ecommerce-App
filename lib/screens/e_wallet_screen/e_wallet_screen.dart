import 'package:ecommerce_app/blocs/e_wallet_transactions_bloc/e_wallet_transactions_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/common_widgets/section_label.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/all_transactions_history_screen/all_transactions_history_screen.dart';
import 'package:ecommerce_app/screens/e_wallet_screen/widgets/balance_widget.dart';
import 'package:ecommerce_app/screens/e_wallet_screen/widgets/transactions_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EWalletScreen extends StatefulWidget {
  const EWalletScreen({super.key});

  static const String routeName = "/e-wallet-screen";

  @override
  State<EWalletScreen> createState() => _EWalletScreenState();
}

class _EWalletScreenState extends State<EWalletScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EWalletTransactionsBloc>().add(LoadEWalletTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenNameSection(label: "My E-Wallet"),
          const BalanceWidget(),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionLabel(label: "Transaction History"),
              TextButton(
                  onPressed: _navigateToAllTransactionScree,
                  child: const Text(
                    "See All",
                    style: AppStyles.labelMedium,
                  ))
            ],
          ),
          const TransactionsHistory()
        ],
      ),
    );
  }

  void _navigateToAllTransactionScree() {
    Navigator.pushNamed(context, AllTransactionHistoryScreen.routeName);
  }
}
