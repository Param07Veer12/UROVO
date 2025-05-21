import 'package:flutter/material.dart';

Widget dropDownWidget(
      {required String initialValue,
      required List<String> dropDownValueList,
      Key? key,
      required void Function(String?)? onChanged}) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      padding: const EdgeInsets.only(top: 10.0),
      child: DropdownButton<String>(
        key: key,
        isExpanded: true,
        isDense: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        underline: Container(),
        value: initialValue,
        onChanged: onChanged,
        onTap: () {},
        items: dropDownValueList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }