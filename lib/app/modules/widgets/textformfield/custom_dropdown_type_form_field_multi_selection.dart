import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/shared_enum.dart';
import '../../../helpers/text_helper.dart';


class CustomDropdownTypeFormFieldMultiSelection<T> extends StatelessWidget {
  final FocusNode? focusNode;
  final BoxConstraints? constraints;
  final bool isRequired;
  // final Mode mode;
  final String title;
  final String? hintText;
  final String? hintTextSearch;
  final String? helperText;
  final String? errorText;
  final List<T>? selectedItem;
  // final FutureOr<List<T>> Function(String filter, LoadProps? props)? items;
  final List<T>? items;
  final Future<List<T>> Function(String filter)? asyncItems;
  final String Function(T value)? itemAsString;
  final Future<bool?> Function(List<T> prevItems, List<T> nextItems)?
      onBeforeChange;
  final Function(List<T>? value)? onChanged;
  final bool Function(T item, String filter)? filterFn;
  final bool Function(T item1, T item2)? compareFn;
  final bool Function(T item)? disabledItemFn;
  final IconData? prefixIcon;
  final Widget? suffix;
  final bool isShowSearchBox;
  final bool isShowTitleBottomsheet;
  final bool isFilterOnline;
  final Widget Function(BuildContext context, List<T> selectedItems)?
      dropdownBuilder;
  final Widget Function(
    BuildContext context,
    T item,
    bool isDisabled,
    bool isSelected,
  )? itemBuilder;
  // final Widget Function(
  //         BuildContext context, T item, bool isDisabled, bool isSelected)?
  //     checkBoxBuilder;
  final Widget Function(
    BuildContext context,
    T item,
    bool isSelected,
  )? selectionWidget;
  final Widget Function(BuildContext context, String)? loadingBuilder;
  final Widget Function(BuildContext context, String)? emptyBuilder;
  final Widget Function(BuildContext context, String, dynamic)? errorBuilder;
  final FormFieldValidator<List<T>>? validator;
  final bool isEnabled;
  final bool isLabel;
  final bool isFilled;
  final bool isDense;
  // final bool isItemsCached;
  final Widget? selectedTrailingIcon;
  final TextStyle? textStyle;
  // final InfiniteScrollProps? infiniteScrollProps;
  // final Function(List<T> items)? onItemsLoaded;
  final TypeDropDown? type;

  const CustomDropdownTypeFormFieldMultiSelection({
    super.key,
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
    this.dropdownBuilder,
    this.itemBuilder,
    // this.checkBoxBuilder,
    this.selectionWidget,
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.validator,
    this.isEnabled = true,
    this.isFilled = false,
    this.isDense = false,
    // this.isItemsCached = false,
    this.selectedTrailingIcon,
    this.errorText,
    this.textStyle,
    // this.infiniteScrollProps,
    // this.onItemsLoaded,
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
                defaultStyle: textTheme.titleMedium,
              )
            else
              Text(
                title,
                style: theme.textTheme.titleMedium,
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
    return DropdownSearch<T>.multiSelection(
      autoValidateMode: AutovalidateMode.onUserInteraction,
      selectedItems: selectedItem ?? [],
      // mode: mode,
      items: items ?? [],
      asyncItems: asyncItems,
      itemAsString: itemAsString,
      enabled: isEnabled,
      filterFn: (compareFn == null) ? filterFn : null,
      compareFn: compareFn ?? (item1, item2) => item1 == item2,
      onChanged: onChanged,
      popupProps: builderPopupProps(theme),
      dropdownBuilder: dropdownBuilder,
      onBeforeChange: onBeforeChange,
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: textStyle,
        dropdownSearchDecoration: InputDecoration(
          labelText: (isLabel) ? title : null,
          hintText: hintText ?? 'Pilih $title',
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
      // dropdownButtonProps: DropdownSuffixProps(
      //   dropdownButtonProps: DropdownButtonProps(
      //     focusNode: focusNode,
      //     visualDensity: VisualDensity.compact,
      //     iconOpened: const Icon(Icons.keyboard_arrow_up_rounded),
      //     iconClosed: selectedTrailingIcon ??
      //         const Icon(Icons.keyboard_arrow_down_rounded),
      //   ),
      // ),
      validator: validator,
    );
  }

  PopupPropsMultiSelection<T> builderPopupProps(ThemeData theme) {
    final textTheme = theme.textTheme;

    switch (type) {
      case TypeDropDown.dialog:
        return PopupPropsMultiSelection.dialog(
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
          // disableFilter: isFilterOnline,
          // itemBuilder: itemBuilder,
          loadingBuilder: loadingBuilder,
          emptyBuilder: emptyBuilder,
          errorBuilder: errorBuilder,
        );
      case TypeDropDown.modal:
        return PopupPropsMultiSelection.modalBottomSheet(
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
          // disableFilter: isFilterOnline,
          // itemBuilder: itemBuilder,
          loadingBuilder: loadingBuilder,
          emptyBuilder: emptyBuilder,
          errorBuilder: errorBuilder,
        );
      case TypeDropDown.bottomSheet:
        return PopupPropsMultiSelection.bottomSheet(
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
          // disableFilter: isFilterOnline,
          isFilterOnline: isFilterOnline,
          // itemBuilder: itemBuilder,
          loadingBuilder: loadingBuilder,
          emptyBuilder: emptyBuilder,
          errorBuilder: errorBuilder,
        );
      default:
        return PopupPropsMultiSelection.menu(
          fit: FlexFit.loose,
          constraints: constraints ?? const BoxConstraints(maxHeight: 350),
          showSearchBox: isShowSearchBox,
          showSelectedItems: true,
          // disableFilter: isFilterOnline,
          isFilterOnline: isFilterOnline,
          disabledItemFn: disabledItemFn,
          // checkBoxBuilder: checkBoxBuilder,
          selectionWidget: selectionWidget,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              isDense: isDense,
              hintText: hintTextSearch ?? 'Masukkan Pencarian',
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
          // onItemAdded: (selectedItems, addedItem) {
          //   print('onItemAdded: ');
          //   print('selectedItems = $selectedItems');
          //   print('addedItem = $addedItem');
          // },
          // onItemRemoved: (selectedItems, removedItem) {
          //   print('onItemRemoved: ');
          //   print('selectedItems = $selectedItems');
          //   print('removedItem = $removedItem');
          // },
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
