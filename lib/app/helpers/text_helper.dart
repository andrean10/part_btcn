import 'dart:math';

import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

abstract class TextHelper {
  static Text buildRichText({
    required String text,
    required String highlight,
    required TextStyle highlightStyle,
    TextStyle? defaultStyle,
    TextAlign? textAlign,
  }) {
    List<TextSpan> spans = [];
    int start = 0;
    int indexOfHighlight;

    // Iterate over the text to find all occurrences of the highlight text
    while ((indexOfHighlight = text.indexOf(highlight, start)) != -1) {
      // Add text before the highlight text
      if (indexOfHighlight > start) {
        spans.add(
          TextSpan(
            text: text.substring(start, indexOfHighlight),
            style: defaultStyle,
          ),
        );
      }

      // Add the highlight text
      spans.add(
        TextSpan(
          text: highlight,
          style: highlightStyle,
        ),
      );

      // Move the start point
      start = indexOfHighlight + highlight.length;
    }

    // Add the remaining text
    if (start < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(start),
          style: defaultStyle,
        ),
      );
    }

    return Text.rich(
      TextSpan(
        children: spans,
      ),
      style: defaultStyle,
      textAlign: textAlign,
    );
  }

  static String? capitalizeEachWords(String? text) {
    if (text == null) return text;
    if (text.isEmpty) return text;
    return text.split(' ').map((word) => word.capitalize).join(' ');
  }

  // format int to rupiah
  static String formatRupiah({
    required num? amount,
    bool isCompact = true,
    bool isUsingSymbol = true,
    bool isMinus = false,
  }) {
    var formattedAmount = isUsingSymbol ? 'Rp. -' : '-';

    if (amount != null) {
      if (isCompact) {
        formattedAmount = NumberFormat.compactCurrency(
          locale: 'id',
          symbol: isUsingSymbol ? 'Rp. ' : '',
          decimalDigits: 0,
        ).format(amount);
      } else {
        formattedAmount = NumberFormat.currency(
          locale: 'id',
          symbol: isUsingSymbol ? 'Rp. ' : '',
          decimalDigits: 0,
        ).format(amount);
      }
    }

    return (isMinus) ? '-$formattedAmount' : formattedAmount;
  }

  static int parseRupiah(String? formattedAmount) {
    if (formattedAmount == null) return 0;

    // Hilangkan simbol "Rp" dan tanda baca lainnya
    final cleanedString = formattedAmount.replaceAll(RegExp(r'[^0-9]'), '');

    // Konversi ke int
    return int.tryParse(cleanedString) ?? 0;
  }

  static String formatNumberPhone(String phoneNumber) {
    if (phoneNumber.startsWith('08')) {
      return '+62${phoneNumber.substring(1)}';
    } else {
      return phoneNumber;
    }
  }

  static String formatNumber(num? number) {
    if (number == null) return '-';

    return NumberFormat.compact(locale: 'id').format(number);
  }

  static String generateUniqueId(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  static String replacePrefixText({
    required String prefix,
    required String? value,
    required String? replaceValue,
  }) {
    if (value == null) return '-';
    if (replaceValue == null) return '-';
    return replaceValue.replaceFirst(prefix, value);
  }

  static String splitMRCode(String? code) {
    if (code == null) return '';

    final prefix = code.replaceAll(RegExp(r'\d'), ''); // Mengambil teks
    var number = int.parse(
      code.replaceAll(
        RegExp(r'\D'),
        '',
      ),
    ); // Mengambil angka dan mengonversi ke int

    number += 1;

    final paddedNumber =
        number.toString().padLeft(code.length - prefix.length, '0');

    return '$prefix$paddedNumber';
  }

  static (String, String) extractCodeAndDescription({
    bool isMethodRegex = false,
    String? input,
  }) {
    const defaultReturn = ('-', '-');
    if (input == null) return defaultReturn;

    if (isMethodRegex) {
      RegExp regExp = RegExp(r'^([A-Z]\d{2}\.\d)\s(.+)$');
      Match? match = regExp.firstMatch(input);

      if (match != null) {
        final code = match.group(1) ?? '';
        final description = match.group(2) ?? '';
        return (code, description);
      }
    } else {
      final splittedText = input.split(' ');

      return (
        splittedText.firstOrNull ?? '',
        splittedText.lastOrNull ?? '',
      );
    }

    return defaultReturn;
  }
}
