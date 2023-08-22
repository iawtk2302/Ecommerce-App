import 'package:ecommerce_app/blocs/language_bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: TextButton(
                onPressed: () {
                  context
                      .read<LanguageBloc>()
                      .add(const ChangeLanguage(locate: 'vi'));
                },
                child: const Text('hihi')),
          ),
        );
      },
    );
  }
}
