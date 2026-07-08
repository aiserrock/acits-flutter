import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/ui/widget/cubit/personal_drawer_cubit.dart';
import 'package:acits_flutter/ui/widget/skeleton.dart';

const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

class PersonalDrawerWidget extends StatelessWidget {
  const PersonalDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => PersonalDrawerCubit(), child: const _PersonalDrawerView());
  }
}

class _PersonalDrawerView extends StatefulWidget {
  const _PersonalDrawerView();

  @override
  State<_PersonalDrawerView> createState() => _PersonalDrawerViewState();
}

class _PersonalDrawerViewState extends State<_PersonalDrawerView> {
  _PersonalDrawerViewState() : _authService = getIt<AuthService>();

  final AuthService _authService;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<PersonalDrawerCubit, DataState<UserSerializers>>(
        builder: (_, state) {
          final isLoading = state.isLoading;
          final hasError = state.hasError;
          final person = state.valueOrNull;
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
                title: Text(StringRes.current.personChangePass, style: StyleRes.title),
                onTap: () => _openPersonalScreen(isChangePass: true),
              ),
              ListTile(
                title: Text(StringRes.current.personChangeShelter, style: StyleRes.title),
                onTap: () async {
                  final shelter = await context.push<ShelterShortSerializers>(
                    AppRoutes.pickShelter,
                    extra: <String, Object?>{'autoSelectSingle': false, 'shelterList': null},
                  );
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
                title: Text(StringRes.current.personLogout, style: StyleRes.title),
                onTap: _authService.logout,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDataTileWidget(bool isLoading) {
    return ListTile(
      title: isLoading
          ? _buildSkeleton(156.0)
          : Text(StringRes.current.personMyData, style: StyleRes.title),
      onTap: _openPersonalScreen,
    );
  }

  Widget _buildPersonTile(bool isLoading, UserSerializers? person) {
    return ListTile(
      title: isLoading
          ? _buildSkeleton(156.0)
          : Text(person?.fullName ?? '', style: StyleRes.title),
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
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeleton(double width) {
    return Row(children: [Skeleton(width: width, height: 16.0)]);
  }

  Widget _buildDivider() {
    return const Divider(endIndent: 16.0, indent: 16.0, thickness: 2.0);
  }

  void _openPersonalScreen({bool isChangePass = false}) async {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold?.isDrawerOpen ?? false) {
      scaffold?.closeDrawer();
      await Future.delayed(_kBaseSettleDuration);
    }
    if (!mounted) return;
    context.push('${AppRoutes.personal}?changePass=$isChangePass');
  }
}
