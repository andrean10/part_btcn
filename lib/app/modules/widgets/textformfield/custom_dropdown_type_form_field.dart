import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/shared_enum.dart';
import '../../../helpers/text_helper.dart';

class CustomDropdownTypeFormField<T> extends StatelessWidget {
  // final TextEditingController? controller;
  final FocusNode? focusNode;
  final BoxConstraints? constraints;
  final bool isRequired;
  // final Mode mode;
  final String title;
  final String? hintText;
  final String? hintTextSearch;
  final String? helperText;
  final String? errorText;
  final T? selectedItem;
  // final FutureOr<List<T>> Function(String filter, LoadProps? props)? items;
  final List<T>? items;
  final Future<List<T>> Function(String filter)? asyncItems;
  final String Function(T value)? itemAsString;
  final Function(T? value)? onChanged;
  final BeforeChange<T?>? onBeforeChange;
  final bool Function(T item, String filter)? filterFn;
  final bool Function(T item1, T item2)? compareFn;
  final bool Function(T item)? disabledItemFn;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool isShowSearchBox;
  final bool isShowTitleBottomsheet;
  final bool isFilterOnline;
  final Widget Function(
    BuildContext context,
    T item,
    bool isDisabled,
    bool isSelected,
  )? itemBuilder;
  final Widget Function(BuildContext, String)? loadingBuilder;
  final Widget Function(BuildContext, String)? emptyBuilder;
  final Widget Function(BuildContext context, String, dynamic)? errorBuilder;
  final FormFieldValidator<T>? validator;
  final bool isEnabled;
  final bool isLabel;
  final bool isFilled;
  final bool isDense;
  // final bool isItemsCached;
  // final bool isEnableFilter;
  // final bool? isShowKeyboard;
  // final bool isExpanded;
  // final bool isDense;
  // final MenuStyle? menuStyle;
  // final double? menuHeight;
  // final Widget? leadingIcon;
  // final Widget? trailingIcon;
  final Widget? selectedTrailingIcon;
  final TextStyle? titleTextStyle;
  final TextStyle? textStyle;
  // final ValueChanged<dynamic>? onSelected;
  // final int? Function(List<DropdownMenuEntry<dynamic>>, String)? searchCallback;
  // final InfiniteScrollProps? infiniteScrollProps;
  final Function(List<T> items)? onItemsLoaded;
  final TypeDropDown? type;

