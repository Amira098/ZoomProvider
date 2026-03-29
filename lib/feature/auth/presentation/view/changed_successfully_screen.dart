
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../generated/locale_keys.g.dart';
import 'login_screen.dart';

class ChangedSuccessfullyScreen extends StatefulWidget {
  const ChangedSuccessfullyScreen({super.key});

  @override
  State<ChangedSuccessfullyScreen> createState() => _ChangedSuccessfullyScreenState();
}

class _ChangedSuccessfullyScreenState extends State<ChangedSuccessfullyScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/svg/backgrawend.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                LottieAsset.checkmark,
                height: 200,
                width: 200,
                repeat: false,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  LocaleKeys.Authentication_PasswordChangedSuccessfully.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
