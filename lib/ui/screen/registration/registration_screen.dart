import 'package:acits_flutter/ui/widget/form_edit_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shimmer/shimmer.dart';

import 'package:acits_flutter/ui/screen/registration/registration_screen_controller.dart';
import 'package:acits_flutter/util/validator.dart';
import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:acits_flutter/export.dart';

/// Экран регистрации
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with TickerProviderStateMixin {
  final loginFormKey = GlobalKey<FormState>();
  final passNode = FocusNode();
  final loginController = TextEditingController();
  final passController = TextEditingController();

  RegistrationScreenController get controller => RegistrationScreenController.controller;

  @override
  void initState() {
    getIt.pushNewScope(
      scopeName: l10n.regTitle,
      init: (getIt) {
        getIt.registerSingleton<RegistrationScreenController>(
          RegistrationScreenController(
            vsync: this,
          ),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    getIt.popScope();
    controller.dispose();

    loginController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        title: Assets.image.logoBar.svg(),
        centerTitle: true,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorRes.accent,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        bottom: _buildTabs(),
      ),
      backgroundColor: ColorRes.background,
      body: KeyboardDismissOnTap(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder<int>(
              stream: controller.tabState,
              builder: (_, data) {
                final current =
                    (data.data ?? 0) == 0 ? CrossFadeState.showFirst : CrossFadeState.showSecond;
                return AnimatedCrossFade(
                  firstChild: const RegistrationOrgForm(),
                  secondChild: const RegistrationCustomerForm(),
                  crossFadeState: current,
                  duration: kTabScrollDuration,
                );
              }),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildTabs() {
    return TabBar(
      indicatorColor: ColorRes.accent,
      indicatorWeight: 4.0,
      tabs: [l10n.regOrg, l10n.regUser]
          .mapIndexed<Widget>(
            (index, tab) => StreamBuilder<int>(
                stream: controller.tabState,
                builder: (_, data) {
                  final current = data.data;
                  return SizedBox(
                    height: kTextTabBarHeight,
                    child: Center(
                      child: Text(
                        tab,
                        style: StyleRes.content.copyWith(
                          color: current == index ? ColorRes.accent : ColorRes.textSecondary,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  );
                }),
          )
          .toList(),
      controller: controller.tabController,
    );
  }
}

/// Кнопка Зарегистрироваться
class RegistrationSubmitBtn extends StatelessWidget {
  const RegistrationSubmitBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WidgetState>(
      stream: controller.screenState,
      builder: (_, state) {
        final isLoading = state.data?.isLoading ?? false;
        return !isLoading
            ? PrimaryButton(
                onPressed: () => controller.onSubmit(context),
                text: l10n.loginToRegistration.toUpperCase(),
              )
            : Shimmer.fromColors(
                baseColor: ColorRes.accent,
                highlightColor: ColorRes.background,
                child: PrimaryButton(
                  onPressed: () => controller.onSubmit,
                  text: l10n.loginToRegistration.toUpperCase(),
                ),
              );
      },
    );
  }

  RegistrationScreenController get controller => RegistrationScreenController.controller;
}

/// Кнопка Войти
class RegistrationLoginBtn extends StatelessWidget {
  const RegistrationLoginBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.regHaveAccount,
        ),
        Builder(builder: (context) {
          return MaterialButton(
            onPressed: () => controller.onLoginPressed(context),
            child: const Text(
              'Войти',
              style: TextStyle(
                color: ColorRes.accent,
              ),
            ),
          );
        }),
      ],
    );
  }

  RegistrationScreenController get controller => RegistrationScreenController.controller;
}

/// переключатель персональных данных
class RegistrationPersonalData extends StatelessWidget {
  const RegistrationPersonalData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder<bool>(
            stream: controller.privateState,
            builder: (_, state) {
              return CupertinoButton(
                padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                onPressed: controller.togglePersonData,
                child: AnimatedCrossFade(
                  firstChild: Assets.icon.checkOn.svg(),
                  secondChild: Assets.icon.checkOff.svg(),
                  crossFadeState:
                      state.data ?? false ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  duration: kTabScrollDuration,
                ),
              );
            }),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: l10n.regAgreePersonalDataPart0),
                TextSpan(
                    text: l10n.regAgreePersonalDataPart1,
                    style: StyleRes.content.copyWith(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = controller.onPrivateTermsPressed),
              ],
            ),
          ),
        ),
      ],
    );
  }

  RegistrationScreenController get controller => RegistrationScreenController.controller;
}

