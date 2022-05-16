import 'package:acits_flutter/domain/exception.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class PersonalService {
  PersonalService(
    this._acitsClient,
    this._authService,
  ) {
    _authService.addListener(_onLogout);
  }

  final Openapi _acitsClient;
  final AuthService _authService;

  UserSerializers? _person;

  Future<UserSerializers> fetchPersonal() async {
    final cached = _person;
    if (cached != null) return cached;

    final result = await _acitsClient.apiV1UsersMeGet(
      xCurrentShelter: _authService.currentShelterId,
    );

    final user = result.body;
    if (user != null) {
      _person = user;
      return user;
    } else {
      throw MessagedException(error: result.error);
    }
  }

  void _onLogout() {
    _person = null;
  }
}
