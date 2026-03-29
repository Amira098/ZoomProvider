import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../app_section/presentation/view/app_section.dart';
import 'change_language_screen.dart';
import 'delete_confirm_dialog.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocaleKeys.setting.tr(),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  MainLayout()));
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Container(height: 8, color: Colors.grey[100]),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
              children: [
                _buildItem(
                  context,
                  icon: Icons.language_outlined,
                  text: LocaleKeys.settings_change_language.tr(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangeLanguageScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 6),
                _buildItem(
                  context,
                  icon: Icons.delete_forever_rounded,
                  text: LocaleKeys.settings_delete_account.tr(),
                  IconColor: AppColors.red,
                  textColor: AppColors.red,
                  onTap: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (_) => const DeleteConfirmDialog(),
                    );
                    if (confirmed == true) {

                      showDialog(
                        context: context,
                        builder: (_) => const DeleteSuccessDialog(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, {
        required IconData icon,
        required String text,
        VoidCallback? onTap,
        Color? textColor,
        Color? IconColor,
      }) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
          ),
          child: Row(
            children: [
              Icon(icon, color: IconColor ?? AppColors.grey700),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor ?? Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.black38),
            ],
          ),
        ),
      ),
    );
  }
}
