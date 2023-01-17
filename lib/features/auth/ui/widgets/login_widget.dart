import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/textfield/custom_textfield.dart';
import 'package:ecommerce_app/common/utils/snackbar_utils.dart';
import 'package:ecommerce_app/features/auth/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/auth/model/user.dart';
import 'package:ecommerce_app/features/auth/ui/screens/signup_page.dart';
import 'package:ecommerce_app/features/dashboard/ui/screens/dashboard_screens.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class LoginWidgets extends StatefulWidget {
  const LoginWidgets({Key? key}) : super(key: key);

  @override
  State<LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        appBar: AppBar(backgroundColor: CustomTheme.primaryColor),
        body: BlocListener<LoginCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              setState(() {
                _isLoading = true;
              });
            } else {
              setState(() {
                _isLoading = false;
              });
            }

            if (state is CommonSuccessState<User>) {
              Navigator.of(context).pushAndRemoveUntil(
                PageTransition(
                  child: DashboardScreens(),
                  type: PageTransitionType.fade,
                ),
                (route) => false,
              );
              SnackbarUtils.showSnackBar(
                context: context,
                message: "Logged in Successfully",
              );
            } else if (state is CommonErrorState) {
              SnackbarUtils.showSnackBar(
                  context: context, message: state.message);
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.horizontalPadding,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "Email Address",
                      hintText: "Enter Email Address",
                      controller: _emailController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Email field cannot be empty";
                        }
                        final _isvalid = EmailValidator.validate(val);
                        if (_isvalid) {
                          return null;
                        } else {
                          return "Enter valid email address";
                        }
                      },
                    ),
                    CustomTextField(
                      label: "Password",
                      hintText: "Enter Password",
                      controller: _passwordController,
                      obscureText: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Password field cannot be empty";
                        } else if (val.length < 4) {
                          return "Password field must be at least 4 character long";
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomRoundedButtom(
                      title: "LOGIN",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginCubit>().login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Don't have account?",
                        style: _textTheme.bodyText2,
                        children: [
                          TextSpan(
                            text: " Sign Up",
                            style: _textTheme.bodyText2!.copyWith(
                              color: CustomTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  PageTransition(
                                    child: SignupPages(),
                                    type: PageTransitionType.fade,
                                  ),
                                );
                              },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
