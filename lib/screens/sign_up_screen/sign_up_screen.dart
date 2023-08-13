import 'package:ecommerce_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:ecommerce_app/common_widgets/loading_manager.dart';
import 'package:ecommerce_app/common_widgets/login_text_field.dart';
import 'package:ecommerce_app/common_widgets/my_button.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_colors.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/constants/app_styles.dart';
import 'package:ecommerce_app/screens/sign_up_screen/sign_up_success_screen.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = "/sign-up-screen";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool agreeWithTerms = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.pushNamed(context, SignUpSuccessScreen.routeName);
          } else if (state is AuthenticationFailure) {
            Utils.showSnackBar(context: context, message: state.message);
          }
        },
        builder: (context, state) {
          return LoadingManager(
            isLoading: state is Authenticating,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppDimensions.defaultPadding,
                    50, AppDimensions.defaultPadding, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SvgPicture.asset(AppAssets.icAppLogo),
                      SizedBox(height: size.height * 0.05),
                      const Text("Sign Up", style: AppStyles.headlineLarge),
                      const SizedBox(height: 5),
                      const Text("Create an new account",
                          style: AppStyles.bodyLarge),
                      SizedBox(height: size.height * 0.07),
                      const Text("User Name", style: AppStyles.labelLarge),
                      LoginTextField(
                        hint: "User Name",
                        controller: _userNameController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name.";
                          }
                          return null;
                        },
                      ),
                      const Text("Email", style: AppStyles.labelLarge),
                      LoginTextField(
                        hint: "Email",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required.";
                          } else if (!Utils.isEmailValid(value)) {
                            return "Please enter valid email.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      const Text("Password", style: AppStyles.labelLarge),
                      LoginTextField(
                        hint: "Password",
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password.";
                          } else if (Utils.isValidPassword(value) != "valid") {
                            return Utils.isValidPassword(value);
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                          icon: obscurePassword
                              ? SvgPicture.asset(AppAssets.icInvisible)
                              : SvgPicture.asset(AppAssets.icVisible),
                        ),
                      ),
                      const Text("Confirm Password",
                          style: AppStyles.labelLarge),
                      LoginTextField(
                        hint: "Confirm Password",
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.text,
                        obscureText: obscureConfirmPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureConfirmPassword = !obscureConfirmPassword;
                            });
                          },
                          icon: obscureConfirmPassword
                              ? SvgPicture.asset(AppAssets.icInvisible)
                              : SvgPicture.asset(AppAssets.icVisible),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter confirm password.";
                          } else if (value != _passwordController.text) {
                            return "Confirm password does not match.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: agreeWithTerms,
                              activeColor: AppColors.primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  agreeWithTerms = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              "By creating an account you have to agree with our Terms and Conditions",
                              style: AppStyles.bodyLarge,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
                      MyButton(
                        onPressed: _onSignUp,
                        child: Text("Sign Up",
                            style: AppStyles.labelLarge
                                .copyWith(color: Colors.white)),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("You already have an account? ",
                              style: AppStyles.bodyLarge),
                          InkWell(
                            onTap: _navigateToSignInScreen,
                            child: Text("Sign in",
                                style: AppStyles.bodyLarge
                                    .copyWith(color: AppColors.primaryColor)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSignUp() {
    if (_formKey.currentState!.validate() && agreeWithTerms) {
      context.read<AuthBloc>().add(SignUpWithEmailAndPassword(
          name: _userNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          context: context));
    }
  }

  void _navigateToSignInScreen() {
    Navigator.pop(
        context); // Because we can only navigate to sign up screen from sign in, so we can pop to sign in screen
  }
}
