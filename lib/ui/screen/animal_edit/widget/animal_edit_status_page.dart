import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/animal_edit/data/animal_edit_data_holder.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/subtitle_widget.dart';
import 'package:acits_flutter/ui/widget/action_bs.dart';
import 'package:acits_flutter/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _dateFormatter = DateFormat('dd.MM.yyyy');
const _receipeDateRange = Duration(days: 365);

class AnimalEditStatusPage extends AnimalEditPage {
  const AnimalEditStatusPage({
    required super.animal,
    required super.isEdit,
    required GlobalKey<FormState> super.formKey,
    super.key,
  });

  @override
  State<AnimalEditStatusPage> createState() => _AnimalEditStatusPageState();
}

class _AnimalEditStatusPageState extends State<AnimalEditStatusPage> with AnimalPageHolderListener {
  final _dateReceiptController = TextEditingController();
  final _statusController = TextEditingController();
  final _catchController = TextEditingController();
  Status69fEnum? status;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    _setControllers(widget.animal);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addPageListener(context);
  }

  @override
  void dispose() {
    removePageListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
        SliverToBoxAdapter(child: SubtitleWidget(title: LocaleKeys.animalStatusAndJoin.tr())),
        SliverToBoxAdapter(child: _buildStatusCard()),
      ],
    );
  }

  Widget _buildStatusCard() {
    return Builder(
      builder: (context) {
        return Form(
          key: widget.formKey,
          child: FormEditCard([
            EditCardData(
              label: '${LocaleKeys.animalDateAdmitt.tr()} *',
              controller: _dateReceiptController,
              suffix: Icon(
                Icons.calendar_today_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => _setDate(context),
              validator: Validator.emptyValidator,
            ),
            EditCardData(
              label: '${LocaleKeys.animalAnimalStatus.tr()} *',
              controller: _statusController,
              suffix: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => _setStatus(context),
              validator: Validator.emptyValidator,
            ),
            EditCardData(
              label: '${LocaleKeys.animalCatchPlace.tr()} *',
              controller: _catchController,
              validator: Validator.emptyValidator,
            ),
          ]),
        );
      },
    );
  }

  Future<void> _setStatus(BuildContext context) async {
    Map<Widget, dynamic Function()> actionsMap(BuildContext ctx) {
      final entries = Status69fEnum.values
          .where((status) => status.statusString != null)
          .map<MapEntry<Widget, dynamic Function()>>(
            (status) => MapEntry(
              Text(
                status.statusString ?? '',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              () {
                _statusController.text = status.statusString ?? '';
                this.status = status;
                Navigator.of(ctx).pop();
              },
            ),
          );
      return <Widget, dynamic Function()>{for (final item in entries) item.key: item.value};
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (ctx) => bsSelectorActions(ctx, actionsMap(ctx)),
    );
  }

  Future<void> _setDate(BuildContext context) async {
    final now = DateTime.now();
    final result = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(_receipeDateRange),
      lastDate: now,
    );
    if (result != null) {
      date = result;
      _dateReceiptController.text = _dateFormatter.format(result);
    }
  }

  void _setControllers(AnimalRead value) {
    _dateReceiptController.text = _dateFormatter.format(value.dateJoined);
    _statusController.text = value.statusString ?? '';
    _catchController.text = value.placeOfCatch;
  }

  @override
  void onChangePage() {
    if (page != 1) return;
    Provider.of<AnimalEditHolder>(
      context,
      listen: false,
    ).copyWith(dateJoined: date, status: status, placeOfCatch: _catchController.text);
  }
}
