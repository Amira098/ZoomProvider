import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utils/custom_text.dart';
import '../../../../generated/locale_keys.g.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          LocaleKeys.ChooseYourLanguage.tr(),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            _buildLanguageCard(
              context: context,
              title: LocaleKeys.English.tr(),
              flag: '🇺🇸',
              isSelected: currentLocale.languageCode == 'en',
              onTap: () {
                context.setLocale(const Locale('en'));
             Navigator.pop(context);
              },
            ),

            const SizedBox(height: 16),

            // 🇸🇦 Arabic
            _buildLanguageCard(
              context: context,
              title: LocaleKeys.Arabic.tr(),
              flag: '🇸🇦',
              isSelected: currentLocale.languageCode == 'ar',
              onTap: () {
                context.setLocale(const Locale('ar'));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required BuildContext context,
    required String title,
    required String flag,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Flag and title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(flag, style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  CustomText(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.blue.shade700 : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // Check icon when selected
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isSelected
                  ? const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.check_circle,
                    color: Colors.blue, size: 22),
              )
                  : const SizedBox(width: 22),
            ),
          ],
        ),
      ),
    );
  }
}
