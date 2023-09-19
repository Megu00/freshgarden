import 'package:flutter/material.dart';

class CustumTextformfield extends StatelessWidget {
  const CustumTextformfield(
      {super.key,
      this.suffixIconColor,
      required this.controller,
      required this.labelText,
      this.texterror,
      this.redaonly,
      this.textInputType,
      required this.maxLength,
      this.suffixIcon});
  final Color? suffixIconColor;
  final String labelText;
  final TextEditingController controller;
  final String? texterror;
  final bool? redaonly;
  final int maxLength;

  final Widget? suffixIcon;
  final TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
     maxLength: maxLength,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field Empty';
        }
  
        if (value.length < 5) {
          return 'value to Short';
        }
        return null;
      },
      readOnly: redaonly!,
      controller: controller,
      
      decoration: InputDecoration(
        
          errorText: texterror,
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          labelText: labelText,
          border: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder()),
    );
  }
}
