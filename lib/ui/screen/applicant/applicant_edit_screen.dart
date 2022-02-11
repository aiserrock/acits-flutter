import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/staff/staff_service.dart';
import 'package:acits_flutter/ui/screen/animal_edit/widget/animal_edit_card.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

/// Экран создания или редактирования куратора
class ApplicantEditScreen extends StatefulWidget {
  const ApplicantEditScreen({
    this.applicantId,
    Key? key,
  }) : super(key: key);

  final int? applicantId;

  @override
  State<ApplicantEditScreen> createState() => _ApplicantEditScreenState();
}

class _ApplicantEditScreenState extends State<ApplicantEditScreen> {
  late final StaffService _service;
  late final NavigatorState _navigator;

  late bool _isEdit;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _socialController = TextEditingController();

  WidgetState<Applicant?> _state = WidgetState<Applicant?>()..content(Applicant());

  @override
  void initState() {
    super.initState();
    _service = getIt<StaffService>();
    _isEdit = widget.applicantId != null;
    _init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigator = Navigator.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(),
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorRes.accent,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _isEdit ? StringRes.current.applicantEdit : StringRes.current.applicantAdd,
          style: const TextStyle(color: ColorRes.textPrimary),
        ),
        centerTitle: true,
      ),
      floatingActionButton: _state.isContent
          ? FloatingActionButton(
              child: const Icon(
                Icons.done_all,
                color: Colors.white,
              ),
              onPressed: _onSubmit,
              backgroundColor: ColorRes.accent,
            )
          : null,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return KeyboardDismissOnTap(
      child: SafeArea(
        child: StateBuilder<Applicant?>(
          state: _state,
          loader: (_) => const LoadingWidget(),
          errorBuilder: (_, e) => ErrorHolderWidget(error: e),
          builder: (_, __) => _buildApplicantCard(),
        ),
      ),
    );
  }

  Widget _buildApplicantCard() {
    return Column(
      children: [
        Form(
          key: formKey,
          child: AnimalEditCard(
            [
              EditCardData(
                label: StringRes.current.animalCuratorName + ' *',
                controller: _nameController,
                validator: Validator.emptyValidator,
              ),
              EditCardData(
                label: StringRes.current.animalCuratorLastName,
                controller: _lastNameController,
              ),
              EditCardData(
                label: StringRes.current.animalCuratorPhone + ' *',
                controller: _phoneController,
                validator: Validator.emptyValidator,
              ),
              EditCardData(
                label: StringRes.current.animalSocialLink,
                controller: _socialController,
              ),
              EditCardData(
                label: StringRes.current.animalCuratorEmail,
                controller: _emailController,
                validator: Validator.emailOrEmptyValidator,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _init() async {
    if (!_isEdit) return;
    _state = WidgetState<Applicant>()..loading();
    await _service.fetchApplicantById(id: widget.applicantId!).then((value) {
      _setControllers(value);
      setState(() => _state = WidgetState()..content(value));
    }).catchError((e) {
      setState(() => _state = WidgetState().error = e);
    });
  }

  void _setControllers(Applicant? applicant) {
    _nameController.text = applicant?.firstName ?? '';
    _lastNameController.text = applicant?.lastName ?? '';
    _emailController.text = applicant?.email ?? '';
    _phoneController.text = applicant?.phoneNumber ?? '';
    _socialController.text = applicant?.contactDetails ?? '';
  }

  Future<void> _onSubmit() async {
    if (_state.isLoading) return;
    if (!(formKey.currentState?.validate() ?? false)) return;
    final applicant = (_state.value ?? Applicant()).copyWith(
      firstName: _nameController.text,
      lastName: _lastNameController.text,
      phoneNumber: _phoneController.text,
      contactDetails: _socialController.text,
      email: _emailController.text,
    );
    setState(() => _state = WidgetState<Applicant>()..loading());
    Applicant? result;
    if (_isEdit) {
      result = await _service
          .updateApplicant(
        id: widget.applicantId!,
        applicant: applicant,
      )
          .catchError(
        (e) {
          setState(() => _state = WidgetState()..error = e);
        },
      );
    } else {
      result = await _service
          .createApplicant(
        applicant: applicant,
      )
          .catchError(
        (e) {
          setState(() => _state = WidgetState()..error = e);
        },
      );
    }
    if (result != null) _navigator.pop(result);
  }
}
