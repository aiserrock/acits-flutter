import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/applicant/cubit/applicant_edit_cubit.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

/// Экран создания или редактирования куратора
class ApplicantEditScreen extends StatelessWidget {
  const ApplicantEditScreen({this.applicantId, super.key});

  final int? applicantId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApplicantEditCubit(applicantId: applicantId),
      child: const _ApplicantEditView(),
    );
  }
}

class _ApplicantEditView extends StatefulWidget {
  const _ApplicantEditView();

  @override
  State<_ApplicantEditView> createState() => _ApplicantEditViewState();
}

class _ApplicantEditViewState extends State<_ApplicantEditView> {
  late final NavigatorState _navigator;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _socialController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigator = Navigator.of(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _socialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ApplicantEditCubit>();
    return BlocConsumer<ApplicantEditCubit, DataState<Applicant>>(
      listenWhen: (prev, next) => !prev.isContent && next.isContent,
      listener: (_, state) => _setControllers(state.valueOrNull),
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          drawer: const Drawer(),
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shadowColor: Colors.transparent,
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
              onTap: () => Navigator.of(context).pop(),
            ),
            title: Text(
              cubit.isEdit ? LocaleKeys.applicantEdit.tr() : LocaleKeys.applicantAdd.tr(),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            centerTitle: true,
          ),
          floatingActionButton: state.isContent
              ? FloatingActionButton(
                  onPressed: _onSubmit,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Icon(Icons.done_all, color: Theme.of(context).colorScheme.onPrimary),
                )
              : null,
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(DataState<Applicant> state) {
    return KeyboardDismissOnTap(
      child: SafeArea(
        child: DataStateBuilder<Applicant>(
          state: state,
          loader: (_) => const LoaderHolderWidget(),
          errorBuilder: (_, e) => ErrorHolderWidget(error: e),
          builder: (_, _) => _buildApplicantCard(),
        ),
      ),
    );
  }

  Widget _buildApplicantCard() {
    return Column(
      children: [
        Form(
          key: formKey,
          child: FormEditCard([
            EditCardData(
              label: '${LocaleKeys.animalCuratorName.tr()} *',
              controller: _nameController,
              validator: Validator.emptyValidator,
            ),
            EditCardData(
              label: '${LocaleKeys.animalCuratorLastName.tr()} *',
              controller: _lastNameController,
              validator: Validator.emptyValidator,
            ),
            EditCardData(
              label: '${LocaleKeys.animalCuratorPhone.tr()} *',
              controller: _phoneController,
              validator: Validator.emptyValidator,
            ),
            EditCardData(label: LocaleKeys.animalSocialLink.tr(), controller: _socialController),
            EditCardData(
              label: LocaleKeys.animalCuratorEmail.tr(),
              controller: _emailController,
              validator: Validator.emailOrEmptyValidator,
            ),
          ]),
        ),
      ],
    );
  }

  void _setControllers(Applicant? applicant) {
    _nameController.text = applicant?.firstName ?? '';
    _lastNameController.text = applicant?.lastName ?? '';
    _emailController.text = applicant?.email ?? '';
    _phoneController.text = applicant?.phoneNumber ?? '';
    _socialController.text = applicant?.contactDetails ?? '';
  }

  Future<void> _onSubmit() async {
    final cubit = context.read<ApplicantEditCubit>();
    if (cubit.state.isLoading) return;
    if (!(formKey.currentState?.validate() ?? false)) return;
    final applicant = (cubit.state.valueOrNull ?? const Applicant(firstName: '', lastName: '', phoneNumber: ''))
        .copyWith(
          firstName: _nameController.text,
          lastName: _lastNameController.text,
          phoneNumber: _phoneController.text,
          contactDetails: _socialController.text,
          email: _emailController.text,
        );
    final result = await cubit.submit(applicant);
    if (result != null && mounted) _navigator.pop(result);
  }
}
