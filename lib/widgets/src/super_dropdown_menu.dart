import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:super_widgets/home/home.dart';

class SuperDropdownMenu extends StatefulWidget {
  final String? name;
  final List<dynamic> items;
  String Function(dynamic)? itemAsString;
  final String hint;
  final dynamic initialValue;
  final IconData? eIcon;
  final String? eAsset;
  final Function(dynamic s)? onChanged;
  final bool Function(dynamic, String)? filterFn;

  bool Function(dynamic, dynamic)? compareFn;
  final Future<List<dynamic>> Function(String)? asyncItems;

  final Function? ontap;

  final bool enabled;
  final bool enableBorders;
  final bool showSearchBox;

  final List<String? Function(dynamic)> validators;
  final EdgeInsetsGeometry? contentPadding;

  // final Rxn<dynamic> _selectedItem = Rxn<dynamic>();
  // dynamic get selectedItem => _selectedItem.value;
  // set selectedItem(dynamic val) => {_selectedItem.value = val, _selectedItem.refresh()};

  SuperDropdownMenu(
      {super.key,
      required this.items,
      String Function(dynamic)? itemAsString,
      this.showSearchBox = true,
      this.name,
      this.contentPadding,
      this.validators = const [],
      this.onChanged,
      this.filterFn,
      this.compareFn,
      this.enableBorders = true,
      this.enabled = true,
      this.asyncItems,
      this.hint = '',
      this.eIcon,
      this.eAsset,
      this.ontap,
      this.initialValue}) {
    // this.selectedItem = selectedItem;
    this.itemAsString = itemAsString ?? ((dynamic s) => s.toString().tr);
    compareFn ??= (dynamic a, dynamic b) => a == b;
  }

  @override
  State<SuperDropdownMenu> createState() => _SuperDropdownMenuState();
}

class _SuperDropdownMenuState extends State<SuperDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: LanguageService.to.textDirection,
      child: DropdownSearch<dynamic>(
        items: widget.items,
        enabled: widget.enabled,
        itemAsString: widget.itemAsString,
        selectedItem: widget.initialValue,
        filterFn: widget.filterFn,
        compareFn: widget.compareFn,
        asyncItems: widget.asyncItems,
        validator: FormBuilderValidators.compose(widget.validators),
        onChanged: widget.onChanged,
        popupProps: PopupPropsMultiSelection.menu(
            isFilterOnline: false,
            showSelectedItems: true,
            fit: FlexFit.loose,
            showSearchBox: widget.showSearchBox,
            searchFieldProps: TextFieldProps(
              textAlign: TextAlign.center,
              decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
                    isDense: true,
                    contentPadding: widget.contentPadding,
                    labelText: widget.hint.tr,
                    hintText: '${widget.hint.tr}...',
                  ),
            )
            // favoriteItemProps: FavoriteItemProps(
            //   showFavoriteItems: true,
            //   favoriteItems: (us) {
            //     return us
            //         .where((e) => e.name.contains("Mrs"))
            //         .toList();
            //   },
            // ),
            ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlign: LanguageService.to.textAlign,
          baseStyle: const TextStyle(fontSize: 16),
          dropdownSearchDecoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
                isDense: true,
                contentPadding: widget.contentPadding,
                labelText: widget.hint.tr,
                hintText: '${widget.hint.tr}...',
              ),
        ),
      ),
    );
  }
}
