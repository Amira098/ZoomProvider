import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/common/widget/tools_pattern_painter.dart';
import '../../../../generated/locale_keys.g.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isEmpty = false; // Toggle this to test both states

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
                    LocaleKeys.cart_title.tr(),
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
              child: Stack(
                children: [

                  isEmpty ? _buildEmptyCart() : _buildPopulatedCart(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/svg/No Product.png"))
                ),
              ),
         
            ],
          ),
          const SizedBox(height: 24),
          Text(
            LocaleKeys.cart_no_services.tr(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopulatedCart() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xffE2E2E2)),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/svg/candle_change.png',
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.close, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.Home_candle_change.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff1E1E1E),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Text(
                        "Qui rerum voluptas qui laboriosam\nDebitis numquam doloribus.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff8A8A8A),
                          height: 1.4,
                        ),
                      ),
                    ),
                    Text(
                      "OMR 50",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xffF3212D),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xffE2E2E2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Color(0xffF3212D)),
                const SizedBox(width: 12),
                Text(
                  LocaleKeys.cart_enter_location.tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xffC4C4C4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: _buildPaymentMethod(Icons.credit_card, LocaleKeys.cart_online_payment.tr(), true)),
              const SizedBox(width: 16),
              Expanded(child: _buildPaymentMethod(Icons.account_balance_wallet_outlined, LocaleKeys.cart_cash.tr(), false)),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xffF3212D),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Center(
              child: Text(
                LocaleKeys.cart_checkout.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethod(IconData icon, String title, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xffF3212D).withOpacity(0.3) : const Color(0xffE2E2E2),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xff4CAF50) : Colors.transparent,
                border: Border.all(color: isSelected ? Colors.transparent : const Color(0xffE2E2E2)),
              ),
              child: isSelected ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
            ),
          ),
          Icon(icon, size: 32, color: isSelected ? Colors.black87 : const Color(0xffC4C4C4)),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.black87 : const Color(0xffC4C4C4),
            ),
          ),
        ],
      ),
    );
  }
}
