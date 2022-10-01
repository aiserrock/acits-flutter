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
      scopeName: 'Registration',
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
      tabs: ['ОРГАНИЗАЦИЯ', 'ПОЛЬЗОВАТЕЛЬ']
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
                text: 'Зарегистрироваться'.toUpperCase(),
              )
            : Shimmer.fromColors(
                baseColor: ColorRes.accent,
                highlightColor: ColorRes.background,
                child: PrimaryButton(
                  onPressed: () => controller.onSubmit,
                  text: 'Зарегистрироваться'.toUpperCase(),
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
        const Text(
          'Уже есть аккаунт?',
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
                const TextSpan(text: 'Я даю согласие на обработку '),
                TextSpan(
                    text: 'персональных данных',
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Информация о Вас',
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Информация об организации',
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
            StringRes.current.loginDescribeMsg,
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
          const Text(
            'Человек, данные которого указаны, автоматически будет назначен администратором',
            style: StyleRes.content,
          ),
          TextFormField(
            controller: controller.orgLoginController,
            decoration: const InputDecoration(
              labelText: 'Логин *',
              hintText: 'Латинские буквы, цифры, символы',
            ),
            validator: Validator.emptyValidatorMsg('Поле не должно быть пустым'),
          ),
          TextFormField(
            controller: controller.orgPassController,
            decoration: const InputDecoration(
              labelText: 'Пароль *',
            ),
            validator: Validator.emptyValidatorMsg('Минимум 8 символов'),
          ),
          TextFormField(
            controller: controller.orgEmailController,
            decoration: const InputDecoration(
              labelText: 'Эл. почта *',
              hintText: 'example@mail.ru',
            ),
            validator: Validator.emailValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: controller.orgPhoneController,
            decoration: const InputDecoration(
              labelText: 'Номер телефона',
              hintText: '+7(ххх)ххх-хх-хх',
            ),
            keyboardType: TextInputType.phone,
            inputFormatters: [controller.phoneFormatter],
          ),
          TextFormField(
            controller: controller.orgSNameController,
            decoration: const InputDecoration(
              labelText: 'Фамилия *',
              hintText: 'Иванов',
            ),
            validator: Validator.emptyValidatorMsg('Поле не должно быть пустым'),
          ),
          TextFormField(
            controller: controller.orgNameController,
            decoration: const InputDecoration(
              labelText: 'Имя *',
              hintText: 'Иван',
            ),
            validator: Validator.emptyValidatorMsg('Поле не должно быть пустым'),
          ),
          TextFormField(
            controller: controller.orgMNameController,
            decoration: const InputDecoration(
              labelText: 'Отчество',
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
            decoration: const InputDecoration(
              labelText: 'Название приюта/реб.центра *',
            ),
            validator: Validator.emptyValidatorMsg('Поле не должно быть пустым'),
          ),
          TextFormField(
            controller: controller.orgCountryNameController,
            decoration: const InputDecoration(
              labelText: 'Страна *',
              hintText: 'Укажите страну',
            ),
            validator: Validator.emptyValidatorMsg('Поле не должно быть пустым'),
          ),
          TextFormField(
            controller: controller.orgRegionNameController,
            decoration: const InputDecoration(
              labelText: 'Область ',
              hintText: 'Укажите область',
            ),
          ),
          TextFormField(
            controller: controller.orgCityNameController,
            decoration: const InputDecoration(
              labelText: 'Город *',
              hintText: 'Укажите город',
            ),
            validator: Validator.emptyValidatorMsg('Поле не должно быть пустым'),
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Информация о Вас',
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Информация об приюте',
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
            StringRes.current.loginDescribeMsg,
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
            decoration: const InputDecoration(
              labelText: 'Эл. почта *',
              hintText: 'example@mail.ru',
            ),
            validator: Validator.emailValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            controller: controller.customerPassController,
            decoration: const InputDecoration(
              labelText: 'Пароль *',
            ),
            validator: Validator.emptyValidatorMsg('Поле не должно быть пустым'),
          ),
          TextFormField(
            controller: controller.customerSNameController,
            decoration: const InputDecoration(
              labelText: 'Фамилия *',
              hintText: 'Иванов',
            ),
            validator: Validator.emptyValidatorMsg('Поле не должно быть пустым'),
          ),
          TextFormField(
            controller: controller.customerNameController,
            decoration: const InputDecoration(
              labelText: 'Имя *',
              hintText: 'Иван',
            ),
            validator: Validator.emptyValidatorMsg('Поле не должно быть пустым'),
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
                    label: 'Роль пользователя',
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
                    label: 'Выберите приют *',
                    initValue: shelter.data?.name,
                    suffix: const Icon(
                      Icons.menu_open_rounded,
                      color: ColorRes.accent,
                    ),
                    onPressed: () => controller.pickShelter(context),
                    validator: Validator.emptyValidatorMsg('Поле не должно быть пустым'),
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
  String get value => this == CustomerRole.employer ? 'Сотрудник' : 'Гость';
}