  const CustomDropdownTypeFormField({
    super.key,
    // this.controller,
    this.focusNode,
    this.constraints,
    this.isRequired = false,
    // this.mode = Mode.form,
    required this.title,
    this.hintText,
    this.hintTextSearch,
    this.helperText,
    this.isLabel = false,
    this.items,
    this.asyncItems,
    this.itemAsString,
    this.selectedItem,
    this.onChanged,
    this.onBeforeChange,
    this.filterFn,
    this.compareFn,
    this.disabledItemFn,
    this.prefixIcon,
    this.suffix,
    this.isShowSearchBox = false,
    this.isShowTitleBottomsheet = true,
    this.isFilterOnline = false,
    this.itemBuilder,
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.validator,
    this.isEnabled = true,
    this.isFilled = false,
    this.isDense = false,
    // this.isItemsCached = false,
    // this.isEnableFilter = false,
    // this.isEnableSearch = true,
    // this.isShowKeyboard,
    // this.isExpanded = true,
    // this.menuHeight,
    // this.menuStyle,
    // this.leadingIcon,
    // this.trailingIcon,
    this.selectedTrailingIcon,
    this.errorText,
    this.titleTextStyle,
    this.textStyle,
    // this.onSelected,
    // this.searchCallback,
    // this.infiniteScrollProps,
    this.onItemsLoaded,
    this.type = TypeDropDown.menu,
    // this.mode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;

    Widget builderTitle() {
      if (title != '' && !isLabel) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isRequired)
              TextHelper.buildRichText(
                text: '$title *',
                highlight: '*',
                highlightStyle:
                    textTheme.titleMedium!.copyWith(color: Colors.red),
                defaultStyle: titleTextStyle ?? textTheme.titleMedium,
              )
            else
              Text(
                title,
                style: titleTextStyle ?? theme.textTheme.titleMedium,
                maxLines: 1,
              ),
            const SizedBox(height: 8),
          ],
        );
      }

      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        builderTitle(),
        builderDropdown(theme),
      ],
    );
  }

  Widget builderDropdown(ThemeData theme) {
    return DropdownSearch<T>(
      autoValidateMode: AutovalidateMode.onUserInteraction,
      selectedItem: selectedItem,
      // mode: mode,
      // items: items,
      items: items ?? [],
      asyncItems: asyncItems,
      itemAsString: itemAsString,
      enabled: isEnabled,
      filterFn: (compareFn == null) ? filterFn : null,
      compareFn: compareFn ?? (item1, item2) => item1 == item2,
      onChanged: onChanged,
      onBeforeChange: onBeforeChange,
      popupProps: builderPopupProps(theme),
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: textStyle,
        dropdownSearchDecoration: InputDecoration(
          labelText: (isLabel) ? '$title ${isRequired ? '*' : ''}' : null,
          // hintText: hintText ?? 'Pilih $title',
          helperText: helperText,
          helperMaxLines: 2,
          errorText: errorText,
          errorMaxLines: 3,
          prefixIcon: (prefixIcon != null) ? Icon(prefixIcon) : null,
          border: (!isFilled)
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: theme.colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          suffix: suffix,
          filled: isFilled,
          isDense: isDense,
        ),
        // isHovering: true,
      ),
      dropdownButtonProps: DropdownButtonProps(
        focusNode: focusNode,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        selectedIcon: const Icon(Icons.keyboard_arrow_up_rounded),
      ),
      validator: validator,
    );
  }

  PopupProps<T> builderPopupProps(ThemeData theme) {
    final textTheme = theme.textTheme;

    switch (type) {
      case TypeDropDown.dialog:
        return PopupProps.dialog(
          title: Padding(
            padding: const EdgeInsets.all(16),
            child: AutoSizeText(
              'Pilih $title',
              style: textTheme.titleLarge,
            ),
          ),
          showSearchBox: isShowSearchBox,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Masukkan Pencarian',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: theme.colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          showSelectedItems: true,
          isFilterOnline: isFilterOnline,
          // itemBuilder: itemBuilder,
          loadingBuilder: loadingBuilder,
          emptyBuilder: emptyBuilder,
          errorBuilder: errorBuilder,
        );
      case TypeDropDown.modal:
        return PopupProps.modalBottomSheet(
          title: Padding(
            padding: const EdgeInsets.all(16),
            child: AutoSizeText(
              'Pilih $title',
              style: textTheme.titleLarge,
            ),
          ),
          showSearchBox: isShowSearchBox,
          modalBottomSheetProps: const ModalBottomSheetProps(),
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Masukkan Pencarian',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: theme.colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          showSelectedItems: true,
          isFilterOnline: isFilterOnline,
          // itemBuilder: itemBuilder,
          loadingBuilder: loadingBuilder,
          emptyBuilder: emptyBuilder,
          errorBuilder: errorBuilder,
        );
      case TypeDropDown.bottomSheet:
        return PopupProps.bottomSheet(
          fit: FlexFit.loose,
          title: (isShowTitleBottomsheet)
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: AutoSizeText(
                    'Pilih $title',
                    style: textTheme.titleLarge,
                  ),
                )
              : const SizedBox.shrink(),
          showSearchBox: isShowSearchBox,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: 'Masukkan Pencarian',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: theme.colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          showSelectedItems: true,
          isFilterOnline: isFilterOnline,
          // itemBuilder: itemBuilder,
          loadingBuilder: loadingBuilder,
          emptyBuilder: emptyBuilder,
          errorBuilder: errorBuilder,
        );
      default:
        return PopupProps.menu(
          fit: FlexFit.loose,
          constraints: constraints ?? const BoxConstraints(maxHeight: 200),
          showSearchBox: isShowSearchBox,
          showSelectedItems: true,
          // disableFilter: isFilterOnline,
          isFilterOnline: isFilterOnline,
          disabledItemFn: disabledItemFn,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              isDense: isDense,
              hintText: 'Masukkan Pencarian',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: theme.colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          // cacheItems: isItemsCached,
          // infiniteScrollProps: infiniteScrollProps,
          // onItemsLoaded: onItemsLoaded,
          // itemBuilder: itemBuilder,
          loadingBuilder: loadingBuilder ??
              (context, searchEntry) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
          emptyBuilder: emptyBuilder ??
              (context, searchEntry) => SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        searchEntry.isNotEmpty
                            ? 'Pencarian $searchEntry tidak ditemukan'
                            : 'Data tidak ditemukan',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          errorBuilder: errorBuilder ??
              (context, searchEntry, exception) {
                return builderError(context, exception.toString());
              },
        );
    }
  }

  Widget builderError(BuildContext context, String? exception) {
    final textTheme = context.textTheme;
    // final height = context.mediaQuerySize.height;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Gagal memuat data, ${(exception != null) ? 'karena $exception' : ''} coba lagi',
            style: textTheme.bodyMedium,
          ),
          // const SizedBox(height: 12),
          // Buttons.filled(
          //   onPressed: () {},
          //   height: height / 21,
          //   child: const Text('Coba lagi'),
          // )
        ],
      ),
    );
  }
}
