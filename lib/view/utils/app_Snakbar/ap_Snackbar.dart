import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackType { success, error, warning, info }

class AppSnackbar {
  static void show({
    required String message,
    SnackType type = SnackType.info,
    String? title,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();

    final config = _getConfig(type);

    Get.showSnackbar(
      GetSnackBar(
        titleText: title != null
            ? Row(
                children: [
                  Icon(config.icon, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            : null,
        messageText: Row(
          children: [
            if (title == null) ...[
              Icon(config.icon, color: Colors.white, size: 18),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.5,
                  fontWeight: title == null
                      ? FontWeight.w500
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: config.color,
        borderRadius: 14,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        duration: duration,
        snackPosition: SnackPosition.TOP,
        animationDuration: const Duration(milliseconds: 400),
        forwardAnimationCurve: Curves.easeOutCubic,
        reverseAnimationCurve: Curves.easeInCubic,
        boxShadows: [
          BoxShadow(
            color: config.color.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        leftBarIndicatorColor: Colors.white.withOpacity(0.5),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }

  static void success(String message, {String? title}) => show(
    message: message,
    type: SnackType.success,
    title: title ?? "Success",
  );

  static void error(String message, {String? title}) =>
      show(message: message, type: SnackType.error, title: title ?? "Error");

  static void warning(String message, {String? title}) => show(
    message: message,
    type: SnackType.warning,
    title: title ?? "Warning",
  );

  static void info(String message, {String? title}) =>
      show(message: message, type: SnackType.info, title: title ?? "Info");

  static _SnackConfig _getConfig(SnackType type) {
    switch (type) {
      case SnackType.success:
        return _SnackConfig(
          color: const Color(0xFF2E7D32),
          icon: Icons.check_circle_rounded,
        );
      case SnackType.error:
        return _SnackConfig(
          color: const Color(0xFFC62828),
          icon: Icons.error_rounded,
        );
      case SnackType.warning:
        return _SnackConfig(
          color: const Color(0xFFE65100),
          icon: Icons.warning_rounded,
        );
      case SnackType.info:
        return _SnackConfig(
          color: const Color(0xFF1565C0),
          icon: Icons.info_rounded,
        );
    }
  }
}

class _SnackConfig {
  final Color color;
  final IconData icon;
  _SnackConfig({required this.color, required this.icon});
}
