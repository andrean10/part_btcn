import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'shared_enum.dart';

void showSnackbar({
  required BuildContext context,
  String? content,
  Widget? contentBuilder,
  // String? path,
  TextStyle? textStyle,
  required Color backgroundColor,
  Duration? duration,
  SnackBarBehavior? behavior,
  SnackBarAction? action,
}) {
  final textTheme = Theme.of(context).textTheme;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: contentBuilder ??
          Text(
            content ?? '',
            style: textStyle ??
                textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
      backgroundColor: backgroundColor,
      duration: duration ?? 3.minutes,
      behavior: behavior,
      action: action,
    ),
  );
}

Role? checkRole(String? roleUser) {
  if (roleUser == null) return null;

  Role role;

  if (roleUser == Role.admin.name) {
    role = Role.admin;
  } else if (roleUser == Role.direktur.name) {
    role = Role.direktur;
  } else if (roleUser == Role.finance.name) {
    role = Role.finance;
  } else {
    role = Role.user;
  }
  return role;
}

String getType(String? type) {
  switch (type) {
    case 'request':
      return 'Request Barang';
    case 'return':
      return 'Return Barang';
    default:
      return '-';
  }
}

String getStatus(String? status) {
  switch (status) {
    case 'approved':
      return 'Disetujui';
    case 'pending':
      return 'Menunggu';
    case 'rejected':
      return 'Ditolak';
    default:
      return '-';
  }
}

String getPaymentMethod(String? method) {
  switch (method) {
    case 'cash':
      return 'Tunai';
    case 'transfer':
      return 'Transfer';
    case 'qris':
      return 'QRIS';
    default:
      return '-';
  }
}

String getPaymentStatus(String? status) {
  switch (status) {
    case 'credit':
      return 'Menunggu';
    case 'paid':
      return 'Lunas';
    default:
      return '-';
  }
}
