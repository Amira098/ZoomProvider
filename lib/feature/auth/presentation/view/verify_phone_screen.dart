import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/pick_localized_dyn.dart';
import '../../../../core/utils/show_pretty_snack.dart';
import '../../../../generated/locale_keys.g.dart';
import '../view_model/forget_password/forget_password_cubit.dart';
import '../view_model/forget_password/forget_password_state.dart';
import 'new_password.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String email;
  const VerifyPhoneScreen({super.key, required this.email});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return BlocProvider(
      create: (context) => serviceLocator<ForgetPasswordCubit>(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is SendResetEmailSuccess) {
            showPrettySnack(
              context,
              pickLocalizedDyn(state.response.message, context.locale.languageCode == 'ar') ??
                  LocaleKeys.Messages_code_resent.tr(),
              success: true,
            );
          } else if (state is SendResetEmailFailure) {
            showPrettySnack(
              context,
              state.apiError?.getLocalizedMessage(context) ?? state.exception?.toString() ?? "Error resending code",
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

                            Center(
                              child: Text.rich(
                                TextSpan(
                                  text: LocaleKeys.Authentication_PleaseEnterYourCode.tr(),
                                  children: [
                                    TextSpan(
                                      text: widget.email,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black54,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            SizedBox(height: 32.h),
                            Pinput(
                              length: 6,
                              controller: _pinController,
                              keyboardType: TextInputType.number,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: defaultPinTheme.copyWith(
                                decoration: defaultPinTheme.decoration!.copyWith(
                                  border: Border.all(color: const Color(0xFFFF1E28)),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.Authentication_DidnotReceiveCode.tr(),
                                  style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                                ),
                                state is ForgetPasswordLoading
                                    ? SizedBox(
                                        width: 16.w,
                                        height: 16.h,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          context
                                              .read<ForgetPasswordCubit>()
                                              .sendResetEmail(email: widget.email);
                                        },
                                        child: Text(
                                          LocaleKeys.Authentication_Resend.tr(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                              ],
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
                          onPressed: () {
                            if (_pinController.text.length == 6) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NewPasswordScreen(
                                    email: widget.email,
                                    code: _pinController.text,
                                  ),
                                ),
                              );
                            } else {
                              showPrettySnack(
                                context,
                                LocaleKeys.Authentication_Enter6DigitCode.tr(),
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
                          child: Text(
                            LocaleKeys.Authentication_Confirm.tr(),
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
