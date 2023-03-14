import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:our_pass/core/constants/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.labelText,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.lines = 1,
    this.onChanged,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final int? lines;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  void updatePasswordVisibility() {
    setState(
      () => _isPasswordVisible = !_isPasswordVisible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: appColors.darkGrey.withOpacity(.3),
        ),
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        cursorColor: appColors.purple,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: widget.isPassword ? !_isPasswordVisible : false,
        obscuringCharacter: '●',
        minLines: widget.lines,
        maxLines: widget.lines,
        inputFormatters: [
          ...?widget.inputFormatters,
        ],
        style: TextStyle(
          color: appColors.black,
          fontWeight: FontWeight.w500,
        ),
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  splashRadius: 25,
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: appColors.darkGrey,
                  ),
                  onPressed: updatePasswordVisibility,
                )
              : widget.suffixIcon,
        ),
      ),
    );
  }
}

class CustomPinCodeField extends StatelessWidget {
  const CustomPinCodeField({
    super.key,
    this.length = 4,
    this.onCompleted,
  });

  final int length;
  final Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: length,
      appContext: context,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      cursorColor: appColors.purple,
      cursorHeight: 25,
      animationDuration: const Duration(milliseconds: 300),
      onChanged: (value) {
        HapticFeedback.mediumImpact();
      },
      validator: (value) {
        // if (value?.length != null && value!.length >= length) {
        //   return null;
        // }
        // return 'Enter a valid code';
        return null;
      },
      onCompleted: onCompleted,
      textStyle: const TextStyle(
        fontSize: 12,
      ),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      pinTheme: PinTheme(
        fieldOuterPadding: const EdgeInsets.all(7),
        shape: PinCodeFieldShape.box,
        activeColor: appColors.purple,
        selectedColor: appColors.purple,
        inactiveColor: appColors.darkGrey,
        borderWidth: 1,
        borderRadius: BorderRadius.circular(4),
        activeFillColor: Colors.white,
      ),
    );
  }
}
