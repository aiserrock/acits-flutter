import 'package:acits_flutter/res/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Контейнер полей ввода/редактирования данных
/// при создании или редактировании
class FormEditCard extends StatelessWidget {
  const FormEditCard(
    this.data, {
    this.formKey,
    this.background,
    this.padding,
    this.margin,
    super.key,
  });

  final List<EditCardData> data;
  final GlobalKey<FormState>? formKey;
  final Color? background;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final rows = data
        .map<Widget>(
          (item) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: item.content == null
                ? [
                    Stack(
                      children: [
                        _buildField(context, item),
                        if (item.onPressed != null)
                          Positioned.fill(child: InkWell(onTap: item.onPressed)),
                      ],
                    ),
                  ]
                : [
                    if (item.label != null)
                      Text(
                        item.label!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    item.content!,
                  ],
          ),
        )
        .toList();
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: background ?? Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(children: rows),
    );
  }

  Widget _buildField(BuildContext context, EditCardData item, {bool enabled = true}) {
    final keyboardType = item.digitsOnly
        ? TextInputType.number
        : item.decimalOnly
        ? const TextInputType.numberWithOptions(decimal: true)
        : null;
    return TextFormField(
      key: formKey,
      enabled: item.enabled && enabled,
      validator: item.validator,
      controller: item.controller,
      initialValue: item.initValue,
      decoration: InputDecoration(
        labelText: item.label,
        suffixIcon: item.suffix,
        errorStyle: const TextStyle(fontSize: .0),
        fillColor: Colors.transparent,
      ),
      maxLength: item.maxLength,
      style: item.enabled
          ? null
          : const TextStyle().copyWith(color: context.appColors.textSecondary),
      maxLines: item.isObscure ? 1 : 8,
      minLines: 1,
      keyboardType: keyboardType,
      inputFormatters: item.digitsOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
      obscureText: item.isObscure,
      onChanged: item.onChanged,
    );
  }
}

class EditCardData {
  EditCardData({
    this.label,
    this.controller,
    this.onPressed,
    this.validator,
    this.suffix,
    this.content,
    this.digitsOnly = false,
    this.decimalOnly = false,
    this.enabled = true,
    this.initValue,
    this.maxLength,
    this.isObscure = false,
    this.onChanged,
  });

  final String? label;
  final Widget? content;
  final TextEditingController? controller;
  final VoidCallback? onPressed;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final bool digitsOnly;
  final bool decimalOnly;
  final bool enabled;
  final String? initValue;
  final int? maxLength;
  final bool isObscure;
  final Function(String)? onChanged;
}
