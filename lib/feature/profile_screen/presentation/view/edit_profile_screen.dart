import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_shared_preference.dart';
import '../../../../core/utils/pick_localized_dyn.dart';
import '../../../../core/utils/show_pretty_snack.dart';
import '../../../../core/utils/utils/customTextField.dart';
import '../../../../generated/locale_keys.g.dart';
import '../view_model/profile_update_cubit.dart';
import '../view_model/profile_update_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _saving = false;
  String userName = '';
  String userEmail = '';
  String phone = '';
  String address = '';
  String password = '';
  String image = '';


  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _passCtrl;
  late final TextEditingController _addressCtrl;

  final ProfileUpdateCubit _profileUpdateCubit = serviceLocator<ProfileUpdateCubit>();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _passCtrl = TextEditingController();
    _addressCtrl = TextEditingController();
    _readPrefsIntoState();
  }

  Future<void> _readPrefsIntoState() async {
    try {
      final raw = SharedPreferencesUtils.getData(key: AppValues.user);
      if (raw is String && raw.isNotEmpty) {
        final map = jsonDecode(raw) as Map<String, dynamic>;
        final inner = (map['data'] is Map) ? Map<String, dynamic>.from(map['data']) : map;
        image = (inner['image'] ?? inner['avatar'] ?? '').toString();
        userName = (inner['name'] ?? '').toString();
        userEmail = (inner['email'] ?? '').toString();
        phone = (inner['phone'] ?? '').toString();
        address = (inner['address'] ?? '').toString();
        password = (inner['password'] ?? '').toString();

        _nameCtrl.text = userName;
        _emailCtrl.text = userEmail;
        _phoneCtrl.text = phone;
        _passCtrl.text = password;

        if (mounted) setState(() {});
      }
    } catch (e) {
      debugPrint('read prefs error: $e');
    }
  }

  Future<void> _writeFormToPrefs() async {
    try {
      Map<String, dynamic> existing = {};
      final raw = SharedPreferencesUtils.getData(key: AppValues.user);
      if (raw is String && raw.isNotEmpty) {
        try {
          existing = Map<String, dynamic>.from(jsonDecode(raw));
        } catch (_) {}
      }
      final merged = {
        ...existing,
        'name': _nameCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'phone': _phoneCtrl.text.trim(),
        'password': _passCtrl.text,
        'address': _addressCtrl.text.trim(),
      };
      await SharedPreferencesUtils.saveData(
        key: AppValues.user,
        value: jsonEncode(merged),
      );
    } catch (e) {
      debugPrint('write prefs error: $e');
    }
  }

  Future<void> _save() async {
    HapticFeedback.lightImpact();
    setState(() => _saving = true);
    await _writeFormToPrefs();
    _profileUpdateCubit.updateProfile(
      name: _nameCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      image: image,
      address: _addressCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileUpdateCubit,
      child: Scaffold(
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
                      LocaleKeys.profile_personal_data.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Stack(
                  children: [

                    BlocConsumer<ProfileUpdateCubit, ProfileUpdateState>(
                      listener: (context, state) async {
                        if (state is ProfileUpdateSuccess) {
                          await _writeFormToPrefs();
                          await _readPrefsIntoState();
                          if (!mounted) return;
                          setState(() => _saving = false);
                          showPrettySnack(
                            context,
                            context.getLocalizedMessage(state.profileData.message),
                          );
                        } else if (state is ProfileUpdateFailure) {
                          if (!mounted) return;
                          setState(() => _saving = false);
                          showPrettySnack(
                            context,
                            state.apiError?.getLocalizedMessage(context) ??
                                LocaleKeys.error_SomethingWentWrong.tr(),
                            success: false,
                          );
                        }
                      },
                      builder: (context, state) {
                        final isLoading = (state is ProfileUpdateLoading) || _saving;

                        return SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(24, 40, 24, 120),
                          child: Column(
                            children: [
                              CommonTextFormField(
                                label: LocaleKeys.contactus_fullname.tr(),
                                hint: "Abhishek Patel",
                                controller: _nameCtrl,
                              ),
                              const SizedBox(height: 24),
                              CommonTextFormField(
                                label: LocaleKeys.contactus_email.tr(),
                                hint: "abhishekpatelXXX@gmail.com",
                                controller: _emailCtrl,
                                textInputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 24),
                              CommonTextFormField(
                                label: LocaleKeys.contactus_phone.tr(),
                                hint: "+33 2 94 27 84 11",
                                controller: _phoneCtrl,
                                textInputType: TextInputType.phone,
                              ),
                              // const SizedBox(height: 24),
                              // CommonTextFormField(
                              //   label: LocaleKeys.profile_address.tr(),
                              //   hint: "ادخل العنوان بالتفصيل",
                              //   controller: _addressCtrl,
                              //   textInputType: TextInputType.streetAddress,
                              //   maxLines: 2,
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                        color: Colors.transparent,
                        child: SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: _saving ? null : _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF3212D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: _saving
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                              LocaleKeys.Profile_Update.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
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
      ),
    );
  }


}
