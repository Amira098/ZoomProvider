// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart' hide NavigationBar;
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/di/service_locator.dart';
// import '../../../../core/utils/show_pretty_snack.dart';
// import '../../../../generated/locale_keys.g.dart';
// import '../view_model/register/register_cubit.dart';
// import '../view_model/register/register_state.dart';
// import 'login_screen.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmpasswordController =
//   TextEditingController();
//
//   final RegisterCubit registerCubit = serviceLocator<RegisterCubit>();
//
//   bool obscurePassword = true;
//
//   bool obscureConfirmPassword = true;
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _phoneController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmpasswordController.dispose();
//     super.dispose();
//   }
//
//   void _onRegister() {
//     if (_passwordController.text != _confirmpasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(LocaleKeys.Authentication_PasswordNotMatched.tr()),
//         ),
//       );
//       return;
//     }
//
//     registerCubit.register(
//       name: _nameController.text.trim(),
//       phone: _phoneController.text.trim(),
//       email: _emailController.text.trim(),
//       password: _passwordController.text.trim(),
//       confirmPassword: _confirmpasswordController.text.trim(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: BlocProvider(
//         create: (context) => registerCubit,
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("assets/svg/backgrawend.png"),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: SafeArea(
//             child: BlocConsumer<RegisterCubit, RegisterState>(
//               listener: (context, state) {
//                 if (state is RegisterSuccess) {
//                   showPrettySnack(
//                     context,
//                     success: true,
//                     state.registerModel.message?.toString() ??
//                         LocaleKeys.Authentication_CreateAccount.tr(),
//                   );
//
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (_) => const LoginScreen()),
//                   );
//                 }
//
//                 if (state is RegisterFailure) {
//                   showPrettySnack(
//                     context,
//                     success: false,
//                     state.apiError?.errors?.toString() ??
//                         state.exception?.toString() ??
//                         LocaleKeys.Authentication_RegistrationFailed.tr(),
//                   );
//                 }
//               },
//               builder: (context, state) {
//                 return SingleChildScrollView(
//                   padding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: MediaQuery.of(context).size.height - 30,
//                     ),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 12),
//
//                         Center(
//                           child: Image.asset(
//                             "assets/svg/zoomLogo.png",
//                             width: 180,
//                             height: 180,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//
//                         const SizedBox(height: 8),
//
//                         const Text(
//                           "Create an Account",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700,
//                             color: Colors.black,
//                           ),
//                         ),
//
//                         const SizedBox(height: 18),
//
//                         Row(
//                           children: [
//                             Expanded(
//                               child: InkWell(
//                                 borderRadius: BorderRadius.circular(30),
//                                 onTap: () {
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (_) => const LoginScreen(),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   height: 48,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(.65),
//                                     borderRadius: BorderRadius.circular(30),
//                                     border: Border.all(
//                                       color: const Color(0xFFCFCFCF),
//                                       width: 1,
//                                     ),
//                                   ),
//                                   alignment: Alignment.center,
//                                   child: const Text(
//                                     "Login",
//                                     style: TextStyle(
//                                       color: Colors.black87,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: Container(
//                                 height: 48,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFFF1E28),
//                                   borderRadius: BorderRadius.circular(30),
//                                 ),
//                                 alignment: Alignment.center,
//                                 child: const Text(
//                                   "Sign Up",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(height: 12),
//
//                         _buildLabeledField(
//                           label: "Full Name",
//                           child: _roundedTextField(
//                             controller: _nameController,
//                             keyboardType: TextInputType.name,
//                             hintText: "Abhishek Patel",
//                           ),
//                         ),
//
//                         const SizedBox(height: 10),
//
//                         _buildLabeledField(
//                           label: "Email Address",
//                           child: _roundedTextField(
//                             controller: _emailController,
//                             keyboardType: TextInputType.emailAddress,
//                             hintText: "abhishekkpatelXXX@gmail.com",
//                           ),
//                         ),
//
//                         const SizedBox(height: 10),
//
//                         _buildLabeledField(
//                           label: "Phone Number",
//                           child: _roundedTextField(
//                             controller: _phoneController,
//                             keyboardType: TextInputType.phone,
//                             hintText: "+33 2 94 27 84 11",
//                           ),
//                         ),
//
//                         const SizedBox(height: 10),
//
//                         _buildLabeledField(
//                           label: "Password",
//                           child: _roundedTextField(
//                             controller: _passwordController,
//                             keyboardType: TextInputType.visiblePassword,
//                             hintText: "********",
//                             obscureText: obscurePassword,
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   obscurePassword = !obscurePassword;
//                                 });
//                               },
//                               icon: Icon(
//                                 obscurePassword
//                                     ? Icons.visibility_off_outlined
//                                     : Icons.visibility_outlined,
//                                 color: Colors.black54,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ),const SizedBox(height: 10),
//
//                         _buildLabeledField(
//                           label: "Confirm Password",
//                           child: _roundedTextField(
//                             controller: _confirmpasswordController,
//                             keyboardType: TextInputType.visiblePassword,
//                             hintText: "********",
//                             obscureText: obscureConfirmPassword,
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   obscureConfirmPassword = !obscureConfirmPassword;
//                                 });
//                               },
//                               icon: Icon(
//                                 obscureConfirmPassword
//                                     ? Icons.visibility_off_outlined
//                                     : Icons.visibility_outlined,
//                                 color: Colors.black54,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 22),
//
//                         state is RegisterLoading
//                             ? const CircularProgressIndicator()
//                             : SizedBox(
//                           width: double.infinity,
//                           height: 52,
//                           child: ElevatedButton(
//                             onPressed: _onRegister,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFFFF1E28),
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                               ),
//                             ),
//                             child: const Text(
//                               "Sign Up",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 16),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLabeledField({
//     required String label,
//     required Widget child,
//   }) {
//     return Column(
//       children: [
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 18),
//             child: Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 15,
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 6),
//         child,
//       ],
//     );
//   }
//
//   Widget _roundedTextField({
//     required TextEditingController controller,
//     required TextInputType keyboardType,
//     required String hintText,
//     bool obscureText = false,
//     Widget? suffixIcon,
//   }) {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(.28),
//         borderRadius: BorderRadius.circular(30),
//         border: Border.all(
//           color: const Color(0xFFBDBDBD),
//           width: 1.2,
//         ),
//       ),
//       alignment: Alignment.center,
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         obscureText: obscureText,
//         style: const TextStyle(
//           fontSize: 14,
//           color: Colors.black,
//         ),
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: const TextStyle(
//             color: Colors.black38,
//             fontSize: 13,
//           ),
//           suffixIcon: suffixIcon,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 18,
//             vertical: 14,
//           ),
//           border: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }