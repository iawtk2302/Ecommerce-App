import 'package:ecommerce_app/blocs/user_bloc/user_bloc.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/constants/enums/gender.dart';
import 'package:ecommerce_app/screens/personal_details_screen/widgets/profile_details_information.dart';
import 'package:ecommerce_app/screens/personal_details_screen/widgets/profile_image.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  static const String routeName = "/personal-details-screen";

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _emailController;
  late Gender gender;
  XFile? pickedImage;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initValues();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.defaultPadding),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileImage(
                        onPressed: () async {
                          final newImage = await Utils().pickImage();
                          setState(() {
                            pickedImage = newImage;
                          });
                        },
                        pickedImage: pickedImage,
                      ),
                      ProfileDetailsInformation(
                        label: "Name",
                        hintText: "Name",
                        controller: _nameController,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4 - 60,
                            child: Text("Gender",
                                style: AppStyles.labelMedium
                                    .copyWith(color: AppColors.greyTextColor)),
                          ),
                          ...List.generate(2, (index) {
                            final thisGender =
                                index == 0 ? Gender.male : Gender.female;
                            final isSelected = thisGender == gender;

                            return MyButton(
                                margin: const EdgeInsets.only(left: 10),
                                borderRadius: 8,
                                padding: const EdgeInsets.all(6),
                                onPressed: () {
                                  setState(() {
                                    gender = thisGender;
                                  });
                                },
                                borderSide: !isSelected
                                    ? const BorderSide(
                                        width: 2,
                                        color: AppColors.darkGreyColor,
                                      )
                                    : BorderSide.none,
                                backgroundColor: isSelected
                                    ? AppColors.primaryColor
                                    : AppColors.whiteColor,
                                child: Row(
                                  children: [
                                    Radio(
                                        visualDensity: const VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        activeColor: Colors.white,
                                        value: gender,
                                        groupValue: thisGender,
                                        onChanged: (value) {}),
                                    Text(genderToString[thisGender]!,
                                        style: AppStyles.labelMedium.copyWith(
                                            color: isSelected
                                                ? AppColors.whiteColor
                                                : AppColors.darkGreyColor)),
                                  ],
                                ));
                          }),
                        ],
                      ),
                      ProfileDetailsInformation(
                        label: "Age",
                        hintText: "Age",
                        controller: _ageController,
                      ),
                      ProfileDetailsInformation(
                        label: "Email",
                        hintText: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is not empty";
                          } else if (!Utils.isEmailValid(value)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        controller: _emailController,
                      ),
                      const Spacer(),
                      MyButton(
                        onPressed: _onUpdateUser,
                        borderRadius: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Save",
                                style: AppStyles.labelLarge
                                    .copyWith(color: AppColors.whiteColor)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ));
  }

  _initValues() {
    final userState = context.read<UserBloc>().state;
    if (userState is UserLoaded) {
      _nameController = TextEditingController(text: userState.user.name);
      _ageController =
          TextEditingController(text: userState.user.age?.toString());
      _emailController = TextEditingController(text: userState.user.email);
      gender = userState.user.gender ?? Gender.notHave;
    }
  }

  void _onUpdateUser() {
    if (_formKey.currentState!.validate()) {
      context.read<UserBloc>().add(UpdateUser(
          name: _nameController.text,
          gender: gender,
          age: _ageController.text.isNotEmpty
              ? int.parse(_ageController.text)
              : null,
          email: _emailController.text,
          image: pickedImage));
    }
  }
}
