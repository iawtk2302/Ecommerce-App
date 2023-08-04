import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/home_app_bar.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/header_home.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/promotions_home.dart';
import 'package:ecommerce_app/screens/home_screen/widgets/new_arrivals_home.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 100) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> ui = [
      const HeaderHome(),
      const PromotionsHome(),
      const NewArrivalsHome()
    ];
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: HomeAppBar(
            height: size.height * 0.09,
            isScrolled: _isScrolled,
          ),
          body: ListView.builder(
            controller: _scrollController,
            itemCount: ui.length,
            itemBuilder: (context, index) {
              return ui[index];
            },
          )),
    );
  }
}
