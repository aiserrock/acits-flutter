import 'package:acits_flutter/ui/widget/action_bs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:acits_flutter/export.dart';

import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/style.dart';

const _reschedulePeriod = Duration(days: 90);

class PrescriptionCardWidget extends StatefulWidget {
  const PrescriptionCardWidget(
    this.itemData, {
    required this.typeNameMapper,
    Key? key,
  }) : super(key: key);

  final PrescriptionExecutionToday? itemData;
  final String? Function(MyTypeEnum?) typeNameMapper;

  @override
  State<PrescriptionCardWidget> createState() => _PrescriptionCardWidgetState();
}

class _PrescriptionCardWidgetState extends State<PrescriptionCardWidget> {
  final _formatter = DateFormat('H:mm');

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: ColorRes.foreground, borderRadius: BorderRadius.all(Radius.circular(8.0))),
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeAction(),
          const SizedBox(height: 4.0),
          if (widget.itemData?.myType != null) _buildType(),
          const SizedBox(height: 4.0),
          _buildAnimal(),
        ],
      ),
    );
  }

  Widget _buildAnimal() {
    return _isExpanded ? _buildExpanded() : _buildExpandHeader();
  }

  Widget _buildExpanded() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExpandHeader(),
        const Divider(height: 24.0),
        Text(StringRes.current.mainAnimal, style: StyleRes.content),
        const SizedBox(height: 4.0),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: (widget.itemData?.animal?.specParentName ?? ''),
                  style: StyleRes.mainContent),
              const TextSpan(text: (', '), style: StyleRes.mainContent),
              TextSpan(text: widget.itemData?.animal?.specName ?? '', style: StyleRes.mainContent),
            ],
          ),
          maxLines: 3,
        ),
        const Divider(height: 24.0),
        Text(StringRes.current.mainAppoinmentAuthor, style: StyleRes.content),
        const SizedBox(height: 4.0),
        // TODO: разобраться с данными по автору назначения
        const Text(
          ' ',
          style: StyleRes.content,
          maxLines: 3,
        ),
        const Divider(height: 24.0),
        Text(StringRes.current.mainAppoinment, style: StyleRes.content),
        const SizedBox(height: 4.0),
        if (widget.itemData?.drugs != null)
          ...widget.itemData!.drugs!.map<Widget>(
            (drug) => Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: (drug.drugName ?? ''), style: StyleRes.mainContent),
                  const TextSpan(text: (', '), style: StyleRes.mainContent),
                  if (drug.drugDosage != null)
                    TextSpan(text: (drug.drugDosage.toString()), style: StyleRes.mainContent),
                  if (drug.formOfDrug != null)
                    TextSpan(text: (drug.formOfDrug), style: StyleRes.mainContent),
                ],
              ),
              maxLines: 3,
            ),
          ),
        const Divider(height: 24.0),
        Row(
          children: [
            Assets.icon.comment.svg(color: ColorRes.accent),
            const SizedBox(width: 8.0),
            //TODO: разобраться с комментариями к карточкеƒ
            Text('2', style: StyleRes.mainContent.copyWith(color: ColorRes.textSecondary))
          ],
        ),
      ],
    );
  }

  Widget _buildExpandHeader() {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: (widget.itemData?.animal?.name ?? ''),
                    style: StyleRes.content.copyWith(color: ColorRes.textPrimary)),
                TextSpan(text: ' ', style: StyleRes.content.copyWith(color: ColorRes.textPrimary)),
                TextSpan(
                    text: (widget.itemData?.animal?.id ?? '').toString(),
                    style: StyleRes.content.copyWith()),
              ],
            ),
            maxLines: 3,
          ),
        ),
        _buildExpandButton(),
      ],
    );
  }

  Widget _buildExpandButton() {
    return InkWell(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: Icon(
        _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        color: ColorRes.accent,
      ),
    );
  }

  Widget _buildType() {
    return Text(
      widget.typeNameMapper.call(widget.itemData?.myType) ?? '',
      style: StyleRes.subTitle,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTimeAction() {
    return Row(
      children: [
        if (widget.itemData?.executeAt != null)
          Text(_formatter.format(widget.itemData!.executeAt!)),
        const Spacer(),
        InkWell(
          onTap: _openBsActions,
          child: const Icon(
            Icons.more_horiz,
            color: ColorRes.accent,
          ),
        )
      ],
    );
  }

  void _openBsActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => bsPeriodSelectorActions(
        context,
        <Widget, dynamic Function()>{
          Text(
            StringRes.current.commonDone,
            style: StyleRes.mainContent.copyWith(color: ColorRes.accent),
          ): () {
            Navigator.of(context).pop();
          },
          Text(
            StringRes.current.commonReschedule,
            style: StyleRes.mainContent.copyWith(color: ColorRes.accent),
          ): () {
            Navigator.of(context).pop();
            _reschedule();
          },
          Text(
            StringRes.current.commonNotCompleted,
            style: StyleRes.mainContent.copyWith(color: ColorRes.accent),
          ): () {
            Navigator.of(context).pop();
          },
          Text(
            StringRes.current.commonEdit,
            style: StyleRes.mainContent.copyWith(color: ColorRes.accent),
          ): () {
            Navigator.of(context).pop();
          },
          Text(
            StringRes.current.commonDelete,
            style: StyleRes.mainContent.copyWith(color: ColorRes.error),
          ): () {
            Navigator.of(context).pop();
          },
        },
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Future<void> _reschedule() async {
    final now = DateTime.now();
    final result = showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(_reschedulePeriod),
    );
  }
}
