import 'package:ecommerce_app/blocs/language_bloc/language_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/constants/enums/language.dart';
import 'package:ecommerce_app/extensions/language_extension.dart';
import 'package:ecommerce_app/common_widgets/primary_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  static const String routeName = "/select-language-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const ScreenNameSection(label: "Select Language"),
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: Language.values.length,
                  itemBuilder: (_, index) {
                    final Language language = Language.values[index];
                    final isSelected = state is LanguageLoaded &&
                        state.locale == language.code;
                    return PrimaryBackground(
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.defaultPadding,
                          vertical: 10),
                      backgroundColor: isSelected
                          ? AppColors.primaryColor
                          : AppColors.whiteColor,
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: AppDimensions.circleCorners,
                          child: Image.asset(
                            language.flag,
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          languageToLanguageName[language]!,
                          style: AppStyles.titleSmall.copyWith(
                              color: isSelected
                                  ? AppColors.whiteColor
                                  : AppColors.primaryColor),
                        ),
                        onTap: () => _onSelectLanguage(context, language.code),
                      ),
                    );
                  });
            },
          )
        ]));
  }

  void _onSelectLanguage(BuildContext context, String languageCode) {
    context.read<LanguageBloc>().add(ChangeLanguage(locate: languageCode));
  }
}
