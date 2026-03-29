import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../generated/locale_keys.g.dart';
import '../auth/presentation/view/login_screen.dart';

class IntroView2 extends StatefulWidget {
  const IntroView2({super.key});

  @override
  State<IntroView2> createState() => _IntroView2State();
}

class _IntroView2State extends State<IntroView2> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/svg/intro.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.intro_title.tr(),
                  style: TextStyle(color:AppColors.green , fontSize: 24),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8),
                Text(
                  LocaleKeys.intro_description.tr(),
                  style: const TextStyle(color: Colors.white,fontSize: 18),
                  textAlign: TextAlign.start,

                ),
                const SizedBox(height: 40),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
