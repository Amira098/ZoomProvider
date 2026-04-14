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
import 'verify_phone_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ForgetPasswordCubit>(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is SendResetEmailSuccess) {
            showPrettySnack(
                context,
                pickLocalizedDyn(state.response.message, context.locale.languageCode == 'ar') ?? "Success",
                success: true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerifyPhoneScreen(email: _emailController.text),
              ),
            );
          } else if (state is SendResetEmailFailure) {
            showPrettySnack(
              context,
              state.apiError?.getLocalizedMessage(context) ?? state.exception?.toString() ?? "Error",
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
                            child:
                                Icon(Icons.arrow_back_ios_new, size: 18),
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
                                LocaleKeys.Authentication_forgot_password.tr(),
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              LocaleKeys.Authentication_PleaseEnterYourEmail.tr(),
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 32.h),
                            CommonTextFormField(
                              controller: _emailController,
                              hint: LocaleKeys.Authentication_EnterYourEmail.tr(),
                              label: LocaleKeys.Authentication_email_address.tr(),
                              borderRadius: 30,
                              fillColor: Colors.white.withOpacity(0.8),
                              borderColor: Colors.grey.shade400,
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24.0.r),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 56.h,
                            child: ElevatedButton(
                              onPressed: state is ForgetPasswordLoading
                                  ? null
                                  : () {
                                      if (_emailController.text.isNotEmpty) {
                                        context
                                            .read<ForgetPasswordCubit>()
                                            .sendResetEmail(
                                              email: _emailController.text,
                                            );
                                      } else {
                                        showPrettySnack(
                                          context,
                                          LocaleKeys.Authentication_EnterYourEmail.tr(),
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
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text(
                                      LocaleKeys.Authentication_SendOtp.tr(),
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.Authentication_RememberMe.tr(),
                                style: TextStyle(color: Colors.black, fontSize: 14.sp),
                              ),
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Text(
                                  LocaleKeys.Authentication_Login.tr(),
                                  style: TextStyle(
                                    color:  const Color(0xFFFF1E28),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ],
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
