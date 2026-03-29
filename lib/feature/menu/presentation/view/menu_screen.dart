import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/utils/app_shared_preference.dart';
import '../../../../core/utils/custom_text.dart';
import '../../../../generated/locale_keys.g.dart';

class AppDrawer extends StatelessWidget {
  final String? avatarUrl;
  final VoidCallback? onClose;
  final VoidCallback? onSettings;
  final VoidCallback? onContactUs;
  final VoidCallback? onAbout;
  final VoidCallback? onTerms;
  final VoidCallback? onPrivacy;
  final VoidCallback? onLogout;
  final VoidCallback? onBlog;
  final VoidCallback? onServices;
  final VoidCallback? onProduct;
  final VoidCallback? onProjects;


  const AppDrawer({
    super.key,

    this.onSettings,
    this.avatarUrl,
    this.onClose,
    this.onContactUs,
    this.onAbout,
    this.onTerms,
    this.onPrivacy,
    this.onLogout,
    this.onBlog,
    this.onServices,
    this.onProduct,
    this.onProjects,

  });

  @override
  Widget build(BuildContext context) {
    final double drawerWidth = MediaQuery.of(context).size.width * 0.74;

    String userName = '';
    String userEmail = '';
    String image = '';

    final userJson = SharedPreferencesUtils.getData(key: AppValues.user);

    if (userJson != null && userJson is String && userJson.isNotEmpty) {
      try {
        final userMap = jsonDecode(userJson);
        userName = userMap['name'] ?? '';
        userEmail = userMap['email'] ?? '';
        image = userMap['image'] ?? '';
      } catch (e) {
        debugPrint('Error decoding user data: $e');
      }
    }

    return Drawer(
      elevation: 0,
      backgroundColor: Colors.transparent,
      width: drawerWidth,
      child: SafeArea(
        child: Align(
          alignment: Alignment.centerLeft,
          child: ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.blue,
                    AppColors.grey100,

                  ],
                ),
                // boxShadow: const [
                //   BoxShadow(
                //     color: Color(0x22000000),
                //     blurRadius: 12,
                //     offset: Offset(2, 2),
                //   ),
                // ],
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 32, 8, 12),
                      child: CircleAvatar(
                        radius: 34,
                        backgroundImage: (image.isNotEmpty)
                            ? NetworkImage(image)
                            : null,
                        child: (image.isEmpty)
                            ? const Icon(Icons.person,
                            size: 34, color: Color(0xFF6B7280))
                            : null,
                      ),
                    ),
                    CustomText(
                      userName,
                      style:
                      const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    CustomText(
                      userEmail,
                      style:
                       TextStyle(color: AppColors.primary, fontSize: 16),
                    ),
                    const Divider(),


                    _MenuItem(
                      icon: Icons.settings,
                      title: LocaleKeys.drawer_settings.tr(),
                      onTap: () {
                        Navigator.pop(context);
                        onSettings?.call();
                      },
                    ),
                    // _MenuItem(
                    //   icon: Icons.chat_bubble_outline,
                    //   title: LocaleKeys.drawer_contact_us.tr(),
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //     onContactUs?.call();
                    //   },
                    // ),
                    _MenuItem(
                      icon: Icons.info_outline,
                      title: LocaleKeys.drawer_about.tr(),
                      onTap: () {
                        Navigator.pop(context);
                        onAbout?.call();
                      },
                    ),
                    _MenuItem(
                      icon: Icons.description_outlined,
                      title: LocaleKeys.drawer_terms.tr(),
                      onTap: () {
                        Navigator.pop(context);
                        onTerms?.call();
                      },
                    ),
                    _MenuItem(
                      icon: Icons.privacy_tip_outlined,
                      title: LocaleKeys.drawer_privacy.tr(),
                      onTap: () {
                        Navigator.pop(context);
                        onPrivacy?.call();
                      },
                    ),
                    _MenuItem(
                      icon: Icons.insights,
                      title: LocaleKeys.Home_blogs.tr(),
                      onTap: () {
                        Navigator.pop(context);
                        onBlog?.call();
                      },
                    ),
                    _MenuItem(
                      icon: Icons.edit_note,
                      title: LocaleKeys.product_title.tr(),
                      onTap: () {
                        Navigator.pop(context);
                        onProduct?.call();
                      },
                    ),
                    _MenuItem(
                      icon: Icons.credit_card,
                      title: LocaleKeys.general_projects.tr(),
                      onTap: () {
                        Navigator.pop(context);
                        onProjects?.call();
                      },
                    ),  _MenuItem(
                      icon: Icons.miscellaneous_services,
                      title: LocaleKeys.general_services.tr(),
                      onTap: () {
                        Navigator.pop(context);
                        onServices?.call();
                      },
                    ),
                    const SizedBox(height: 6),
                    _MenuItem(
                      icon: Icons.logout_rounded,
                      title: LocaleKeys.drawer_logout.tr(),
                      iconColor: AppColors.primary,
                      textColor: AppColors.primary,
                      onTap: () {
                        Navigator.pop(context);
                        onLogout?.call();
                      },
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? textColor;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconColor ?? const Color(0xFF111827)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? const Color(0xFF111827),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
