import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/ui/screen/search_screen/search_shelter_screen_route.dart';
import 'package:acits_flutter/ui/widget/success_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:rxdart/subjects.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const _termsUrl = 'https://app.acits.ru/privacy-policy';

/// Контроллер флоу регистрации
class RegistrationScreenController {
  RegistrationScreenController({
    required TickerProvider vsync,
  })  : tabController = TabController(
          initialIndex: 0,
          length: 2,
          vsync: vsync,
        ),
        _authService = getIt<AuthService>() {
    tabController.addListener(_onTabChanged);
  }

  final AuthService _authService;

  static RegistrationScreenController get controller => getIt<RegistrationScreenController>();

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

  ///
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

  final TabController tabController;

  /// Состояние табов
  final tabState = BehaviorSubject<int>.seeded(0);

  /// Согласие на перс данные
  final privateState = BehaviorSubject<bool>.seeded(false);

  /// Состояние загрузки
  final screenState = BehaviorSubject<WidgetState<Object>>.seeded(WidgetState(Object()));

  /// Состояние роль пользователя
  final customerRoleState = BehaviorSubject<CustomerRole>.seeded(CustomerRole.employer);

  /// Состояние выбранный пользователем приют
  final shelterState = BehaviorSubject<ShelterShortSerializers>();

  void dispose() {
    tabController.removeListener(_onTabChanged);
  }

  void togglePersonData() {
    privateState.add(!privateState.value);
  }

  void onPrivateTermsPressed() {
    FlutterWebBrowser.openWebPage(url: _termsUrl);
  }

  void onLoginPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onCustomerRoleChanged(CustomerRole? role) {
    if (role == null || customerRoleState.value == role) return;
    customerRoleState.add(role);
  }

  Future<void> onSubmit(BuildContext context) async {
    _onSuccess(context);
    return;
    if (screenState.value.isLoading) return;

    if (tabState.value == 0) {
      if (!(orgUserForm.currentState?.validate() ?? false) ||
          !(orgForm.currentState?.validate() ?? false)) return;
    } else {
      if (!(customerForm.currentState?.validate() ?? false) ||
          !(customerRoleForm.currentState?.validate() ?? false)) return;
    }

    if (privateState.value == false) {
      _showSnack('Необходимо дать согласие на обработку данных');
      return;
    }

    screenState.add(WidgetState()..loading());

    if (tabState.value == 0) {
      final admin = _buildAdmin();
      final result = await _authService.registrationAdmin(admin).catchError((e) {
        _showSnack(e is MessagedException ? e.errorMessage() : e.toString());
      });
      if (result is UserShelterAdminSerializers) _onSuccess(context);
    } else {
      final customer = _buildCustomer();
      final result = await _authService.registrationCustomer(customer).catchError((e) {
        _showSnack(e is MessagedException ? e.errorMessage() : e.toString());
      });
      if (result is UserShelterWorkerSerializers) _onSuccess(context);
    }

    await Future.delayed(const Duration(seconds: 3), () => screenState.add(WidgetState()));
  }

  void _onSuccess(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: SafeArea(
            child: SuccessHolderWidget(
              onPressed: Navigator.of(context).pop,
              title: 'Спасибо, мы все записали!',
              message: 'Вы будете перенаправлены\nна страницу входа.',
              button: 'Закрыть'.toUpperCase(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickShelter(BuildContext context) async {
    final shelter = await Navigator.of(context).push(SearchShelterScreenRoute());
    if (shelter != null) {
      shelterState.add(shelter);
    }
  }

  void _onTabChanged() {
    tabState.add(tabController.index);
    privateState.add(false);
  }

  void _showSnack(String msg) {
    final ctx = scaffoldKey.currentContext;
    if (ctx != null) {
      ScaffoldMessenger.maybeOf(ctx)?.showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  UserShelterAdminSerializers _buildAdmin() {
    return UserShelterAdminSerializers(
      email: orgEmailController.text,
      password: orgPassController.text,
      rePassword: orgPassController.text,
      firstName: orgNameController.text,
      lastName: orgSNameController.text,
      fathersName: orgMNameController.text,
      phoneNumber: orgPhoneController.text,
      address: '',
      shelter: {
        "name": orgShelterNameController.text,
        "country": orgCountryNameController.text,
        "city": orgCityNameController.text,
        "region": orgRegionNameController.text,
      },
    );
  }

  UserShelterWorkerSerializers _buildCustomer() {
    return UserShelterWorkerSerializers(
      shelter: shelterState.value.id,
      email: customerEmailController.text,
      password: customerPassController.text,
      rePassword: customerPassController.text,
      firstName: customerNameController.text,
      lastName: customerSNameController.text,
      fathersName: '',
      phoneNumber: '',
      address: '',
      role: customerRoleState.value == CustomerRole.employer ? RoleEnum.worker : RoleEnum.guest,
    );
  }
}

enum CustomerRole {
  guest,
  employer,
}

extension _MessagedExceptionX on MessagedException {
  String errorMessage() {
    final msg = message;
    if (msg != null) return msg;
    final errMsg = error;
    if (errMsg is String) return errMsg;
    return StringRes.current.errorDefaultMsg;
  }
}