/// Форма ввода данных при регистрации организации
class RegistrationOrgForm extends StatelessWidget {
  const RegistrationOrgForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 40.0),
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.regAboutYou,
              style: StyleRes.title,
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildUserForm(),
            ),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.regAboutOrg,
              style: StyleRes.title,
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildOrgForm(),
            ),
          ),
          const SizedBox(height: 16.0),
          const RegistrationPersonalData(),
          const SizedBox(height: 16.0),
          const RegistrationSubmitBtn(),
          const SizedBox(height: 16.0),
          const RegistrationLoginBtn(),
          const SizedBox(height: 16.0),
          Text(
            l10n.loginDescribeMsg,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUserForm() {
    return Form(
      key: controller.orgUserForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.regAdminRegMsg,
            style: StyleRes.content,
          ),
          TextFormField(
            controller: controller.orgLoginController,
            decoration: InputDecoration(
              labelText: '${l10n.loginLoginLabel} *',
              hintText: l10n.regPassSymbols,
            ),
            validator: Validator.emptyValidatorMsg(l10n.regFieldEmptyError),
          ),
          TextFormField(
            controller: controller.orgPassController,
            decoration: InputDecoration(
              labelText: '${l10n.loginPassLabel} *',
            ),
            validator: Validator.emptyValidatorMsg(l10n.regLeast8Symbols),
          ),
          TextFormField(
            controller: controller.orgEmailController,
            decoration: InputDecoration(
              labelText: '${l10n.animalCuratorEmail} *',
              hintText: 'example@mail.ru',
            ),
            validator: Validator.emailValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: controller.orgPhoneController,
            decoration: InputDecoration(
              labelText: l10n.animalCuratorPhone,
              hintText: l10n.regPhoneMask,
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [controller.phoneFormatter],
          ),
          TextFormField(
            controller: controller.orgSNameController,
            decoration: InputDecoration(
              labelText: '${l10n.animalCuratorLastName} *',
              hintText: 'Иванов',
            ),
            validator: Validator.emptyValidatorMsg(l10n.regFieldEmptyError),
          ),
          TextFormField(
            controller: controller.orgNameController,
            decoration: InputDecoration(
              labelText: '${l10n.animalCuratorName} *',
              hintText: 'Иван',
            ),
            validator: Validator.emptyValidatorMsg(l10n.regFieldEmptyError),
          ),
          TextFormField(
            controller: controller.orgMNameController,
            decoration: InputDecoration(
              labelText: l10n.regFathersName,
              hintText: 'Иванович',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrgForm() {
    return Form(
      key: controller.orgForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller.orgLoginController,
            decoration: InputDecoration(
              labelText: l10n.regOrgName,
            ),
            validator: Validator.emptyValidatorMsg(l10n.regFieldEmptyError),
          ),
          TextFormField(
            controller: controller.orgCountryNameController,
            decoration: InputDecoration(
              labelText: l10n.regCountry,
              hintText: l10n.regWriteCountry,
            ),
            validator: Validator.emptyValidatorMsg(l10n.regFieldEmptyError),
          ),
          TextFormField(
            controller: controller.orgRegionNameController,
            decoration: InputDecoration(
              labelText: l10n.regRegion,
              hintText: l10n.regWriteRegion,
            ),
          ),
          TextFormField(
            controller: controller.orgCityNameController,
            decoration: InputDecoration(
              labelText: l10n.regCity,
              hintText: l10n.regWriteCity,
            ),
            validator: Validator.emptyValidatorMsg(l10n.regFieldEmptyError),
          ),
        ],
      ),
    );
  }

  RegistrationScreenController get controller => RegistrationScreenController.controller;
}

/// Форма ввода данных при регистрации организации
class RegistrationCustomerForm extends StatelessWidget {
  const RegistrationCustomerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 40.0),
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.regAboutYou,
              style: StyleRes.title,
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildCustomerForm(),
            ),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.regAboutOrg,
              style: StyleRes.title,
            ),
          ),
          const SizedBox(height: 16.0),
          _buildCustomerRoleForm(),
          const SizedBox(height: 16.0),
          const RegistrationPersonalData(),
          const SizedBox(height: 16.0),
          const RegistrationSubmitBtn(),
          const SizedBox(height: 16.0),
          const RegistrationLoginBtn(),
          const SizedBox(height: 16.0),
          Text(
            l10n.loginDescribeMsg,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerForm() {
    return Form(
      key: controller.customerForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller.customerEmailController,
            decoration: InputDecoration(
              labelText: '${l10n.animalCuratorEmail} *',
              hintText: 'example@mail.ru',
            ),
            validator: Validator.emailValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: controller.customerPassController,
            decoration: InputDecoration(
              labelText: '${l10n.loginPassLabel} *',
            ),
            validator: Validator.emptyValidatorMsg(l10n.regFieldEmptyError),
          ),
          TextFormField(
            controller: controller.customerSNameController,
            decoration: InputDecoration(
              labelText: '${l10n.animalCuratorLastName} *',
              hintText: 'Иванов',
            ),
            validator: Validator.emptyValidatorMsg(l10n.regFieldEmptyError),
          ),
          TextFormField(
            controller: controller.customerNameController,
            decoration: InputDecoration(
              labelText: '${l10n.animalCuratorName} *',
              hintText: 'Иван',
            ),
            validator: Validator.emptyValidatorMsg(l10n.regFieldEmptyError),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerRoleForm() {
    return Form(
      key: controller.customerRoleForm,
      child: Builder(builder: (context) {
        return StreamBuilder<ShelterShortSerializers>(
            stream: controller.shelterState,
            builder: (_, shelter) {
              return FormEditCard(
                [
                  EditCardData(
                    label: l10n.regUserRole,
                    content: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: StreamBuilder<CustomerRole>(
                            stream: controller.customerRoleState,
                            builder: (_, data) {
                              final role = data.data ?? CustomerRole.employer;
                              return CupertinoSlidingSegmentedControl(
                                groupValue: role,
                                children: <CustomerRole, Widget>{
                                  CustomerRole.employer: Text(CustomerRole.employer.value),
                                  CustomerRole.guest: Text(CustomerRole.guest.value),
                                },
                                onValueChanged: controller.onCustomerRoleChanged,
                                backgroundColor: ColorRes.indicatorActive,
                              );
                            }),
                      ),
                    ),
                  ),
                  EditCardData(
                    label: l10n.shelterSelectShelter,
                    initValue: shelter.data?.name,
                    suffix: const Icon(
                      Icons.menu_open_rounded,
                      color: ColorRes.accent,
                    ),
                    onPressed: () => controller.pickShelter(context),
                    validator: Validator.emptyValidatorMsg(l10n.regFieldEmptyError),
                  ),
                ],
                key: UniqueKey(),
                padding: const EdgeInsets.only(),
                margin: const EdgeInsets.all(16.0),
              );
            });
      }),
    );
  }

  RegistrationScreenController get controller => RegistrationScreenController.controller;
}

extension CustomerRoleX on CustomerRole {
  String get value => this == CustomerRole.employer ? l10n.regEmployee : l10n.regGuest;
}
