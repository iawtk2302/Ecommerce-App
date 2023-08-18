import 'package:ecommerce_app/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/blocs/cart_bloc/cart_bloc.dart';
import 'package:ecommerce_app/blocs/language_bloc/language_bloc.dart';
import 'package:ecommerce_app/blocs/order_processing_bloc/order_processing_bloc.dart';
import 'package:ecommerce_app/blocs/payment_methods_bloc/payment_methods_bloc.dart';
import 'package:ecommerce_app/blocs/place_order_bloc/place_order_bloc.dart';
import 'package:ecommerce_app/blocs/category_bloc/category_bloc.dart';
import 'package:ecommerce_app/blocs/category_product_bloc/category_product_bloc.dart';
import 'package:ecommerce_app/blocs/home_bloc/home_bloc.dart';
import 'package:ecommerce_app/blocs/product_bloc/product_bloc.dart';
import 'package:ecommerce_app/blocs/product_screen_bloc/product_screen_bloc.dart';
import 'package:ecommerce_app/blocs/review_screen_bloc/review_screen_bloc.dart';
import 'package:ecommerce_app/blocs/search_filter_bloc/search_filter_bloc.dart';
import 'package:ecommerce_app/blocs/show_notification/show_notification_bloc.dart';
import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/config/app_routes.dart';
import 'package:ecommerce_app/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()..add(CheckAuthentication())),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => ShowNotificationBloc()),
        BlocProvider(create: (_) => PlaceOrderBloc()),
        BlocProvider(create: (_) => PaymentMethodsBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => SearchFilterBloc()),
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(create: (_) => CategoryProductBloc()),
        BlocProvider(
            create: (context) => ProductBloc(
                showNotificationBloc:
                    BlocProvider.of<ShowNotificationBloc>(context))),
        BlocProvider(create: (_) => ProductScreenBloc()),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => OrderProcessingBloc()),
        BlocProvider(create: (_) => AddressesBloc()),
        BlocProvider(create: (_) => ReviewScreenBloc()),
        BlocProvider(create: (_) => LanguageBloc()..add(const LoadLanguage())),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          Locale? locate;
          if (state is LanguageLoaded) {
            locate = Locale(state.locate);
          }
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRouter().onGenerateRoute,
            theme: ThemeData(
              fontFamily: 'Poppins',
              // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              useMaterial3: true,
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate, // Generated delegate
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            locale: locate,
            supportedLocales: AppLocalizations.supportedLocales,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
