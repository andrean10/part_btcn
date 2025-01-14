import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/shared_method.dart';
import '../../../../shared/shared_theme.dart';

abstract class Snackbar {
  static void success({
    required BuildContext context,
    String? content,
    Widget? contentBuilder,
    TextStyle? textStyle,
    Duration? duration,
    SnackBarAction? action,
  }) =>
      showSnackbar(
        context: context,
        content: content,
        contentBuilder: contentBuilder,
        textStyle: textStyle,
        backgroundColor: SharedTheme.successColor,
        duration: duration ?? const Duration(seconds: 5),
        action: action,
      );

  static void info({
    required BuildContext context,
    String? content,
    Widget? contentBuilder,
    TextStyle? textStyle,
    Duration? duration,
    SnackBarAction? action,
  }) =>
      showSnackbar(
        context: context,
        content: content,
        contentBuilder: contentBuilder,
        textStyle: textStyle,
        backgroundColor: SharedTheme.infoColor,
        duration: duration ?? const Duration(seconds: 5),
        action: action,
      );

  static void failed({
    required BuildContext context,
    String? content,
    Widget? contentBuilder,
    TextStyle? textStyle,
    Duration? duration,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) {
    final theme = context.theme;

    showSnackbar(
      context: context,
      content: content,
      contentBuilder: contentBuilder,
      textStyle: textStyle ?? TextStyle(color: theme.colorScheme.surface),
      backgroundColor: theme.colorScheme.error,
      duration: duration ?? const Duration(seconds: 5),
      behavior: behavior,
      action: action,
    );
  }

  static void close(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
