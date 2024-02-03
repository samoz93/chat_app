import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum IconType {
  prefix,
  suffix,
}

class CustomInput extends StatefulWidget {
  final String initalValue;
  final String? label;
  final String? Function(String?)? validator;
  TextEditingController? controller = TextEditingController();
  final void Function(String value) onChanged;
  final void Function()? onSuffixClicked;
  final void Function()? onPrefixClicked;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final FocusNode? focusNode;
  CustomInput({
    super.key,
    this.label,
    this.initalValue = "",
    this.validator,
    this.controller,
    required this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.onSuffixClicked,
    this.onPrefixClicked,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late final FocusNode _focus;
  var _controller = TextEditingController();

  var isFocused = false;
  var hasValue = false;
  var hasError = false;

  @override
  void initState() {
    _focus = widget.focusNode ?? FocusNode(debugLabel: widget.label);
    isFocused = _focus.hasFocus;
    _controller =
        widget.controller ?? TextEditingController(text: widget.initalValue);
    _focus.addListener(_onFocusChanged);
    super.initState();
  }

  _onFocusChanged() {
    setState(() {
      isFocused = _focus.hasFocus;
    });
  }

  _onChanged(String value) {
    setState(() {
      hasValue = value.isNotEmpty;
      hasError = widget.validator?.call(value) != null;
    });
    widget.onChanged(value);
  }

  bool get shouldAddPadding {
    return isFocused || hasValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.sp),
      child: TextFormField(
        onChanged: _onChanged,
        validator: widget.validator,
        controller: _controller,
        focusNode: _focus,
        style: Theme.of(context).textTheme.bodyMedium,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          label: widget.label == null
              ? null
              : Container(
                  padding: EdgeInsets.only(
                    bottom: shouldAddPadding ? 20.sp : 0,
                  ),
                  child: Text(widget.label!),
                ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          suffixIcon: createBox(widget.suffixIcon, IconType.suffix, context),
          prefixIcon: createBox(widget.prefixIcon, IconType.prefix, context),
        ),
      ),
    );
  }

  Color get getColor {
    if (hasValue && !hasError) {
      return Colors.green;
    } else if (hasError) {
      return Colors.red;
    } else if (isFocused) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  Color get getColorUnder {
    if (hasValue && !hasError) {
      return Colors.green;
    } else if (hasValue && hasError) {
      return Colors.red;
    } else if (isFocused) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }

  Widget? createBox(
    IconData? icon,
    IconType type,
    BuildContext context,
  ) {
    if (icon == null) return null;

    return GestureDetector(
      onTap: type == IconType.suffix
          ? widget.onSuffixClicked
          : widget.onPrefixClicked,
      child: Container(
        padding: EdgeInsets.all(
          4.2.w,
        ),
        margin: EdgeInsets.only(
          right: type == IconType.prefix ? 10.sp : 0,
          left: type == IconType.suffix ? 10.sp : 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
          color: Theme.of(context).colorScheme.secondary,
          border: BorderDirectional(
            bottom: BorderSide(
              color: getColorUnder,
            ),
          ),
        ),
        child: Icon(
          icon,
          color: getColor,
        ),
      ),
    );
  }
}
