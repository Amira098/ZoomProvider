import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/routes/routes.dart';
import '../../core/utils/custom_text.dart';
import '../../generated/locale_keys.g.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/svg/intro.png"),
            fit: BoxFit.cover,

          ),
        ),
        child: Column(
          children: [
            const Spacer(
              flex: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.white.withOpacity(0.55),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.35),
                        width: 1.2,
                      ),
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          LocaleKeys.ChooseYourLanguage.tr(),
                          style:  TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:  AppColors.black),
                        ),
                        const SizedBox(height: 20),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(180, 50),
                                backgroundColor: currentLocale.languageCode == 'en'
                                    ? AppColors.primary
                                    : Colors.white,

                              ),
                              onPressed: () {
                                context.setLocale(const Locale('en'));
                                Navigator.pushReplacementNamed(context, Routes.introView);
                              },
                              child: CustomText(
                                LocaleKeys.English.tr(),
                                style: TextStyle(
                                  color: currentLocale.languageCode == 'en'
                                      ? Colors.white
                                      :  AppColors.primary,
                                ),
                              ),
                            ),

                            const SizedBox(width: 10),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(180, 50),
                                backgroundColor: currentLocale.languageCode == 'ar'
                                    ? AppColors.primary
                                    : Colors.white,

                              ),
                              onPressed: () {
                                context.setLocale(const Locale('ar'));
                                Navigator.pushReplacementNamed(context, Routes.introView);
                              },
                              child: CustomText(
                                LocaleKeys.Arabic.tr(),
                                style: TextStyle(
                                  color: currentLocale.languageCode == 'ar'
                                      ? Colors.white
                                      :  AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
