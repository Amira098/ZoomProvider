import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_shared_preference.dart';
import '../../../../core/utils/pick_localized_dyn.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../../core/utils/show_pretty_snack.dart';
import '../view_model/contact_us_cubit/contact_us_cubit.dart';
import '../view_model/contact_us_cubit/contact_us_state.dart';

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
    _cubit.getContactDetails();
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

  Widget _buildContactForm() {
    return Column(
      children: [
        TextFormField(
          controller: _subjectController,
          decoration: InputDecoration(
            labelText: LocaleKeys.contactus_subject.tr(),
            hintText: LocaleKeys.contactus_subject.tr(),
            disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)) ,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(22.r),borderSide: BorderSide(color:AppColors.primary )),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.general_required.tr();
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: LocaleKeys.contactus_fullname.tr(),
            disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)) ,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(22.r),borderSide: BorderSide(color:AppColors.primary )),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.general_required.tr();
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: LocaleKeys.contactus_email.tr(),

            disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)) ,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(22.r),borderSide: BorderSide(color:AppColors.primary )),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.general_required.tr();
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: LocaleKeys.contactus_phone.tr(),

            disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)) ,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(22.r),borderSide: BorderSide(color:AppColors.primary )),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.general_required.tr();
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),
        TextFormField(
          controller: _messageController,
          maxLines: 5,
          decoration: InputDecoration(

            labelText: LocaleKeys.contactus_message.tr(),
            hintText: LocaleKeys.contactus_message.tr(),
            disabledBorder:OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)) ,
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(22.r),borderSide: BorderSide(color:AppColors.primary )),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return LocaleKeys.general_required.tr();
            }
            return null;
          },
        ),
        SizedBox(height: 24.h),
        BlocBuilder<ContactUsCubit, ContactUsState>(
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: state is ContactUsLoading
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          _cubit.contactUs(
                            name: _nameController.text,
                            email: _emailController.text,
                            message: _messageController.text,
                            subject: _subjectController.text,
                            phoneNumber: _phoneController.text,
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF3212D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: state is ContactUsLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        LocaleKeys.contactus_send.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            );
          },
        ),
      ],
    );
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    LocaleKeys.contactus_title.tr(),
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
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Stack(
                children: [
                  BlocProvider(
                    create: (_) => _cubit,
                    child: BlocListener<ContactUsCubit, ContactUsState>(
                      listener: (context, state) {
                        if (state is ContactUsSuccess) {
                          showPrettySnack(
                            context,
                            pickLocalizedDyn(state.message, context.locale.languageCode == 'ar') ??
                                (context.locale.languageCode == 'ar' ? 'تم إرسال الرسالة بنجاح' : 'Message sent successfully'),
                            success: true,
                          );
                          _subjectController.clear();
                          _messageController.clear();
                        } else if (state is ContactUsFailure) {
                          showPrettySnack(context, state.error, success: false);
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(vertical: 24.h),
                            child: Column(
                              children: [
                                BlocBuilder<ContactUsCubit, ContactUsState>(
                                  buildWhen: (previous, current) =>
                                      current is ContactDetailsLoading ||
                                      current is ContactDetailsSuccess ||
                                      current is ContactDetailsFailure,
                                builder: (context, state) {
                                  String email = '...';
                                  String phone = '...';

                                  if (state is ContactDetailsSuccess) {
                                    email = state.email;
                                    phone = state.number;
                                  }

                                  return GridView.count(
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
                                        title: LocaleKeys.contactus_email.tr(),
                                        subtitle: email,
                                        onTap: () async {
                                          if (email.isNotEmpty && email != '...') {
                                            final Uri emailLaunchUri = Uri(
                                              scheme: 'mailto',
                                              path: email,
                                            );
                                            if (await canLaunchUrl(emailLaunchUri)) {
                                              await launchUrl(emailLaunchUri);
                                            }
                                          }
                                        },
                                      ),
                                      _ContactCard(
                                        icon: Icons.phone_in_talk_rounded,
                                        iconColor: const Color(0xffF3212D),
                                        bgColor: const Color(0xffFDEDEE),
                                        title: "call center",
                                        subtitle: phone,
                                        onTap: () async {
                                          if (phone.isNotEmpty && phone != '...') {
                                            final Uri phoneLaunchUri = Uri(
                                              scheme: 'tel',
                                              path: phone,
                                            );
                                            if (await canLaunchUrl(phoneLaunchUri)) {
                                              await launchUrl(phoneLaunchUri);
                                            }
                                          }
                                        },
                                      ),
                                      // _ContactCard(
                                      //   icon: Icons.help_rounded,
                                      //   iconColor: const Color(0xffF1C40F),
                                      //   bgColor: const Color(0xffFEF9E7),
                                      //   title: LocaleKeys.faq_header.tr(),
                                      //   subtitle: LocaleKeys.contactus_answers.tr(args: ['+50']),
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(builder: (context) => const FaqScreen()),
                                      //     );
                                      //   },
                                      // ),
                                    ],
                                  );
                                },
                              ),
                                // SizedBox(height: 24.h),
                                // _buildContactForm(),
                                SizedBox(height: 30.h),
                              ],
                            ),
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
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12.r,
              offset: Offset(0.w, 4.h),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w800,
                color: Color(0xff1E1E1E),
              ),
            ),
            if (subtitle != null) ...[
              SizedBox(height: 4.h),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
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
