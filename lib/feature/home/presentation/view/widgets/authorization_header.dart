import 'package:flutter/material.dart';

class AuthorizationHeader extends StatelessWidget {
  final String id;
  final String status;
  final Color headerColor;
  final Color textColor;

  const AuthorizationHeader({
    super.key,
    required this.id,
    required this.status,
    this.headerColor = const Color(0xFFD9E9FF),
    this.textColor = const Color(0xFF4A90E2),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Disbursement authorization $id',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 10,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
