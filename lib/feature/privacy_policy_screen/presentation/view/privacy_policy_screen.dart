import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/dialogs/app_dialogs.dart';
import '../../../../generated/locale_keys.g.dart';
import '../view_model/privacy/privacy_cubit.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final PrivacyCubit privacyCubit = serviceLocator<PrivacyCubit>();

  @override
  void initState() {
    super.initState();
    privacyCubit.getPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B1D27),
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Text(
                    LocaleKeys.privacyPolicy_title.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [

                  BlocProvider(
                    create: (context) => privacyCubit,
                    child: BlocConsumer<PrivacyCubit, PrivacyState>(
                      listener: (context, state) {
                        if (state is PrivacyFailure) {
                          AppDialogs.showFailureDialog(context, message: state.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is PrivacyLoading) {
                          return Skeletonizer(
                            enabled: true,
                            child: _buildPrivacyContent(
                                "This is a dummy text for privacy policy section. " * 30),
                          );
                        } else if (state is PrivacySuccess) {
                          return _buildPrivacyContent(_getLocalizedPrivacyText(state));
                        } else if (state is PrivacyFailure) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 64),
                              child: Text(
                                state.message,
                                style: TextStyle(color: AppColors.grey500, fontSize: 16),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyContent(String htmlData) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Html(
        data: htmlData,
        style: {
          'body': Style(
            color: AppColors.black,
            fontSize: FontSize(14),
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.center,
          ),
        },
      ),
    );
  }

  String _getLocalizedPrivacyText(PrivacySuccess state) {
    final lang = context.locale.languageCode;
    final body = state.data.data?.body;
    final message = state.data.message;

    switch (lang) {
      case 'ar':
        return body?.ar ?? message?.ar ?? LocaleKeys.privacyPolicy_noContent.tr();
      case 'en':
        return body?.en ?? message?.en ?? LocaleKeys.privacyPolicy_noContent.tr();
      default:
        return body?.en ?? LocaleKeys.privacyPolicy_noContent.tr();
    }
  }
}
