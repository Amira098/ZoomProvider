// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
//
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/utils/custom_text.dart';
// import '../../../../generated/locale_keys.g.dart';
// import '../view/new_password.dart' show NewPasswordScreen;
//
// class OTPDialog extends StatelessWidget {
//   const OTPDialog({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: 48,
//       height: 48,
//       textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
//         color: AppColors.tealDark,
//         fontSize: 26,
//       ),
//       decoration: BoxDecoration(
//         border: Border.all(color:AppColors.tealDark),
//         borderRadius: BorderRadius.circular(6),
//       ),
//     );
//
//     return Dialog(
//       backgroundColor: AppColors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(60),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(LocaleKeys.sanad_ForgetPassword.tr(), style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize:20 )),
//             const SizedBox(height: 18),
//             Text(LocaleKeys.sanad_OtpSentToEmail.tr(),
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize:16 ),
//             ),
//             const SizedBox(height: 34),
//               Pinput(
//               length: 4,
//               defaultPinTheme: defaultPinTheme,
//               onCompleted: (pin) {
//                 print('${LocaleKeys.sanad_EnteredOTP.tr()}: $pin');
//               },
//             ),
//
//             const SizedBox(height: 8),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const NewPasswordScreen(),
//                   ),
//                 );
//               },
//               child:  CustomText(
//                 LocaleKeys.sanad_ResendOTP.tr(),
//                 style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                   fontSize: 14,fontWeight: FontWeight.w500
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
