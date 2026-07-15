import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/curator/cubit/curator_edit_cubit.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

/// Экран создания или редактирования куратора
class CuratorEditScreen extends StatelessWidget {
  const CuratorEditScreen({this.curatorId, super.key});

  final int? curatorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CuratorEditCubit(curatorId: curatorId),
      child: const _CuratorEditView(),
    );
  }
}

class _CuratorEditView extends StatefulWidget {
  const _CuratorEditView();

  @override
  State<_CuratorEditView> createState() => _CuratorEditViewState();
}

class _CuratorEditViewState extends State<_CuratorEditView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  /// Идентификатор куратора, чьи данные уже загружены в контроллеры.
  /// Нужен, чтобы не перезатирать пользовательский ввод на каждом ребилде.
  Object? _syncedContent;

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CuratorEditCubit>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Text(
          cubit.isEdit ? LocaleKeys.curatorEdit.tr() : LocaleKeys.curatorAdd.tr(),
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      floatingActionButton: BlocBuilder<CuratorEditCubit, DataState<Curator>>(
        builder: (context, state) => state.isContent
            ? FloatingActionButton(
                onPressed: _onSubmit,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Icon(Icons.done_all, color: Theme.of(context).colorScheme.onPrimary),
              )
            : const SizedBox.shrink(),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return KeyboardDismissOnTap(
      child: SafeArea(
        child: BlocBuilder<CuratorEditCubit, DataState<Curator>>(
          builder: (context, state) => DataStateBuilder<Curator>(
            state: state,
            loader: (_) => const LoaderHolderWidget(),
            errorBuilder: (_, error) => const SizedBox.shrink(),
            builder: (_, curator) {
              _setControllers(curator);
              return _buildCuratorCard();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCuratorCard() {
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
              label: LocaleKeys.animalCuratorLastName.tr(),
              controller: _lastNameController,
            ),
            EditCardData(
              label: '${LocaleKeys.animalCuratorPhone.tr()} *',
              controller: _phoneController,
              validator: Validator.emptyValidator,
            ),
            EditCardData(label: LocaleKeys.animalCuratorEmail.tr(), controller: _emailController),
            EditCardData(
              label: LocaleKeys.animalCuratorAddress.tr(),
              controller: _addressController,
            ),
          ]),
        ),
      ],
    );
  }

  void _setControllers(Curator? curator) {
    // Синхронизируем поля один раз на каждое новое содержимое, иначе
    // ребилд затирал бы ввод пользователя.
    if (identical(_syncedContent, curator)) return;
    _syncedContent = curator;
    _nameController.text = curator?.firstName ?? '';
    _lastNameController.text = curator?.lastName ?? '';
    _emailController.text = curator?.email ?? '';
    _phoneController.text = curator?.phoneNumber ?? '';
    _addressController.text = curator?.address ?? '';
  }

  Future<void> _onSubmit() async {
    final cubit = context.read<CuratorEditCubit>();
    if (cubit.state.isLoading) return;
    if (!(formKey.currentState?.validate() ?? false)) return;
    final draft =
        (cubit.state.valueOrNull ??
                const Curator(firstName: '', lastName: '', phoneNumber: '', address: ''))
            .copyWith(
              firstName: _nameController.text,
              lastName: _lastNameController.text,
              phoneNumber: _phoneController.text,
              address: _addressController.text,
              email: _emailController.text,
            );
    final result = await cubit.submit(draft);
    if (result != null && mounted) Navigator.of(context).pop(result);
  }
}
