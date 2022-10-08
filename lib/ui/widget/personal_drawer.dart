import 'package:acits_flutter/ui/screen/personal_screen/personal_screen_route.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/personal/personal_service.dart';
import 'package:acits_flutter/ui/screen/auth/pick_shelter_screen_route.dart';
import 'package:acits_flutter/ui/widget/skeleton.dart';

const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

class PersonalDrawerWidget extends StatefulWidget {
  const PersonalDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonalDrawerWidget> createState() => _PersonalDrawerWidgetState();
}

class _PersonalDrawerWidgetState extends State<PersonalDrawerWidget> {
  _PersonalDrawerWidgetState()
      : _authService = getIt<AuthService>(),
        _personalService = getIt<PersonalService>();

  final AuthService _authService;
  final PersonalService _personalService;

  final _widgetState =
      BehaviorSubject<WidgetState<UserSerializers>>.seeded(WidgetState()..loading());

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder<WidgetState<UserSerializers>>(
          stream: _widgetState,
          builder: (_, snapshot) {
            final isLoading = snapshot.data?.isLoading ?? false;
            final hasError = snapshot.data?.hasError ?? false;
            final person = snapshot.data?.value;
            return ListView(
              children: [
                _buildHeader(),
                _buildDivider(),
                if (!hasError) _buildPersonTile(isLoading, person),
                _buildDivider(),
                if (!hasError) _buildDataTileWidget(isLoading),
                ListTile(
                  title: Text(
                    StringRes.current.personMyShelters,
                    style: StyleRes.title.copyWith(color: ColorRes.textSecondary),
                  ),
                  // onTap: () {},
                ),
                _buildDivider(),
                ListTile(
                  title: Text(
                    StringRes.current.personChangePass,
                    style: StyleRes.title,
                  ),
                  onTap: () => _openPersonalScreen(isChangePass: true),
                ),
                ListTile(
                  title: Text(
                    StringRes.current.personChangeShelter,
                    style: StyleRes.title,
                  ),
                  onTap: () async {
                    final shelter = await Navigator.of(context)
                        .push(PickShelterScreenRoute(autoSelectSingle: false));
                    if (shelter == null) return;
                  },
                ),
                ListTile(
                  title: Text(
                    StringRes.current.personFeedback,
                    style: StyleRes.title.copyWith(color: ColorRes.textSecondary),
                  ),
                  // onTap: () {},
                ),
                ListTile(
                  title: Text(
                    StringRes.current.personLogout,
                    style: StyleRes.title,
                  ),
                  onTap: _authService.logout,
                ),
              ],
            );
          }),
    );
  }

  Widget _buildDataTileWidget(bool isLoading) {
    return ListTile(
      title: isLoading
          ? _buildSkeleton(156.0)
          : Text(
              StringRes.current.personMyData,
              style: StyleRes.title,
            ),
      onTap: _openPersonalScreen,
    );
  }

  Widget _buildPersonTile(bool isLoading, UserSerializers? person) {
    return ListTile(
      title: isLoading
          ? _buildSkeleton(156.0)
          : Text(
              person?.fullName ?? '',
              style: StyleRes.title,
            ),
      subtitle: isLoading ? null : Text(_authService.shelterRole?.currentShelterUserRole ?? ''),
      // onTap: () {},
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            _authService.currentShelter?.name ?? '',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeleton(double width) {
    return Row(
      children: [
        Skeleton(
          width: width,
          height: 16.0,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      endIndent: 16.0,
      indent: 16.0,
      thickness: 2.0,
    );
  }

  void _init() {
    _personalService.fetchPersonal().then(
      (value) {
        _widgetState.add(WidgetState(value));
      },
    ).catchError(
      (e) {
        _widgetState.add(WidgetState()..error = e);
      },
    );
  }

  void _openPersonalScreen({bool isChangePass = false}) async {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold?.isDrawerOpen ?? false) {
      scaffold?.closeDrawer();
      await Future.delayed(_kBaseSettleDuration);
    }
    Navigator.of(context).push(PersonalScreenRoute(changePass: isChangePass));
  }
}
