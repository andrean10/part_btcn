// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/text_helper.dart';

class CustomDropdownFormField<T> extends StatelessWidget {
  final T? initialSelection;
  final String title;
  final String? hintText;
  final String? helperText;
  final bool isRequired;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? width;
  final List<DropdownMenuEntry<T>> items;
  final List<DropdownMenuItem<T>>? newItems;
  final bool isEnabled;
  final bool isEnableFilter;
  final bool isEnableSearch;
  final bool? isShowKeyboard;
  final bool isFilled;
  final bool isLabel;
  final bool isExpanded;
  final bool isDense;
  final MenuStyle? menuStyle;
  final double? menuHeight;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Widget? selectedTrailignIcon;
  final String? errorText;
  final TextStyle? textStyle;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<T?>? onSelected;
  final int? Function(List<DropdownMenuEntry<T>>, String)? searchCallback;

  const CustomDropdownFormField({
    super.key,
    this.initialSelection,
    this.controller,
    this.focusNode,
    this.isRequired = false,
    this.width,
    required this.title,
    this.hintText,
    this.helperText,
    required this.items,
    this.newItems,
    this.isEnabled = true,
    this.isEnableFilter = false,
    this.isEnableSearch = true,
    this.isShowKeyboard,
    this.isFilled = false,
    this.isLabel = false,
    this.isExpanded = true,
    this.isDense = false,
    this.menuHeight,
    this.menuStyle,
    this.leadingIcon,
    this.trailingIcon,
    this.selectedTrailignIcon,
    this.errorText,
    this.textStyle,
    this.onSelected,
    this.onChanged,
    this.searchCallback,
  });

  @override
  Widget build(BuildContext context) {
    final mediaWidth = context.width;
    final theme = context.theme;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        builderTitle(theme, textTheme),
        const SizedBox(height: 8),
        builderDropdown(mediaWidth, theme)
      ],
    );
  }

  Widget builderTitle(ThemeData theme, TextTheme textTheme) {
    if (title != '') {
      if (isRequired) {
        return TextHelper.buildRichText(
          text: '$title *',
          highlight: '*',
          highlightStyle: textTheme.titleMedium!.copyWith(color: Colors.red),
          defaultStyle: textTheme.titleMedium,
        );
      } else {
        return Text(
          title,
          style: theme.textTheme.titleMedium,
        );
      }
    }

    return const SizedBox.shrink();
  }

  Widget builderDropdown(double mediaWidth, ThemeData theme) {
    return DropdownMenu<T>(
      initialSelection: initialSelection,
      controller: controller,
      focusNode: focusNode,
      // width: width ?? mediaWidth / 1.1,
      hintText: hintText ?? 'Pilih Item',
      helperText: helperText,
      dropdownMenuEntries: items,
      enabled: isEnabled,
      enableSearch: isEnableSearch,
      requestFocusOnTap: isShowKeyboard,
      enableFilter: isEnableFilter,
      expandedInsets: isExpanded ? EdgeInsets.zero : null,
      menuHeight: menuHeight,
      leadingIcon: leadingIcon,
      trailingIcon:
          trailingIcon ?? const Icon(Icons.keyboard_arrow_down_rounded),
      selectedTrailingIcon:
          selectedTrailignIcon ?? const Icon(Icons.keyboard_arrow_up_rounded),
      errorText: errorText,
      textStyle: textStyle,
      label: (!isLabel) ? Text(title) : null,
      inputDecorationTheme: InputDecorationTheme(
        isDense: isDense,
        errorMaxLines: 2,
        border: (!isFilled)
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: theme.colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        filled: isFilled,
      ),
      onSelected: onSelected,
      searchCallback: searchCallback,
    );
  }

  // Widget builderNewDropdown() {
  //   return DropdownButtonFormField(
  //     items: newItems,
  //     onChanged: onChanged,
  //     validator: validator,
  //   );
  // }
}
