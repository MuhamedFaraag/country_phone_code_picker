import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:country_phone_code_picker/constants/country_flag_image.dart';
import 'package:country_phone_code_picker/controller/search_controller.dart';
import 'package:country_phone_code_picker/controller/country_controller.dart';

// ignore: must_be_immutable
class CountryPhoneCodePickerModalSheet extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  CountryPhoneCodePickerModalSheet({
    required this.searchSheetBackground,
    required this.searchBarLeadingIcon,
    required this.searchBarHintText,
    required this.searchBarHintStyle,
    required this.searchBarLabelText,
    required this.searchBarLabelStyle,
    required this.searchBarHelperText,
    required this.searchBarHelperStyle,
    required this.searchBarPrefixText,
    required this.searchBarPrefixStyle,
    required this.searchBarPrefixIcon,
    required this.searchBarContentPadding,
    required this.border,
    required this.errorBorder,
    required this.focusedBorder,
    required this.disabledBorder,
    required this.focusedErrorBorder,
    required this.enabledBorder,
    required this.searchBarCursorColor,
    required this.searchBarCursorHeight,
    required this.searchBarCursorWidth,
    required this.style,
    required this.searchBarInitialValue,
    required this.keyboardType,
    required this.showCursor,
  });

  Color searchSheetBackground;

  //leading icon in the appbar that exits the modal sheet page
  Icon searchBarLeadingIcon;

  //hint text for search bar
  String? searchBarHintText;

  //styling for hint text
  TextStyle searchBarHintStyle;

  //label text for search bar
  String? searchBarLabelText;

  //styling for label text
  TextStyle searchBarLabelStyle;

  //helper text for search bar
  String? searchBarHelperText;

  //styling for helper text
  TextStyle searchBarHelperStyle;

  //prefix text for search bar
  String? searchBarPrefixText;

  //styling for prefix text
  TextStyle searchBarPrefixStyle;

  //prefix icon for search bar
  Icon searchBarPrefixIcon;

  //padding inside the search bar text field
  EdgeInsetsGeometry searchBarContentPadding;

  //border of search bar text field
  InputBorder border;

  //error border for search bar text field
  InputBorder errorBorder;

  //focused border for search bar text field
  InputBorder focusedBorder;

  //disabled border for search bar text field
  InputBorder disabledBorder;

  //focused error border for search bar text field
  InputBorder focusedErrorBorder;

  //enabled border for search bar text field
  InputBorder enabledBorder;

  //color of cursor of search bar text field
  Color searchBarCursorColor;

  //height of cursor of search bar text field
  double searchBarCursorHeight;

  //width of cursor of search bar text field
  double searchBarCursorWidth;

  //text style of the input inside search bar text field
  TextStyle style;

  //initial value of the input in search bar text field
  String searchBarInitialValue;

  //keyboard type of search bar text field
  TextInputType keyboardType;

  //show cursor if the value is set to true
  bool showCursor;

  @override
  State<CountryPhoneCodePickerModalSheet> createState() =>
      _CountryPhoneCodePickerModalSheetState();
}

class _CountryPhoneCodePickerModalSheetState
    extends State<CountryPhoneCodePickerModalSheet> {
  TextEditingController? searchBarInput;

  @override
  Widget build(BuildContext context) {
    searchBarInput = TextEditingController(text: widget.searchBarInitialValue);
    SearchController searchController = Get.put(SearchController());
    CountryController countryController = Get.find<CountryController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: widget.searchSheetBackground,
          elevation: 0,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: searchBarLeadingIcon,
          // ),
          title: TextFormField(
            controller: searchBarInput,
            onChanged: (query) {
              searchController.updateQueryList(query);
            },
            decoration: InputDecoration(
              hintText: widget.searchBarHintText,
              hintStyle: widget.searchBarHintStyle,
              labelText: widget.searchBarLabelText,
              labelStyle: widget.searchBarLabelStyle,
              helperText: widget.searchBarHelperText,
              helperStyle: widget.searchBarHelperStyle,
              prefixText: widget.searchBarPrefixText,
              prefixStyle: widget.searchBarPrefixStyle,
              prefixIcon: widget.searchBarPrefixIcon,
              suffix: IconButton(
                onPressed: () {
                  searchBarInput!.clear();
                  searchController.updateQueryList('');
                },
                icon: const Icon(Icons.cancel_rounded, color: Colors.black),
              ),
              contentPadding: widget.searchBarContentPadding,
              border: widget.border,
              errorBorder: widget.errorBorder,
              enabledBorder: widget.enabledBorder,
              focusedBorder: widget.focusedBorder,
              disabledBorder: widget.disabledBorder,
              focusedErrorBorder: widget.focusedErrorBorder,
            ),
            cursorColor: widget.searchBarCursorColor,
            cursorHeight: widget.searchBarCursorHeight,
            cursorWidth: widget.searchBarCursorWidth,
            style: widget.style,
            keyboardType: widget.keyboardType,
            showCursor: widget.showCursor,
          ),
          centerTitle: true,
        ),
        body: Container(
          color: widget.searchSheetBackground,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<SearchController>(
                  builder: (controller) {
                    return ListView.builder(
                      itemCount: controller.filteredCountries.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            countryController.updateSelectedCountry(
                                controller.filteredCountries[index]);
                            setState(() {});
                            searchController.updateQueryList('');

                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              height: 30,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(countryFlagApi +
                                            controller
                                                .filteredCountries[index].code),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      controller.filteredCountries[index].name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    controller
                                        .filteredCountries[index].phoneCode,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
