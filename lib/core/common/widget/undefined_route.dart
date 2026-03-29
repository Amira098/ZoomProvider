import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';

class UndefinedRoute extends StatelessWidget {
  const UndefinedRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.general_no_route_found.tr())),
      body: Center(child: Text(LocaleKeys.general_no_route_found.tr())),
    );
  }
}
