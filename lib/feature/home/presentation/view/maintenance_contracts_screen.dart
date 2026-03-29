import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';

import 'contract_details_screen.dart';

class MaintenanceContractsScreen extends StatelessWidget {
  const MaintenanceContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1B1D27),
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              height: 92,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    LocaleKeys.Home_maintenance_contracts.tr(),
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
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(18),
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContractDetailsScreen(),
                        ),
                      );
                    },
                    child: _MaintenanceListItem(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MaintenanceListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xffF3212D).withOpacity(0.3)),
          image: const DecorationImage(
            image: AssetImage('assets/svg/backgrawend.png'),
            opacity: 0.05,
            fit: BoxFit.cover,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.Home_basic_care.tr(),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xff1E1E1E))),
          const SizedBox(height: 8),
          Text(LocaleKeys.Home_basic_care_desc.tr(),
              style: const TextStyle(
                  fontSize: 12, color: Color(0xff8A8A8A), height: 1.4)),
          const SizedBox(height: 16),
          _bulletPoint("Basic system check"),
          _bulletPoint("Filter candle replacement"),
          _bulletPoint("2 visits / year"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("OMR 50 ${LocaleKeys.Home_per_year.tr()}",
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffF3212D))),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                    color: const Color(0xffF3212D),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(LocaleKeys.Home_subscribe.tr(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                  color: Colors.black, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(text,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff1E1E1E))),
        ],
      ),
    );
  }
}
