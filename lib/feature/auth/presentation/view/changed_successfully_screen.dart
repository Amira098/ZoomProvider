
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
              SvgPicture.asset(
                "assets/svg/check_circle.svg",
                width: 200.w,
                height: 200.h,
                color: Colors.green,
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  LocaleKeys.Authentication_PasswordChangedSuccessfully.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.sp,
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
