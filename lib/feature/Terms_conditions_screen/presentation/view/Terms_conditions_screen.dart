import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/pick_localized_dyn.dart';
import '../../../../core/utils/show_pretty_snack.dart';
import '../../../../generated/locale_keys.g.dart';
import '../view_model/terms-and-conditions/terms_and_conditions_cubit.dart';
import '../view_model/terms-and-conditions/terms_and_conditions_state.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  final TermsAndConditionsCubit cubit = serviceLocator<TermsAndConditionsCubit>();

  @override
  void initState() {
    super.initState();
    cubit.gettermsAndConditions();
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
              height: 70.h,
              padding: EdgeInsets.symmetric(horizontal: 18.w),
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
                    LocaleKeys.terms_and_conditions_title.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
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
              decoration: BoxDecoration(
                color: const Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Stack(
                children: [

                  BlocProvider(
                    create: (context) => cubit,
                    child: BlocConsumer<TermsAndConditionsCubit, TermsAndConditionsState>(
                      listener: (context, state) {
                        if (state is TermsAndConditionsFailure) {
                          showPrettySnack(context, state.message, success: false);
                        }
                      },
                      builder: (context, state) {
                        if (state is TermsAndConditionsLoading) {
                          return Skeletonizer(
                            enabled: true,
                            child: _buildTermsContent(
                                "This is a dummy text for terms and conditions section. " * 30),
                          );
                        } else if (state is TermsAndConditionsSuccess) {
                          return _buildTermsContent(_getLocalizedPrivacyText(state));
                        } else if (state is TermsAndConditionsFailure) {
                          return Center(child: Text(state.message));
                        } else {
                          return const SizedBox.shrink();
                        }
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

  Widget _buildTermsContent(String htmlData) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Html(
        data: htmlData,
        style: {
          'body': Style(
            color: AppColors.black,
            fontSize: FontSize(14.sp),
            fontWeight: FontWeight.normal,
            textAlign: TextAlign.center,
          ),
        },
      ),
    );
  }

  String _getLocalizedPrivacyText(TermsAndConditionsSuccess state) {
    final lang = context.locale.languageCode;
    final body = state.data.data?.body;
    final message = state.data.message;

    switch (lang) {
      case 'ar':
        return body?.ar ?? message?.ar ?? LocaleKeys.no_content.tr();
      case 'en':
        return body?.en ?? message?.en ?? LocaleKeys.no_content.tr();
      default:
        return body?.en ?? '';
    }
  }
}
