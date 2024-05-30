import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:demo1/utils/string.dart';
import 'package:demo1/widget/ripple.dart';

import '../../assets/index.dart';

class AppInput extends StatefulWidget {
  const AppInput({
    Key? key,
    this.disabled = false,
    this.controller,
    this.focusNode,
    this.prefixIcon,
    this.downIcon,
    this.textInputAction,
    this.textInputType,
    this.formatters,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.showCursor = true,
    this.onClear,
    this.validator,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.fillColor = inputColor,
    this.onTap,
    this.buildCounter,
    this.textCapitalization = TextCapitalization.none,
    this.borderSide = BorderSide.none,
    this.autofocus = false,
    this.hintColor,
    this.onFieldSubmitted,
    this.showCounter = false,
    this.value,
    this.onSuffixProcess,
    this.maxLinesError = 1,
    this.onCheckNull,
    this.onCheckError,
    this.onBlur,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.showCleanText = true,
    this.maxLengthEnforcement,
    this.suffixColor,
    this.valueStyle,
    this.unit,
    this.textAlign,
    this.height = 56,
    this.suffixWidget,
    this.cleanSuffixTopPadding,
    this.isValid = true,
    this.borderColor,
    this.borderWidth,
    this.readOnly = false,
    this.disabledColor,
  }) : super(key: key);
  final bool disabled;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  // prefix icon should be a 24x24 svg or png file
  final Widget? prefixIcon;
  final Widget? downIcon;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? formatters;
  final Function(String)? onChanged;
  final Function(String)? onCheckNull;
  final Function(String)? onCheckError;
  final Function(String)? onBlur;
  final int? maxLines;
  final int? maxLength;
  final bool? showCursor;
  final Function()? onClear;
  final Function()? onSuffixProcess;
  final VoidCallback? onTap;
  final String? hintText;
  final String? labelText;
  final String? suffixIcon;
  final Color? fillColor;
  final Color? suffixColor;
  final InputCounterWidgetBuilder? buildCounter;
  final TextCapitalization textCapitalization;
  final BorderSide borderSide;
  final bool autofocus;
  final Color? hintColor;
  final Color? borderColor;
  final double? borderWidth;
  final Function(String)? onFieldSubmitted;
  final bool showCounter;
  final String? value;
  final int? maxLinesError;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final bool showCleanText;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final TextStyle? valueStyle;
  final Widget? unit;
  final Widget? suffixWidget;
  final TextAlign? textAlign;
  final double? height;
  final double? cleanSuffixTopPadding;
  final bool isValid;
  final bool readOnly;
  final Color? disabledColor;

  @override
  State<AppInput> createState() => _TextFieldState();
}

class _TextFieldState extends State<AppInput> {
  bool hasFocus = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String oldText = '';
  TextEditingController? _textController;
  FocusNode? _focusNode;
  Color? _borderColor;
  String? _errorText;
  bool _obscureText = false;

  @override
  void initState() {
    _textController =
        widget.controller ?? TextEditingController(text: widget.value);
    _focusNode = widget.focusNode ?? FocusNode();
    initFocusNode();
    _obscureText = widget.obscureText;
    super.initState();
  }

  void initFocusNode() {
    _focusNode?.addListener(initFocusNodeListener);
  }

  void initFocusNodeListener() {
    if (_focusNode != null) {
      if (_focusNode?.hasFocus == true) {
        if (hasFocus) return;
        if (!mounted) return;

        setState(() {
          hasFocus = true;
          widget.onTap?.call();
        });
      } else {
        if (!mounted) return;

        if (!hasFocus) return;
        setState(() {
          hasFocus = false;
          widget.onBlur?.call(_textController?.text ?? '');
        });
        _validate();
      }
    }
  }

