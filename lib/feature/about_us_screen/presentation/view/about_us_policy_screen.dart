import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../app_section/presentation/view/app_section.dart';
import '../view_model/about_us/about_us_cubit.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final AboutUsCubit aboutUsCubit = serviceLocator<AboutUsCubit>();

  @override
  void initState() {
    super.initState();
    aboutUsCubit.getAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  MainLayout()));
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          LocaleKeys.about_us_title.tr(),
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/svg/back1.png"),fit: BoxFit.cover)
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     AppColors.grey300,
          //     Colors.white,
          //   ],
          // ),
        ),
        child: BlocProvider(
          create: (context) => aboutUsCubit,
          child: BlocConsumer<AboutUsCubit, AboutUsState>(
            listener: (context, state) {
              if (state is AboutUsFailure) {
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.grey500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AboutUsLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: _buildAboutContent(
                      "This is a dummy text for about us section. " * 10),
                );
              } else if (state is AboutUsSuccess) {
                return _buildAboutContent(_getLocalizedAboutText(state));
              } else if (state is AboutUsFailure) {
                return Center(
                  child: Text(
                    LocaleKeys.error_loading_content.tr(),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAboutContent(String htmlData) {
    return Padding(
      padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
      child: Column(
        children: [
          Divider(
            color: AppColors.grey500.withOpacity(0.5),
            thickness: 4,
            radius: BorderRadius.circular(20),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: SingleChildScrollView(
              child: Html(
                data: htmlData,
                style: {
                  'body': Style(
                    color: AppColors.black,
                    fontSize: FontSize(14),
                    fontWeight: FontWeight.normal,
                  ),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getLocalizedAboutText(AboutUsSuccess state) {
    final lang = context.locale.languageCode;
    final body = state.data.data?.body;
    final message = state.data.message;

    switch (lang) {
      case 'ar':
        return body?.ar ?? message?.ar ?? LocaleKeys.no_content.tr();
      case 'en':
        return body?.en ?? message?.en ?? LocaleKeys.no_content.tr();
      default:
        return body?.en ?? LocaleKeys.no_content.tr();
    }
  }
}
