import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../view_model/services_faqs/services_faqs_cubit.dart';
import '../view_model/services_faqs/services_faqs_state.dart';

class _GlassFaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _GlassFaqItem({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.6)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          collapsedIconColor: AppColors.background,
          iconColor: AppColors.primary,
          title: Text(
            question,
            style: const TextStyle(
              color: AppColors.background,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 14,
              ),
              child: Text(
                answer,
                style: TextStyle(
                  color: AppColors.background,
                  fontSize: 14
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
