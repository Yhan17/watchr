// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/shared/theme/app_colors.dart';

typedef LoginFieldValidator = String? Function(String value);

class WatchLoginInputWidget extends HookWidget {
  final TextEditingController? controller;
  final LoginFieldValidator? validator;
  final ValueChanged<String>? onChanged;
  final String label;
  final bool obscureText;
  const WatchLoginInputWidget({
    Key? key,
    required this.label,
    this.controller,
    this.validator,
    this.onChanged,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = controller ?? useTextEditingController();
    final validationErrorNotifier = useState<String?>(null);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onChanged: (value) => _handleOnChanged(
            value,
            validationErrorNotifier,
          ),
          controller: textController,
          showCursor: true,
          cursorColor: AppColors.innerInputColor,
          style: GoogleFonts.poppins(
            color: AppColors.innerInputColor,
          ),
          obscureText: obscureText,
          decoration: InputDecoration(
            label: Text(
              label,
              style: GoogleFonts.poppins(
                color: AppColors.innerInputColor,
              ),
            ),
            error: _handleErrorWidget(validationErrorNotifier),
            filled: true,
            fillColor: AppColors.inputColor,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.innerInputColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @protected
  void handleValueChanged(
    String value,
    ValueNotifier<String?> validationError, [
    ValueChanged<String>? callback,
  ]) {
    if (validator != null) {
      validationError.value = validator!(value);
    }
    callback?.call(value);
  }

  Widget? _handleErrorWidget(ValueNotifier<String?> validationError) {
    if (validationError.value == null) {
      return null;
    }

    if (validationError.value!.isEmpty) {
      return null;
    }

    return Text(
      validationError.value!,
      style: GoogleFonts.poppins(
        color: AppColors.darkOrange,
      ),
    );
  }

  void _handleOnChanged(
    String value,
    ValueNotifier<String?> validationError,
  ) {
    return handleValueChanged(
      value,
      validationError,
      onChanged,
    );
  }
}
