import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_card.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_page.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/subtitle_widget.dart';
import 'package:acits_flutter/ui/widget/action_bs.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _dateFormatter = DateFormat('dd.MM.yyyy');
const _receipeDateRange = Duration(days: 365);


class AnimalEditStatusPage extends AnimalEditPage {
  const AnimalEditStatusPage({
    required Animal animal,
    required bool isEdit,
    required void Function(bool isValid) validate,
    Key? key,
  }) : super(
          isEdit: isEdit,
          animal: animal,
          validate: validate,
          key: key,
        );

  @override
  State<AnimalEditStatusPage> createState() => _AnimalEditStatusPageState();
}

class _AnimalEditStatusPageState extends State<AnimalEditStatusPage> {
  final _dateReceiptController = TextEditingController();
  final _statusController = TextEditingController();
  final _catchController = TextEditingController();
  Status131Enum? status;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    _setControllers(widget.animal);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
        SliverToBoxAdapter(
          child: SubtitleWidget(title: StringRes.current.animalStatusAndJoin),
        ),
        SliverToBoxAdapter(
          child: _buildStatusCard(),
        ),
      ],
    );
  }

  Widget _buildStatusCard() {
    return AnimalEditCard(
      [
        EditCardData(
          label: StringRes.current.animalDateAdmitt + ' *',
          controller: _dateReceiptController,
          suffix: const Icon(
            Icons.calendar_today_outlined,
            color: ColorRes.accent,
          ),
          onPressed: _setData,
        ),
        EditCardData(
          label: StringRes.current.animalAnimalStatus + ' *',
          controller: _statusController,
          suffix: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: ColorRes.accent,
          ),
          onPressed: _setStatus,
        ),
        EditCardData(
          label: StringRes.current.animalCatchPlace + ' *',
          controller: _catchController,
        ),
      ],
    );
  }

  Future<void> _setStatus() async {
    Map<Widget, dynamic Function()> actionsMap(BuildContext ctx) {
      final entries = Status131Enum.values
          .where((status) => status.statusString != null)
          .map<MapEntry<Widget, dynamic Function()>>(
            (status) => MapEntry(
              Text(
                status.statusString ?? '',
                style: StyleRes.mainContent.copyWith(color: ColorRes.accent),
              ),
              () {
                _statusController.text = status.statusString ?? '';
                status = status;
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
      builder: (ctx) => bsSelectorActions(
        ctx,
        actionsMap(ctx),
      ),
    );
  }

  Future<void> _setData() async {
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

  void _setControllers(Animal value) {
    _dateReceiptController.text =
        value.dateJoined != null ? _dateFormatter.format(value.dateJoined!) : '';
    _statusController.text = value.statusString ?? '';
    _catchController.text = value.placeOfCatch ?? '';
  }
}
