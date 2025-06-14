import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

enum ToastType { success, error, warning, info }

class ToastHelper {
  static void showToast({
    required BuildContext context,
    required String message,
    required ToastType toastType,
  }) {
    // Define styles and colors based on type
    final toastConfig = _getToastConfig(toastType);

    toastification.show(
      context: context,
      type: toastConfig['type'] as ToastificationType,
      style: ToastificationStyle.minimal,
      autoCloseDuration: const Duration(seconds: 4),
      title: Text(toastConfig['title'] as String),
      description: Text(message),
      alignment: Alignment.bottomCenter,
      animationDuration: const Duration(milliseconds: 300),
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      icon: toastConfig['icon'] as Icon,
      showIcon: true,
      primaryColor: toastConfig['color'] as Color,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 16,
          offset: Offset(0, 16),
        ),
      ],
      showProgressBar: true,
      closeButton: ToastCloseButton(
        showType: CloseButtonShowType.onHover,
        buttonBuilder: (context, onClose) {
          return OutlinedButton.icon(
            onPressed: onClose,
            icon: const Icon(Icons.close, size: 20),
            label: const Text('Close'),
          );
        },
      ),
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  static Map<String, dynamic> _getToastConfig(ToastType type) {
    switch (type) {
      case ToastType.success:
        return {
          'type': ToastificationType.success,
          'title': 'Success',
          'color': Colors.green,
          'icon': const Icon(Icons.check_circle, color: Colors.green),
        };
      case ToastType.error:
        return {
          'type': ToastificationType.error,
          'title': 'Error',
          'color': Color(0xFFFF5252),
          'icon': const Icon(Icons.error, color: Color(0xFFFF5252)),
        };
      case ToastType.warning:
        return {
          'type': ToastificationType.warning,
          'title': 'Warning',
          'color': Colors.orange,
          'icon': const Icon(Icons.warning, color: Colors.orange),
        };
      case ToastType.info:
        return {
          'type': ToastificationType.info,
          'title': 'Notice',
          'color': Colors.blue,
          'icon': const Icon(Icons.info, color: Colors.blue),
        };
    }
  }
}
