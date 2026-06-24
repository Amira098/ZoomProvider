import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/utils/show_pretty_snack.dart';
import '../../../../../core/utils/pick_localized_dyn.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../view_model/create_patient/create_patient_cubit.dart';
import '../../view_model/create_patient/create_patient_state.dart';

class CreatePatientScreen extends StatefulWidget {
  const CreatePatientScreen({super.key});

  @override
  State<CreatePatientScreen> createState() => _CreatePatientScreenState();
}

class _CreatePatientScreenState extends State<CreatePatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<CreatePatientCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "إضافة مريض جديد", // I will add this to translations later if needed, for now I'll use the provided text style
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocListener<CreatePatientCubit, CreatePatientState>(
          listener: (context, state) {
            if (state is CreatePatientSuccess) {
              showPrettySnack(
                context,
                context.getLocalizedMessage(state.createPatientModel.message),
                success: true,
              );
              Navigator.pop(context, state.createPatientModel.data);
            } else if (state is CreatePatientFailure) {
              showPrettySnack(
                context,
                state.apiError?.message?.toString() ??
                    LocaleKeys.error_SomethingWentWrong.tr(),
                success: false,
              );
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "بيانات المريض",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.Authentication_full_name.tr(),
                      hintText: LocaleKeys.Authentication_full_name_hint.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.Error_NameCannotBeEmpty.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.Authentication_phone_number.tr(),
                      hintText: LocaleKeys.Authentication_phone_hint.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.Error_PhoneNumberCannotBeEmpty.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40.h),
                  BlocBuilder<CreatePatientCubit, CreatePatientState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is CreatePatientLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<CreatePatientCubit>().createPatient(
                                        _nameController.text,
                                        _phoneController.text,
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: state is CreatePatientLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "إضافة المريض",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
