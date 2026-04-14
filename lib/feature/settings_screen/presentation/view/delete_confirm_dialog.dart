import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/pick_localized_dyn.dart';
import '../../../../core/utils/show_pretty_snack.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../auth/presentation/view/login_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: BlocConsumer<DeleteCubit, DeleteState>(
        listener: (context, state) async {
          if (state is DeleteSuccess) {
            if (mounted) Navigator.of(context).pop(); // close confirm dialog
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
            );
          } else if (state is DeleteError) {
            if (mounted) {
              showPrettySnack(
                context,
                state.apiError?.getLocalizedMessage(context) ?? LocaleKeys.general_unexpected_error.tr(),
                success: false,
              );
            }
          }
        },
        builder: (context, state) {
          final isLoading = state is DeleteLoading;

          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.delete_confirm_message.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 22),
                  if (isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(color: Colors.blue),
                      ),
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<DeleteCubit>().deleteAccount();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                LocaleKeys.delete.tr(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.blue.shade200),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                LocaleKeys.general_cancel.tr(),
                                style: const TextStyle(
                                  fontSize: 16,
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

class _DeleteSuccessDialogState extends State<DeleteSuccessDialog>
    with SingleTickerProviderStateMixin {
  double _scale = 0.0;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 200), () {
      setState(() {
        _scale = 1.0;
        _opacity = 1.0;
      });
    });

    // ✅ Auto close after 2 seconds
    Timer(const Duration(seconds: 2), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutBack,
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Colors.blue.shade100,
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              child: Text(
                LocaleKeys.delete_success_message.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
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
