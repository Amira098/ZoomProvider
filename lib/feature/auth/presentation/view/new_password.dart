import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/pick_localized_dyn.dart';
import '../../../../core/utils/show_pretty_snack.dart';
import '../../../../core/utils/utils/customTextField.dart';
import '../../../../generated/locale_keys.g.dart';
import '../view_model/forget_password/forget_password_cubit.dart';
import '../view_model/forget_password/forget_password_state.dart';
import 'changed_successfully_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;
  final String code;
  const NewPasswordScreen({super.key, required this.email, required this.code});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ForgetPasswordCubit>(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            showPrettySnack(
                context,
                pickLocalizedDyn(state.response.message, context.locale.languageCode == 'ar') ?? "Password changed successfully",
                success: true);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const ChangedSuccessfullyScreen(),
              ),
              (route) => false,
            );
          } else if (state is ResetPasswordFailure) {
            showPrettySnack(
              context,
              state.apiError?.getLocalizedMessage(context) ?? state.exception?.toString() ?? "Error resetting password",
              success: false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/svg/backgrawend.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0.r),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Icon(Icons.arrow_back_ios_new, size: 18),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            Center(
                              child: Image.asset(
                                "assets/svg/zoomLogo.png",
                                width: 180.w,
                                height: 100.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: 60.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                LocaleKeys.Authentication_ResetPassword.tr(),
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                LocaleKeys.Authentication_fillInTheForm.tr(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black54,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 32.h),
                            CommonTextFormField(
                              controller: _passwordController,
                              hint: LocaleKeys.Authentication_must_be_8_chars.tr(),
                              label: LocaleKeys.Authentication_NewPassword.tr(),
                              borderRadius: 30,
                              fillColor: Colors.white.withOpacity(0.4),
                              borderColor: Colors.grey.shade400,
                              obscureText: true,
                            ),
                            SizedBox(height: 24.h),
                            CommonTextFormField(
                              controller: _confirmController,
                              hint: LocaleKeys.Authentication_repeat_password.tr(),
                              label: LocaleKeys.Authentication_ConfirmPassword.tr(),
                              borderRadius: 30,
                              fillColor: Colors.white.withOpacity(0.4),
                              borderColor: Colors.grey.shade400,
                              obscureText: true,
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24.0.r),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          onPressed: state is ForgetPasswordLoading
                              ? null
                              : () {
                                  if (_passwordController.text.isNotEmpty &&
                                      _confirmController.text.isNotEmpty) {
                                    context.read<ForgetPasswordCubit>().resetPassword(
                                          code: widget.code,
                                          email: widget.email,
                                          password: _passwordController.text,
                                          confirmPassword: _confirmController.text,
                                        );
                                  } else {
                                    showPrettySnack(
                                      context,
                                      LocaleKeys.Authentication_EnterAndConfirmPassword.tr(),
                                      success: false,
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF1E28),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            elevation: 0,
                          ),
                          child: state is ForgetPasswordLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  LocaleKeys.Authentication_ResetPassword.tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
