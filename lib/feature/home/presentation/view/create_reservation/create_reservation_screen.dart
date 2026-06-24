import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/utils/show_pretty_snack.dart';
import '../../../../../core/utils/pick_localized_dyn.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../data/model/create_patient_model.dart';
import '../../view_model/create_reservation/create_reservation_cubit.dart';
import '../../view_model/create_reservation/create_reservation_state.dart';
import '../create_patient/create_patient_screen.dart';

class CreateReservationScreen extends StatefulWidget {
  const CreateReservationScreen({super.key});

  @override
  State<CreateReservationScreen> createState() => _CreateReservationScreenState();
}

class _CreateReservationScreenState extends State<CreateReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  PatientDataModel? _selectedPatient;

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final now = DateTime.now();
        final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        _timeController.text = DateFormat('HH:mm').format(dt);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<CreateReservationCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "إضافة حجز جديد",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocListener<CreateReservationCubit, CreateReservationState>(
          listener: (context, state) {
            if (state is CreateReservationSuccess) {
              showPrettySnack(
                context,
                context.getLocalizedMessage(state.createReservationModel.message),
                success: true,
              );
              Navigator.pop(context);
            } else if (state is CreateReservationFailure) {
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
                    "بيانات الحجز",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreatePatientScreen(),
                        ),
                      );
                      if (result is PatientDataModel) {
                        setState(() {
                          _selectedPatient = result;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person, color: Colors.grey),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              _selectedPatient?.name ?? "اختر المريض أو أضف جديداً",
                              style: TextStyle(
                                color: _selectedPatient == null
                                    ? Colors.grey
                                    : Colors.black,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  if (_selectedPatient == null)
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, right: 15.w),
                      child: Text(
                        "يرجى اختيار مريض",
                        style: TextStyle(color: Colors.red, fontSize: 12.sp),
                      ),
                    ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: InputDecoration(
                      labelText: "التاريخ",
                      hintText: "اختر التاريخ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "يرجى اختيار التاريخ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _timeController,
                    readOnly: true,
                    onTap: () => _selectTime(context),
                    decoration: InputDecoration(
                      labelText: "الوقت",
                      hintText: "اختر الوقت",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      prefixIcon: const Icon(Icons.access_time),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "يرجى اختيار الوقت";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40.h),
                  BlocBuilder<CreateReservationCubit, CreateReservationState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is CreateReservationLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate() &&
                                    _selectedPatient != null) {
                                  context
                                      .read<CreateReservationCubit>()
                                      .createReservation(
                                        _selectedPatient!.id!,
                                        _dateController.text,
                                        _timeController.text,
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
                        child: state is CreateReservationLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "إضافة الحجز",
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
