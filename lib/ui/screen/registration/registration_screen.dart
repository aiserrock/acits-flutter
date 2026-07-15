import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shimmer/shimmer.dart';

import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/ui/screen/registration/cubit/registration_cubit.dart';
import 'package:acits_flutter/ui/screen/registration/cubit/registration_state.dart';
import 'package:acits_flutter/ui/screen/search_screen/search.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:acits_flutter/ui/widget/success_holder.dart';
import 'package:acits_flutter/util/validator.dart';

const _termsUrl = 'https://app.acits.ru/privacy-policy';

/// Экран регистрации
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final RegistrationCubit _cubit;
  late final RegistrationFormControllers _forms;

  @override
  void initState() {
    super.initState();
    _cubit = RegistrationCubit();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _forms = RegistrationFormControllers(tabController: _tabController);
  }

  void _onTabChanged() {
    _cubit.onTabChanged(_tabController.index);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _forms.disposeControllers();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: RegistrationScope(
        forms: _forms,
        child: Scaffold(
          key: _forms.scaffoldKey,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shadowColor: Colors.transparent,
            title: Assets.image.logoBar.svg(),
            centerTitle: true,
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
              onTap: () => Navigator.of(context).pop(),
            ),
            bottom: _buildTabs(context),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: KeyboardDismissOnTap(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocSelector<RegistrationCubit, RegistrationState, int>(
                selector: (state) => state.tabIndex,
                builder: (_, tabIndex) {
                  final current = tabIndex == 0
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond;
                  return AnimatedCrossFade(
                    firstChild: const RegistrationOrgForm(),
                    secondChild: const RegistrationCustomerForm(),
                    crossFadeState: current,
                    duration: kTabScrollDuration,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildTabs(BuildContext context) {
    return TabBar(
      indicatorColor: Theme.of(context).colorScheme.primary,
      indicatorWeight: 4.0,
      tabs: [LocaleKeys.regOrg.tr(), LocaleKeys.regUser.tr()]
          .mapIndexed<Widget>(
            (index, tab) => BlocSelector<RegistrationCubit, RegistrationState, int>(
              selector: (state) => state.tabIndex,
              builder: (_, current) {
                return SizedBox(
                  height: kTextTabBarHeight,
                  child: Center(
                    child: Text(
                      tab,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: current == index
                            ? Theme.of(context).colorScheme.primary
                            : context.appColors.textSecondary,
                      ),
                      maxLines: 2,
                    ),
                  ),
                );
              },
            ),
          )
          .toList(),
      controller: _tabController,
    );
  }
}

/// Держатель UI-контроллеров экрана регистрации.
///
/// Живёт в [State] экрана и передаётся детям через [RegistrationScope].
/// Все [TextEditingController] и [TabController] диспозятся в
/// [disposeControllers], который вызывается из [State.dispose].
class RegistrationFormControllers {
  RegistrationFormControllers({required this.tabController});

  final TabController tabController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final orgUserForm = GlobalKey<FormState>();
  final orgForm = GlobalKey<FormState>();

  final customerForm = GlobalKey<FormState>();
  final customerRoleForm = GlobalKey<FormState>();

  /// Логин
  final orgLoginController = TextEditingController();

  /// Пароль
  final orgPassController = TextEditingController();

  /// Почта
  final orgEmailController = TextEditingController();

  /// Телефон
  final orgPhoneController = TextEditingController();
  final phoneFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  /// Фамилия
  final orgSNameController = TextEditingController();

  /// Имя
  final orgNameController = TextEditingController();

  /// Отчество
  final orgMNameController = TextEditingController();

  /// Название приюта
  final orgShelterNameController = TextEditingController();

  /// Страна
  final orgCountryNameController = TextEditingController();

  /// Область
  final orgRegionNameController = TextEditingController();

  /// Город
  final orgCityNameController = TextEditingController();

  /// Пароль
  final customerPassController = TextEditingController();

  /// Почта
  final customerEmailController = TextEditingController();

  /// Фамилия
  final customerSNameController = TextEditingController();

  /// Имя
  final customerNameController = TextEditingController();

  /// Диспозит все [TextEditingController]. Вызывается из [State.dispose].
  void disposeControllers() {
    orgLoginController.dispose();
    orgPassController.dispose();
    orgEmailController.dispose();
    orgPhoneController.dispose();
    orgSNameController.dispose();
    orgNameController.dispose();
    orgMNameController.dispose();
    orgShelterNameController.dispose();
    orgCountryNameController.dispose();
    orgRegionNameController.dispose();
    orgCityNameController.dispose();
    customerPassController.dispose();
    customerEmailController.dispose();
    customerSNameController.dispose();
    customerNameController.dispose();
  }

  /// Собрать модель администратора из введённых данных.
  UserShelterAdminSerializers buildAdmin() {
    return UserShelterAdminSerializers(
      email: orgEmailController.text,
      password: orgPassController.text,
      rePassword: orgPassController.text,
      firstName: orgNameController.text,
      lastName: orgSNameController.text,
      fathersName: orgMNameController.text,
      phoneNumber: orgPhoneController.text,
      address: '',
      isOfferSigned: true,
      shelter: ShelterSerializers(
        name: orgShelterNameController.text,
        country: orgCountryNameController.text,
        city: orgCityNameController.text,
        region: orgRegionNameController.text,
      ),
    );
  }

  /// Собрать модель кастомера из введённых данных.
  UserShelterWorkerSerializers buildCustomer({
    required ShelterShortSerializers? shelter,
    required CustomerRole role,
  }) {
    return UserShelterWorkerSerializers(
      shelter: shelter?.id,
      email: customerEmailController.text,
      password: customerPassController.text,
      rePassword: customerPassController.text,
      firstName: customerNameController.text,
      lastName: customerSNameController.text,
      fathersName: '',
      phoneNumber: '',
      address: '',
      isOfferSigned: true,
      role: role == CustomerRole.employer ? RoleEnum.worker : RoleEnum.guest,
    );
  }
}

/// [InheritedWidget], раздающий [RegistrationFormControllers] детям экрана.
class RegistrationScope extends InheritedWidget {
  const RegistrationScope({required this.forms, required super.child, super.key});

  final RegistrationFormControllers forms;

  static RegistrationFormControllers of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<RegistrationScope>();
    assert(scope != null, 'RegistrationScope not found in context');
    return scope!.forms;
  }

  @override
  bool updateShouldNotify(RegistrationScope oldWidget) => oldWidget.forms != forms;
}

/// Кнопка Зарегистрироваться
class RegistrationSubmitBtn extends StatelessWidget {
  const RegistrationSubmitBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RegistrationCubit, RegistrationState, bool>(
      selector: (state) => state.submitting,
      builder: (context, isLoading) {
        return !isLoading
            ? PrimaryButton(
                onPressed: () => _onSubmit(context),
                text: LocaleKeys.loginToRegistration.tr().toUpperCase(),
              )
            : Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.primary,
                highlightColor: Theme.of(context).colorScheme.surface,
                child: PrimaryButton(
                  onPressed: () {},
                  text: LocaleKeys.loginToRegistration.tr().toUpperCase(),
                ),
              );
      },
    );
  }

  Future<void> _onSubmit(BuildContext context) async {
    final cubit = context.read<RegistrationCubit>();
    final forms = RegistrationScope.of(context);
    final state = cubit.state;
    if (state.submitting) return;

    if (state.tabIndex == 0) {
      if (!(forms.orgUserForm.currentState?.validate() ?? false) ||
          !(forms.orgForm.currentState?.validate() ?? false)) {
        return;
      }
    } else {
      if (!(forms.customerForm.currentState?.validate() ?? false) ||
          !(forms.customerRoleForm.currentState?.validate() ?? false)) {
        return;
      }
    }

    if (!state.agreedToPolicy) {
      _showSnack(forms, LocaleKeys.regNeedConfirmPolicy.tr());
      return;
    }

    final navigator = Navigator.of(context);
    try {
      final bool success;
      if (state.tabIndex == 0) {
        success = await cubit.submitAdmin(forms.buildAdmin());
      } else {
        success = await cubit.submitCustomer(
          forms.buildCustomer(shelter: state.shelter, role: state.role),
        );
      }
      if (success) _onSuccess(navigator);
    } catch (e) {
      _showSnack(forms, e is MessagedException ? e.errorMessage() : e.toString());
    }
  }

  void _onSuccess(NavigatorState navigator) {
    navigator.pushReplacement(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: SafeArea(
            child: SuccessHolderWidget(
              onPressed: navigator.pop,
              title: LocaleKeys.regTUPtitle.tr(),
              message: LocaleKeys.regTUPmsg.tr(),
              button: LocaleKeys.commonClose.tr().toUpperCase(),
            ),
          ),
        ),
      ),
    );
  }

  void _showSnack(RegistrationFormControllers forms, String msg) {
    final ctx = forms.scaffoldKey.currentContext;
    if (ctx != null) {
      ScaffoldMessenger.maybeOf(ctx)?.showSnackBar(SnackBar(content: Text(msg)));
    }
  }
}

