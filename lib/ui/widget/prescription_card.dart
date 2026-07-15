import 'package:acits_flutter/ui/widget/action_bs.dart';
import 'package:flutter/material.dart';

import 'package:acits_flutter/export.dart';

const _reschedulePeriod = Duration(days: 90);

class PrescriptionCardWidget extends StatefulWidget {
  const PrescriptionCardWidget(this.itemData, {this.onEditedPrescription, super.key});

  final PrescriptionExecutionToday? itemData;
  final VoidCallback? onEditedPrescription;

  @override
  State<PrescriptionCardWidget> createState() => _PrescriptionCardWidgetState();
}

class _PrescriptionCardWidgetState extends State<PrescriptionCardWidget> {
  final _formatter = DateFormat('H:mm');

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeAction(context),
          const SizedBox(height: 4.0),
          if (widget.itemData?.prescription.myType != null) _buildType(context),
          const SizedBox(height: 4.0),
          _buildAnimal(context),
        ],
      ),
    );
  }

  Widget _buildAnimal(BuildContext context) {
    return _isExpanded ? _buildExpanded(context) : _buildExpandHeader(context);
  }

  Widget _buildExpanded(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildExpandHeader(context),
        const Divider(height: 24.0),
        Text(LocaleKeys.mainAnimal.tr(), style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4.0),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: (widget.itemData?.prescription.animal.specParentName ?? ''),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextSpan(text: (', '), style: Theme.of(context).textTheme.bodyLarge),
              TextSpan(
                text: widget.itemData?.prescription.animal.specName ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          maxLines: 3,
        ),
        const Divider(height: 24.0),
        Text(LocaleKeys.mainAppoinmentAuthor.tr(), style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4.0),
        Text(widget.itemData?.prescription.createdBy ?? ' ', style: Theme.of(context).textTheme.bodyLarge, maxLines: 3),
        const Divider(height: 24.0),
        Text(LocaleKeys.mainAppoinment.tr(), style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4.0),
        if (widget.itemData?.prescription.drugs != null)
          ...widget.itemData!.prescription.drugs.map<Widget>(
            (drug) => Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: (drug.drugName), style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(text: (', '), style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(text: (drug.drugDosage.toString()), style: Theme.of(context).textTheme.bodyLarge),
                  if (drug.formOfDrug != null)
                    TextSpan(text: (drug.formOfDrug), style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              maxLines: 3,
            ),
          ),
        const Divider(height: 24.0),
        Text(LocaleKeys.animalComments.tr(), style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4.0),
        Text(
          widget.itemData?.prescription.description ?? '',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.0),
        ),
      ],
    );
  }

  Widget _buildExpandHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: (widget.itemData?.prescription.animal.name ?? ''),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextSpan(
                  text: ' ',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextSpan(
                  text: (widget.itemData?.prescription.animal.id ?? '').toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
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
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildType(BuildContext context) {
    return Text(
      widget.itemData?.prescription.typeString ?? '',
      style: Theme.of(context).textTheme.titleMedium,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTimeAction(BuildContext context) {
    return Row(
      children: [
        if (widget.itemData?.executeAt != null) Text(_formatter.format(widget.itemData!.executeAt)),
        const Spacer(),
        InkWell(
          onTap: _openBsActions,
          child: Icon(Icons.more_horiz, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  void _openBsActions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => bsSelectorActions(context, <Widget, dynamic Function()>{
        Text(
          LocaleKeys.commonDone.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
        ): () {
          Navigator.of(context).pop();
        },
        Text(
          LocaleKeys.commonReschedule.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
        ): () {
          Navigator.of(context).pop();
          _reschedule();
        },
        Text(
          LocaleKeys.commonNotCompleted.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
        ): () {
          Navigator.of(context).pop();
        },
        Text(
          LocaleKeys.commonEdit.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
        ): () {
          Navigator.of(context).pop();
          widget.onEditedPrescription?.call();
        },
        Text(
          LocaleKeys.commonDelete.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.error),
        ): () {
          Navigator.of(context).pop();
        },
      }),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Future<void> _reschedule() async {
    final now = DateTime.now();
    //TODO: reschedule request
    //ignore: unused_local_variable
    final result = showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(_reschedulePeriod),
    );
  }
}
