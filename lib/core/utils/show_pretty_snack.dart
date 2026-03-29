import 'package:flutter/material.dart';

void showPrettySnack(
    BuildContext context,
    String message, {
      bool success = true,
    }) {
  final Color accent = success ? const Color(0xFF12B76A) : const Color(0xFFEF4444);
  final IconData icon = success ? Icons.check_circle_rounded : Icons.error_rounded;

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: accent.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                offset: const Offset(0, 8),
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: accent, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.close_rounded, size: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}
