import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import 'txt.dart';

class SuperDropdownMenu extends StatefulWidget {
  final String? name;
  final dynamic selectedItem;
  final List<dynamic> items;
  String Function(dynamic)? itemAsString;
  final String eHint;
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

  final List<String? Function(dynamic)>? validators;
  final EdgeInsetsGeometry? contentPadding;

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
      this.eHint = '',
      this.eIcon,
      this.eAsset,
      this.ontap,
      this.selectedItem}) {
    this.itemAsString = itemAsString ?? ((dynamic s) => s.toString());
    // onChanged?.call(selectedItem);
    compareFn ??= (dynamic a, dynamic b) {
      return a == b;
    };
//    if (selectedVal == null) {
//      selectedVal = list[0];
//    }
  }

  @override
  State<SuperDropdownMenu> createState() => _SuperDropdownMenuState();
}

// ignore: camel_case_types
class _SuperDropdownMenuState extends State<SuperDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<dynamic>(
      items: widget.items,
      enabled: widget.enabled,
      itemAsString: widget.itemAsString,
      selectedItem: widget.selectedItem,
      filterFn: widget.filterFn,
      compareFn: widget.compareFn,
      asyncItems: widget.asyncItems,
      validator: FormBuilderValidators.compose(widget.validators ?? []),
      onChanged: widget.onChanged,
      popupProps: PopupPropsMultiSelection.menu(
          isFilterOnline: false,
          showSelectedItems: true,
          fit: FlexFit.loose,
          showSearchBox: widget.showSearchBox,
          searchFieldProps: TextFieldProps(
            textAlign: TextAlign.center,
            decoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
                  contentPadding: widget.contentPadding,
                  labelText: widget.eHint,
                  hintText: '${widget.eHint}...',
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
        baseStyle: const TextStyle(fontSize: 16),
        dropdownSearchDecoration: const InputDecoration().applyDefaults(context.theme.inputDecorationTheme).copyWith(
          contentPadding: widget.contentPadding,
              labelText: widget.eHint,
              hintText: '${widget.eHint}...',
            ),
        // dropdownSearchDecoration: InputDecoration(
        //   isDense: true,
        //   alignLabelWithHint: true,
        //   suffixIconConstraints: const BoxConstraints(maxHeight: 30),
        //   contentPadding: const EdgeInsets.all(4),
        //   floatingLabelBehavior: FloatingLabelBehavior.always,
        //   filled: true,
        //   fillColor: Colors.white,
        //   labelStyle: TextStyle(
        //       fontFamily: GoogleFonts.notoSansBhaiksuki().fontFamily!,
        //       fontSize: 16,
        //       color: context.theme.primaryColor),
        //   labelText: widget.eHint,
        //   hintText: widget.eHint,
        //   hintStyle: TextStyle(
        //       fontFamily: GoogleFonts.notoSansBhaiksuki().fontFamily!,
        //       fontSize: 12,
        //       color: Colors.grey),
        //   // prefixIconConstraints: BoxConstraints.tightForFinite(width: 30),
        //   // prefixIcon: widget.eIcon == null
        //   //     ? widget.eAsset == null
        //   //         ? null
        //   //         : Image.asset('assets/images/${widget.eAsset}.svg')
        //   //     : Icon(widget.eIcon),
        //   border: OutlineInputBorder(
        //       borderSide: const BorderSide(color: Colors.blue),
        //       borderRadius: BorderRadius.circular(1)),
        //   enabledBorder: OutlineInputBorder(
        //       borderSide: const BorderSide(color: Colors.blue),
        //       borderRadius: BorderRadius.circular(1)),
        //   focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(2),
        //       borderSide: const BorderSide(color: Colors.green)),
        // ),
      ),
    );
  }
}
