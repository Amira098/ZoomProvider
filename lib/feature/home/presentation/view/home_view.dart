import 'package:flutter/material.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../core/utils/utils/customTextField.dart';
import '../../../../generated/locale_keys.g.dart';

import 'cart_screen.dart';
import 'categories.dart';
import 'contract_details_screen.dart';
import 'maintenance_contracts_screen.dart';
import 'product_details_screen.dart';
import 'products_screen.dart';
import 'service_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            ],
          ),
        ),
      ),
    );
  }
}