/// Кнопка Войти
class RegistrationLoginBtn extends StatelessWidget {
  const RegistrationLoginBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(LocaleKeys.regHaveAccount.tr()),
        Builder(
          builder: (context) {
            return MaterialButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                LocaleKeys.loginEntryBtn.tr(),
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            );
          },
        ),
      ],
    );
  }
}

/// переключатель персональных данных
class RegistrationPersonalData extends StatelessWidget {
  const RegistrationPersonalData({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocSelector<RegistrationCubit, RegistrationState, bool>(
          selector: (state) => state.agreedToPolicy,
          builder: (context, agreed) {
            return CupertinoButton(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
              onPressed: context.read<RegistrationCubit>().togglePersonData,
              child: AnimatedCrossFade(
                firstChild: Assets.icon.checkOn.svg(),
                secondChild: Assets.icon.checkOff.svg(),
                crossFadeState: agreed ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: kTabScrollDuration,
              ),
            );
          },
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: LocaleKeys.regAgreePersonalDataPart0.tr()),
                TextSpan(
                  text: LocaleKeys.regAgreePersonalDataPart1.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = _onPrivateTermsPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onPrivateTermsPressed() {
    // url_launcher вместо flutter_web_browser (нет web-поддержки). На web
    // открывает новую вкладку, на мобильных — внешний браузер.
    launchUrl(Uri.parse(_termsUrl), mode: LaunchMode.externalApplication);
  }
}

/// Форма ввода данных при регистрации организации
class RegistrationOrgForm extends StatelessWidget {
  const RegistrationOrgForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 40.0),
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(LocaleKeys.regAboutYou.tr(), style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 16.0),
          Card(
            child: Padding(padding: const EdgeInsets.all(16.0), child: _buildUserForm(context)),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(LocaleKeys.regAboutOrg.tr(), style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 16.0),
          Card(
            child: Padding(padding: const EdgeInsets.all(16.0), child: _buildOrgForm(context)),
          ),
          const SizedBox(height: 16.0),
          const RegistrationPersonalData(),
          const SizedBox(height: 16.0),
          const RegistrationSubmitBtn(),
          const SizedBox(height: 16.0),
          const RegistrationLoginBtn(),
          const SizedBox(height: 16.0),
          Text(LocaleKeys.loginDescribeMsg.tr(), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildUserForm(BuildContext context) {
    final forms = RegistrationScope.of(context);
    return Form(
      key: forms.orgUserForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.regAdminRegMsg.tr(), style: Theme.of(context).textTheme.bodyMedium),
          TextFormField(
            controller: forms.orgLoginController,
            decoration: InputDecoration(
              labelText: '${LocaleKeys.loginLoginLabel.tr()} *',
              hintText: LocaleKeys.regPassSymbols.tr(),
            ),
            validator: Validator.emptyValidatorMsg(LocaleKeys.regFieldEmptyError.tr()),
          ),
          TextFormField(
            controller: forms.orgPassController,
            decoration: InputDecoration(labelText: '${LocaleKeys.loginPassLabel.tr()} *'),
            validator: Validator.emptyValidatorMsg(LocaleKeys.regLeast8Symbols.tr()),
          ),
          TextFormField(
            controller: forms.orgEmailController,
            decoration: InputDecoration(
              labelText: '${LocaleKeys.animalCuratorEmail.tr()} *',
              hintText: 'example@mail.ru',
            ),
            validator: Validator.emailValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: forms.orgPhoneController,
            decoration: InputDecoration(
              labelText: LocaleKeys.animalCuratorPhone.tr(),
              hintText: LocaleKeys.regPhoneMask.tr(),
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [forms.phoneFormatter],
          ),
          TextFormField(
            controller: forms.orgSNameController,
            decoration: InputDecoration(
              labelText: '${LocaleKeys.animalCuratorLastName.tr()} *',
              hintText: 'Иванов',
            ),
            validator: Validator.emptyValidatorMsg(LocaleKeys.regFieldEmptyError.tr()),
          ),
          TextFormField(
            controller: forms.orgNameController,
            decoration: InputDecoration(
              labelText: '${LocaleKeys.animalCuratorName.tr()} *',
              hintText: 'Иван',
            ),
            validator: Validator.emptyValidatorMsg(LocaleKeys.regFieldEmptyError.tr()),
          ),
          TextFormField(
            controller: forms.orgMNameController,
            decoration: InputDecoration(
              labelText: LocaleKeys.regFathersName.tr(),
              hintText: 'Иванович',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrgForm(BuildContext context) {
    final forms = RegistrationScope.of(context);
    return Form(
      key: forms.orgForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: forms.orgLoginController,
            decoration: InputDecoration(labelText: LocaleKeys.regOrgName.tr()),
            validator: Validator.emptyValidatorMsg(LocaleKeys.regFieldEmptyError.tr()),
          ),
          TextFormField(
            controller: forms.orgCountryNameController,
            decoration: InputDecoration(
              labelText: LocaleKeys.regCountry.tr(),
              hintText: LocaleKeys.regWriteCountry.tr(),
            ),
            validator: Validator.emptyValidatorMsg(LocaleKeys.regFieldEmptyError.tr()),
          ),
          TextFormField(
            controller: forms.orgRegionNameController,
            decoration: InputDecoration(
              labelText: LocaleKeys.regRegion.tr(),
              hintText: LocaleKeys.regWriteRegion.tr(),
            ),
          ),
          TextFormField(
            controller: forms.orgCityNameController,
            decoration: InputDecoration(
              labelText: LocaleKeys.regCity.tr(),
              hintText: LocaleKeys.regWriteCity.tr(),
            ),
            validator: Validator.emptyValidatorMsg(LocaleKeys.regFieldEmptyError.tr()),
          ),
        ],
      ),
    );
  }
}

/// Форма ввода данных при регистрации кастомера
class RegistrationCustomerForm extends StatelessWidget {
  const RegistrationCustomerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 40.0),
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(LocaleKeys.regAboutYou.tr(), style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 16.0),
          Card(
            child: Padding(padding: const EdgeInsets.all(16.0), child: _buildCustomerForm(context)),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(LocaleKeys.regAboutOrg.tr(), style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 16.0),
          _buildCustomerRoleForm(context),
          const SizedBox(height: 16.0),
          const RegistrationPersonalData(),
          const SizedBox(height: 16.0),
          const RegistrationSubmitBtn(),
          const SizedBox(height: 16.0),
          const RegistrationLoginBtn(),
          const SizedBox(height: 16.0),
          Text(LocaleKeys.loginDescribeMsg.tr(), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildCustomerForm(BuildContext context) {
    final forms = RegistrationScope.of(context);
    return Form(
      key: forms.customerForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: forms.customerEmailController,
            decoration: InputDecoration(
              labelText: '${LocaleKeys.animalCuratorEmail.tr()} *',
              hintText: 'example@mail.ru',
            ),
            validator: Validator.emailValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: forms.customerPassController,
            decoration: InputDecoration(labelText: '${LocaleKeys.loginPassLabel.tr()} *'),
            validator: Validator.emptyValidatorMsg(LocaleKeys.regFieldEmptyError.tr()),
          ),
          TextFormField(
            controller: forms.customerSNameController,
            decoration: InputDecoration(
              labelText: '${LocaleKeys.animalCuratorLastName.tr()} *',
              hintText: 'Иванов',
            ),
            validator: Validator.emptyValidatorMsg(LocaleKeys.regFieldEmptyError.tr()),
          ),
          TextFormField(
            controller: forms.customerNameController,
            decoration: InputDecoration(
              labelText: '${LocaleKeys.animalCuratorName.tr()} *',
              hintText: 'Иван',
            ),
            validator: Validator.emptyValidatorMsg(LocaleKeys.regFieldEmptyError.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerRoleForm(BuildContext context) {
    final forms = RegistrationScope.of(context);
    return Form(
      key: forms.customerRoleForm,
      child: Builder(
        builder: (context) {
          return BlocBuilder<RegistrationCubit, RegistrationState>(
            builder: (_, state) {
              return FormEditCard(
                [
                  EditCardData(
                    label: LocaleKeys.regUserRole.tr(),
                    content: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: CupertinoSlidingSegmentedControl(
                          groupValue: state.role,
                          children: <CustomerRole, Widget>{
                            CustomerRole.employer: Text(CustomerRole.employer.value),
                            CustomerRole.guest: Text(CustomerRole.guest.value),
                          },
                          onValueChanged: context.read<RegistrationCubit>().onCustomerRoleChanged,
                          backgroundColor: context.appColors.indicatorActive,
                        ),
                      ),
                    ),
                  ),
                  EditCardData(
                    label: LocaleKeys.shelterSelectShelter.tr(),
                    initValue: state.shelter?.name,
                    suffix: Icon(
                      Icons.menu_open_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => _pickShelter(context),
                    validator: Validator.emptyValidatorMsg(LocaleKeys.regFieldEmptyError.tr()),
                  ),
                ],
                key: UniqueKey(),
                padding: const EdgeInsets.only(),
                margin: const EdgeInsets.all(16.0),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _pickShelter(BuildContext context) async {
    final cubit = context.read<RegistrationCubit>();
    final shelter = await context.push<ShelterShortSerializers>(
      AppRoutes.searchPath(SearchTypeKey.shelter),
    );
    if (shelter != null) cubit.setShelter(shelter);
  }
}

extension CustomerRoleX on CustomerRole {
  String get value =>
      this == CustomerRole.employer ? LocaleKeys.regEmployee.tr() : LocaleKeys.regGuest.tr();
}

extension _MessagedExceptionX on MessagedException {
  String errorMessage() {
    final msg = message;
    if (msg != null) return msg;
    final errMsg = error;
    if (errMsg is String) return errMsg;
    return LocaleKeys.errorDefaultMsg.tr();
  }
}
