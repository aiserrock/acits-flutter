import 'package:acits_flutter/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Контейнер полей ввода/редактирования данных
/// при создании или редактировании
class FormEditCard extends StatelessWidget {
  const FormEditCard(
    this.data, {
    this.formKey,
    Key? key,
  }) : super(key: key);

  final List<EditCardData> data;

  final GlobalKey<FormState>? formKey;

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
                        _buildField(item),
                        if (item.onPressed != null)
                          Positioned.fill(child: InkWell(onTap: item.onPressed))
                      ],
                    )
                  ]
                : [
                    if (item.label != null)
                      Text(
                        item.label!,
                        style: StyleRes.content,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    item.content!,
                  ],
          ),
        )
        .toList();
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration:
          BoxDecoration(color: ColorRes.foreground, borderRadius: BorderRadius.circular(8.0)),
      child: Column(children: rows),
    );
  }

  Widget _buildField(
    EditCardData item, {
    bool enabled = true,
  }) {
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
      ),
      maxLength: item.maxLength,
      style: item.enabled ? null : const TextStyle().copyWith(color: ColorRes.textSecondary),
      maxLines: 8,
      minLines: 1,
      keyboardType: keyboardType,
      inputFormatters: item.digitsOnly ? [FilteringTextInputFormatter.digitsOnly] : null,
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
}
