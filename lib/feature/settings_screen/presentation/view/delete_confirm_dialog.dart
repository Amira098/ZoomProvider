import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_provider/feature/auth/presentation/view/login_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/show_pretty_snack.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../auth/presentation/view/sign_up.dart';
import '../view_model/delete_account_cubit.dart';
import '../view_model/delete_account_state.dart';

class DeleteConfirmDialog extends StatefulWidget {
  const DeleteConfirmDialog({super.key});

  @override
  State<DeleteConfirmDialog> createState() => _DeleteConfirmDialogState();
}

class _DeleteConfirmDialogState extends State<DeleteConfirmDialog> {
  final DeleteCubit _cubit = serviceLocator<DeleteCubit>();

  String _getLocalizedMessage(BuildContext context, dynamic message) {
    if (message == null) return '';

    final langCode = context.locale.languageCode;

    if (message is String) {
      return message;
    }

    if (message is Map) {
      final ar = message['ar']?.toString();
      final en = message['en']?.toString();

      return langCode == 'ar'
          ? (ar ?? en ?? '')
          : (en ?? ar ?? '');
    }

    try {
      final ar = message.ar?.toString();
      final en = message.en?.toString();

      return langCode == 'ar'
          ? (ar ?? en ?? '')
          : (en ?? ar ?? '');
    } catch (_) {
      return message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<DeleteCubit, DeleteState>(
        listener: (context, state) async {
          if (state is DeleteSuccess) {
            if (!mounted) return;

            Navigator.of(context).pop(true);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
                  (route) => false,
            );
          }

          if (state is DeleteError) {
            if (!mounted) return;

            final errorMessage = _getLocalizedMessage(
              context,
              state.apiError?.message,
            );

            showPrettySnack(
              context,
              errorMessage.isNotEmpty
                  ? errorMessage
                  : LocaleKeys.Error_Unexpected_error.tr(),
              success: false,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is DeleteLoading;

          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.delete_confirm_message.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 22.h),
                  if (isLoading)
                    Padding(
                      padding: EdgeInsets.all(12.r),
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48.h,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<DeleteCubit>().deleteAccount();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                LocaleKeys.delete_action.tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: SizedBox(
                            height: 48.h,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.primary),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                LocaleKeys.general_cancel.tr(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DeleteSuccessDialog extends StatefulWidget {
  const DeleteSuccessDialog({super.key});

  @override
  State<DeleteSuccessDialog> createState() => _DeleteSuccessDialogState();
}

class _DeleteSuccessDialogState extends State<DeleteSuccessDialog> {
  double _scale = 0.0;
  double _opacity = 0.0;

  Timer? _animationTimer;
  Timer? _closeTimer;

  @override
  void initState() {
    super.initState();

    _animationTimer = Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;

      setState(() {
        _scale = 1.0;
        _opacity = 1.0;
      });
    });

    _closeTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    _closeTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              child: CircleAvatar(
                radius: 32.r,
                backgroundColor: Colors.blue.shade100,
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 36.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              child: Text(
                LocaleKeys.delete_success_message.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
