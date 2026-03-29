import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../view_model/services_faqs/services_faqs_cubit.dart';
import '../view_model/services_faqs/services_faqs_state.dart';

class GlassFaqSection extends StatefulWidget {
  const GlassFaqSection({super.key});

  @override
  State<GlassFaqSection> createState() => _GlassFaqSectionState();
}

class _GlassFaqSectionState extends State<GlassFaqSection> {

  final ServicesFaqsCubit _cubit = serviceLocator<ServicesFaqsCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.fetchFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 30),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white),
        boxShadow: [
          BoxShadow(
            color: AppColors.black12,
            blurRadius: 8,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: BlocProvider(
        create: (_) => _cubit,
        child: BlocBuilder<ServicesFaqsCubit, ServicesFaqsState>(
          builder: (context, state) {

            if (state is ServicesFaqsLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }

            if (state is ServicesFaqsError) {
              return const Center(
                child: Text(
                  "حدث خطأ أثناء تحميل الأسئلة",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            if (state is ServicesFaqsLoaded) {
              final faqs = state.faqs.data ?? [];

              if (faqs.isEmpty) {
                return const Center(
                  child: Text(
                    "لا توجد أسئلة متاحة حالياً",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "الأسئلة الشائعة",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ...faqs
                      .where((e) =>
                  (e.question ?? '').trim().isNotEmpty &&
                      (e.answer ?? '').trim().isNotEmpty)
                      .map(
                        (e) => _GlassFaqItem(
                      question: e.question!,
                      answer: e.answer!,
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
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
