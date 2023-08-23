import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/blocs/language_bloc/language_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/constants/enums/language.dart';
import 'package:ecommerce_app/screens/profile_screen/widgets/profile_section_background.dart';
import 'package:ecommerce_app/screens/select_language_screen/select_language_screen.dart';
import 'package:ecommerce_app/screens/settings_screen/widgets/my_switch_button.dart';
import 'package:ecommerce_app/screens/settings_screen/widgets/settings_button.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const String routeName = "/settings-screen";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationMode = true;
  bool darkMode = true;

  @override
  void initState() {
    super.initState();
    _getNotificationMode();
    _getDarkMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenNameSection(label: "Settings"),
          ProfileSectionBackground(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.defaultPadding),
              child: Column(
                children: [
                  SettingButton(
                      title: "Language",
                      iconAsset: AppAssets.icGlobal,
                      onPressed: _onNavigateToSelectLanguageScreen,
                      action: BlocBuilder<LanguageBloc, LanguageState>(
                        builder: (context, state) {
                          if (state is LanguageLoaded) {
                            return Row(
                              children: [
                                Text(
                                    languageToLanguageName[
                                        languageCodeToLanguage[state.locale]!]!,
                                    style: AppStyles.bodyLarge),
                                const SizedBox(width: 10),
                                const MyIcon(
                                    icon: AppAssets.icChevronRight, height: 14)
                              ],
                            );
                          }
                          return Container();
                        },
                      )),
                  SettingButton(
                      title: "Notification",
                      iconAsset: AppAssets.icNotification,
                      action: MySwitchButton(
                        value: notificationMode,
                        onChanged: (value) => _onChangeNotificationMode(),
                      )),
                  SettingButton(
                      title: "Dark mode",
                      iconAsset: AppAssets.icMoon,
                      action: MySwitchButton(
                        value: darkMode,
                        onChanged: (value) => _onChangeDarkMode(),
                      )),
                  const SettingButton(
                      title: "Help Center",
                      iconAsset: AppAssets.icInfo,
                      action: SizedBox()),
                ],
              )),
          const Spacer(),
          MyButton(
            margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.defaultPadding),
            borderRadius: 12,
            onPressed: _onLogOut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyIcon(
                  icon: AppAssets.icLogout,
                  colorFilter:
                      ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 10),
                Text("Log out",
                    style: AppStyles.labelLarge
                        .copyWith(color: AppColors.whiteColor)),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _onChangeNotificationMode() {
    setState(() {
      notificationMode = !notificationMode;
    });
    Utils().changeNotificationMode();
  }

  _getNotificationMode() async {
    final notificationMode = await Utils().getNotificationMode();
    setState(() {
      this.notificationMode = notificationMode;
    });
  }

  _getDarkMode() async {
    final darkMode = await Utils().getDarkMode();
    setState(() {
      this.darkMode = darkMode;
    });
  }

  void _onChangeDarkMode() {
    setState(() {
      darkMode = !darkMode;
    });
    Utils().changeDarkMode();
  }

  void _onLogOut() {
    context.read<AuthBloc>().add(LogOut());
  }

  void _onNavigateToSelectLanguageScreen() {
    Navigator.pushNamed(context, SelectLanguageScreen.routeName);
  }
}
