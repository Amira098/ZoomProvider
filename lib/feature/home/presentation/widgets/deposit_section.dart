import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../generated/locale_keys.g.dart';

class DepositSection extends StatelessWidget {
  final String? selectedDepositAccountType;
  final XFile? depositReceipt;
  final List<Map<String, String>> depositAccountOptions;
  final Function(String?) onAccountTypeChanged;
  final VoidCallback onPickReceipt;
  final VoidCallback onRemoveReceipt;

  const DepositSection({
    super.key,
    required this.selectedDepositAccountType,
    required this.depositReceipt,
    required this.depositAccountOptions,
    required this.onAccountTypeChanged,
    required this.onPickReceipt,
    required this.onRemoveReceipt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDepositAccountTypeDropdown(),
        const SizedBox(height: 16),
        _buildReceiptPicker(),
      ],
    );
  }

  Widget _buildDepositAccountTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            LocaleKeys.status_update_transfer_type.tr(),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedDepositAccountType,
              hint: Text(
                LocaleKeys.status_update_select_deposit_account_type.tr(),
                style: const TextStyle(fontSize: 15),
              ),
              items: depositAccountOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option['value'],
                  child: Text(
                    option['label']!.tr(),
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              }).toList(),
              onChanged: onAccountTypeChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptPicker() {
    final hasReceipt = depositReceipt != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            LocaleKeys.status_update_deposit_receipt.tr(),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onPickReceipt,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: hasReceipt
                    ? AppColors.accentRed.withOpacity(0.5)
                    : Colors.grey.withOpacity(0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  hasReceipt ? Icons.check_circle : Icons.upload_file,
                  color: hasReceipt ? Colors.green : AppColors.accentRed,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    hasReceipt
                        ? depositReceipt!.name
                        : LocaleKeys.status_update_upload_deposit_receipt.tr(),
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight:
                          hasReceipt ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                if (hasReceipt)
                  IconButton(
                    onPressed: onRemoveReceipt,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
