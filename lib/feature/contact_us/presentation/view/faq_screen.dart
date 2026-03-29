import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/di/service_locator.dart';
import '../../../contact_us/presentation/view_model/services_faqs/services_faqs_cubit.dart';
import '../../../contact_us/presentation/view_model/services_faqs/services_faqs_state.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final ServicesFaqsCubit _cubit = serviceLocator<ServicesFaqsCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.fetchFaqs();
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
                  const Text(
                    'FAQs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
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
                    create: (context) => _cubit,
                    child: BlocBuilder<ServicesFaqsCubit, ServicesFaqsState>(
                      builder: (context, state) {
                        return ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                          children: [
                            const Text(
                              'FAQ',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                                color: Color(0xff1B1D27),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Find important information and update about any recent changes and fees here.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff8A8A8A),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 24),
                            if (state is ServicesFaqsLoading)
                              const Center(child: CircularProgressIndicator())
                            else if (state is ServicesFaqsLoaded)
                              ..._buildFaqList(state.faqs.data ?? [])
                            else if (state is ServicesFaqsError)
                                Center(child: Text(state.message))
                            else
                              ..._buildPlaceholderFaqs(),
                          ],
                        );
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

  List<Widget> _buildFaqList(List<dynamic> faqs) {
    // Assuming we might want to categorize them or just list them.
    // The design shows categories like "General" and "Contact".
    // For now, let's just list them under "General" if they aren't categorized.
    return [
      _buildSectionTitle('General'),
      ...faqs.map((faq) => _buildFaqItem(faq.question ?? '', faq.answer ?? '')),
    ];
  }

  List<Widget> _buildPlaceholderFaqs() {
    return [
      _buildSectionTitle('General'),
      _buildFaqItem('How to contact with riders ?', 'Placeholder answer text.'),
      _buildFaqItem('How to change my selected furniture ?', 'Placeholder answer text.'),
      _buildFaqItem('What is cost of each item ?', 'Placeholder answer text.'),
      const SizedBox(height: 16),
      _buildSectionTitle('Contact'),
      _buildFaqItem('What is the customer care number ?', 'Placeholder answer text.'),
      _buildFaqItem('Can I Cancel the order after one week ?',
        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.'),
      _buildFaqItem('How to call any service now?', 'Placeholder answer text.'),
    ];
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xffF3212D),
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffE8E8E8)),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(
            question,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xff1E1E1E),
            ),
          ),
          iconColor: const Color(0xff1E1E1E),
          collapsedIconColor: const Color(0xff1E1E1E),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                answer,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff8A8A8A),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