  _validate() {
    setState(() {
      final value = _textController?.text ?? '';
      if (value.trim().isNotEmpty) {
        _errorText = widget.onCheckError?.call(value);
      } else {
        _errorText = widget.onCheckNull?.call(value);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_textController == null) {
      _textController?.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode?.removeListener(initFocusNodeListener);
      _focusNode?.dispose();
    }
  }

  void _newTextCheck(String newText) {
    if ((oldText.isEmpty && newText.isNotEmpty) ||
        (oldText.isNotEmpty && newText.isEmpty)) {
      setState(() {});
    }
    oldText = newText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: widget.borderColor ?? grey400,
                width: widget.borderWidth ?? 0),
            borderRadius: BorderRadius.circular(12),
            color: widget.disabled
                ? widget.disabledColor
                : widget.fillColor ?? inputColor,
          ),
          height: widget.height,
          alignment: Alignment.center,
          child: Form(
            key: key,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.prefixIcon == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: widget.prefixIcon),
                Expanded(
                  child: TextFormField(
                    textAlign: widget.textAlign ?? TextAlign.start,
                    maxLengthEnforcement: widget.maxLengthEnforcement,
                    autofocus: widget.autofocus,
                    onTap: widget.onTap,
                    focusNode: _focusNode,
                    inputFormatters: widget.formatters,
                    textInputAction: widget.textInputAction,
                    controller: _textController,
                    textCapitalization: widget.textCapitalization,
                    keyboardType: widget.textInputType,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (value) {
                      widget.onChanged?.call(value.trim());
                      _newTextCheck(value);
                    },
                    validator: widget.validator ??
                        (value) {
                          _validate();
                          return null;
                        },
                    enableSuggestions: widget.enableSuggestions,
                    autocorrect: widget.autocorrect,
                    onFieldSubmitted: widget.onFieldSubmitted,
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines,
                    enabled: !widget.disabled,
                    readOnly: widget.readOnly,
                    showCursor: widget.showCursor,
                    style: widget.valueStyle ??
                        text12.copyWith(
                            color: widget.disabled ? kcDavyGrey : Colors.black),
                    buildCounter: widget.buildCounter ?? _buildCounter,
                    cursorColor: kcLightSalmonPink,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        suffixIcon: _cleanSuffixIcon(),
                        fillColor: widget.disabled
                            ? widget.disabledColor
                            : widget.fillColor ?? inputColor,
                        filled: true,
                        hintText: widget.hintText,
                        labelText: widget.labelText,
                        hintStyle: text14.normal
                            .copyWith(color: widget.hintColor ?? kcNickel),
                        labelStyle: text16.normal
                            .copyWith(color: widget.hintColor ?? kcNickel),
                        suffixIconConstraints: !widget.showCleanText
                            ? const BoxConstraints(maxWidth: 0, maxHeight: 0)
                            : null,
                        contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10)
                            .copyWith(
                          right: !widget.showCleanText ? 16 : 42,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                ),
                widget.downIcon == null
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 12, bottom: 12, right: 10),
                        child: widget.downIcon),
              ],
            ),
          ),
        ),
        if (!_errorText.isNullOrEmpty) const SizedBox(height: 4),
        if (!_errorText.isNullOrEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 0, bottom: 8.0),
            child: Row(
              children: [
                ImageAssets.svgAssets(
                  Svg.icPhone,
                  color: errorColor,
                  height: 18,
                  width: 18,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  _errorText!,
                  maxLines: widget.maxLinesError,
                  overflow: TextOverflow.ellipsis,
                  style: text12.normal.copyWith(color: errorColor),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _cleanSuffixIcon() {
    if (!widget.showCleanText) {
      return const SizedBox.shrink();
    }
    return widget.suffixIcon.isNullOrEmpty ||
            _textController?.text.isEmpty == false
        ? getSuffixIcon()
        : widget.suffixIcon.isNullOrEmpty == false
            ? Ripple(
                onTap: widget.onSuffixProcess,
                disable: widget.disabled,
                child: ImageAssets.svgAssets(
                  widget.suffixIcon!,
                  color: widget.disabled ? kcDavyGrey : null,
                ),
              )
            : const SizedBox(
                height: 24,
              );
  }

  Widget getSuffixIcon() {
    if (_textController == null) {
      return widget.suffixWidget ??
          const SizedBox(
            height: 24,
          );
    }
    if (_textController?.text.isNullOrEmpty == true ||
        (!hasFocus && widget.obscureText == false)) {
      return widget.suffixWidget ??
          const SizedBox(
            height: 24,
          );
    }
    return widget.obscureText == false
        ? Ripple(
            onTap: () {
              _textController?.text = '';
              _textController?.clear();
              widget.onClear?.call();
              setState(() {
                oldText = "";
                _borderColor = null;
                _errorText = null;
              });
            },
            child: ImageAssets.svgAssets(
              widget.isValid ? Svg.icDelete : Svg.icDeleteError,
              color: widget.disabled ? kcDavyGrey : widget.suffixColor,
              width: 20.sp,
            ),
          )
        : Ripple(
            onTap: () {
              print('--- $_obscureText');
              if (_obscureText == true) {
                setState(() {
                  _obscureText = false;
                });
              } else {
                setState(() {
                  _obscureText = true;
                });
              }
            },
            child: Icon(
              _obscureText == true ? Icons.visibility : Icons.visibility_off,
              size: 24.sp,
            ),
          );
  }

  Widget? _buildCounter(BuildContext context,
      {required int currentLength,
      required bool isFocused,
      required int? maxLength}) {
    return null;
  }
}
