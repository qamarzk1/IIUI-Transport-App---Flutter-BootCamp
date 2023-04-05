import 'package:flutter/material.dart';
import 'package:iiui_transport_app/res/color.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.myController,
    required this.focusNode,
    required this.onFiledSubmittedValue,
    required this.onValidator,
    required this.keyBoardType,
    required this.hint,
    required this.obsecureText,
    required this.prefixIcon,
    this.enable = true,
    this.autoFocus = true,
  }) : super(key: key);

  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyBoardType;
  final String hint;
  final bool obsecureText;
  final bool enable, autoFocus;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFiledSubmittedValue,
        validator: onValidator,
        keyboardType: keyBoardType,
        obscureText: obsecureText,
        cursorColor: AppColors.primaryTextTextColor,

        // decoration
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            labelStyle: TextStyle(color: Colors.black45.withOpacity(0.8)),
            prefixIcon: prefixIcon,),
      ),
    );
  }
}
