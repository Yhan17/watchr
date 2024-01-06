// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/shared/theme/app_colors.dart';

typedef WatchFieldValidator = String? Function(String value);

class WatchInputWidget extends HookWidget {
  final TextEditingController? controller;
  final WatchFieldValidator? validator;
  final ValueChanged<String>? onChanged;
  final String label;
  const WatchInputWidget({
    Key? key,
    required this.label,
    this.controller,
    this.validator,
    this.onChanged,
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
          cursorColor: AppColors.greyLighter,
          style: GoogleFonts.poppins(
            color: AppColors.greyLighter,
          ),
          decoration: InputDecoration(
            label: Text(
              label,
              style: GoogleFonts.poppins(
                color: AppColors.greyLighter,
              ),
            ),
            error: _handleErrorWidget(validationErrorNotifier),
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.greyLighter,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.greyLighter,
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
      'o campo deve ter no mínimo 6 caracteres',
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
