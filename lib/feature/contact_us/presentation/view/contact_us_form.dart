import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_shared_preference.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../../core/utils/utils/customTextField.dart';
import '../../../../generated/locale_keys.g.dart';
import '../view_model/contact_us_cubit/contact_us_cubit.dart';
import '../view_model/contact_us_cubit/contact_us_state.dart';
import 'faq_screen.dart';
import 'glass_faq_section.dart';

class ContactUsForm extends StatefulWidget {
  const ContactUsForm({super.key});

  @override
  State<ContactUsForm> createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final ContactUsCubit _cubit = serviceLocator<ContactUsCubit>();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final userJson = SharedPreferencesUtils.getData(key: AppValues.user);
    if (userJson != null && userJson is String && userJson.isNotEmpty) {
      try {
        final userMap = jsonDecode(userJson);
        _nameController.text = userMap['name'] ?? '';
        _emailController.text = userMap['email'] ?? '';
        _phoneController.text = userMap['phone'] ?? '';
      } catch (e) {
        debugPrint('Error decoding user data: $e');
      }
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
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
                    LocaleKeys.contactus_title.tr(),
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
                    create: (_) => _cubit,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Column(
                            children: [
                              // ================= Contact Cards =================
                              GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.9,
                                children: [
                                  _ContactCard(
                                    icon: Icons.email_rounded,
                                    iconColor: const Color(0xff8E44AD),
                                    bgColor: const Color(0xffF5EEF8),
                                    title: 'Email',
                                    subtitle: 'admin@zoom.com',
                                    onTap: () {},
                                  ),
                                  _ContactCard(
                                    icon: Icons.phone_in_talk_rounded,
                                    iconColor: const Color(0xffF3212D),
                                    bgColor: const Color(0xffFDEDEE),
                                    title: 'Call Center',
                                    onTap: () {},
                                  ),

                                ],
                              ),
                              const SizedBox(height: 24),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 24, horizontal: 18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    CommonTextFormField(
                                      fillColor: const Color(0xffF8F8F8),
                                      controller: _subjectController,
                                      hint: LocaleKeys.contactus_subject.tr(),
                                      prefixIcon: const Icon(Icons.subject_rounded),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CommonTextFormField(
                                            fillColor: const Color(0xffF8F8F8),
                                            controller: _nameController,
                                            hint: LocaleKeys.contactus_fullname.tr(),
                                            prefixIcon: const Icon(Icons.person_outline_rounded),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: CommonTextFormField(
                                            fillColor: const Color(0xffF8F8F8),
                                            controller: _emailController,
                                            hint: LocaleKeys.contactus_email.tr(),
                                            prefixIcon: const Icon(Icons.email_outlined),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    CommonTextFormField(
                                      fillColor: const Color(0xffF8F8F8),
                                      controller: _phoneController,
                                      hint: LocaleKeys.contactus_phone.tr(),
                                      prefixIcon: const Icon(Icons.phone_outlined),
                                    ),
                                    const SizedBox(height: 12),
                                    CommonTextFormField(
                                      fillColor: const Color(0xffF8F8F8),
                                      controller: _messageController,
                                      hint: LocaleKeys.contactus_message.tr(),
                                      maxLines: 6,
                                    ),
                                    const SizedBox(height: 30),
                                    BlocConsumer<ContactUsCubit, ContactUsState>(
                                      listener: (context, state) {
                                        if (state is ContactUsSuccess) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                LocaleKeys.contactus_success.tr(),
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                          _messageController.clear();
                                          _subjectController.clear();
                                        } else if (state is ContactUsFailure) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                LocaleKeys.contactus_failure.tr(),
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is ContactUsLoading) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return CustomButton(
                                          btnColor: AppColors.primary,
                                          btnWidth: double.infinity,
                                          btnHeight: 56,
                                          text: LocaleKeys.contactus_send.tr(),
                                          styleFromTheme: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                          onTap: () {
                                            if (formKey.currentState!.validate()) {
                                              _cubit.contactUs(
                                                subject: _subjectController.text,
                                                name: _nameController.text,
                                                email: _emailController.text,
                                                phoneNumber: _phoneController.text,
                                                message: _messageController.text,
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),

                              const SizedBox(height: 30),
                            ],
                          ),
                        ),
                      ),
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
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Color(0xff1E1E1E),
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff8A8A8A),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
