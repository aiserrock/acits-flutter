import 'package:core/domain.dart' show Shelter;
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ui_kit/ui_kit.dart' show Skeleton;

import 'package:personal/personal.dart' show PersonalRepository, UserProfile;

import 'package:observability/observability.dart' show CollectionSettings;
import 'package:shell/navigation/app_router.dart';
import 'package:shell/res/legal_links.dart';
import 'package:shell/res/strings.dart';
import 'package:shell/src/shell_exports.dart';
import 'package:app_services/app_services.dart';
import 'package:shell/widget/cubit/personal_drawer_cubit.dart';
import 'package:shell/widget/account_deletion.dart';
import 'package:shell/widget/app_version_label.dart';
import 'package:shell/widget/collection_switch_tile.dart';
import 'package:shell/widget/locale_switcher.dart';
import 'package:shell/widget/theme_switcher_tile.dart';

const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

/// Боковое меню приложения. Зависимости приходят из composition root
/// (`app_router.dart`): [authService] — сессия/выход, [repository] — профиль
/// пользователя, [collectionSettings] — настройки сбора данных (`null`, когда
/// сборка их не регистрирует: тогда переключатель не показывается).
class PersonalDrawerWidget extends StatelessWidget {
  const PersonalDrawerWidget({required this.authService, required this.repository, this.collectionSettings, super.key});

  final AuthService authService;
  final PersonalRepository repository;
  final CollectionSettings? collectionSettings;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonalDrawerCubit(repository),
      child: _PersonalDrawerView(authService: authService, collectionSettings: collectionSettings),
    );
  }
}

class _PersonalDrawerView extends StatefulWidget {
  const _PersonalDrawerView({required this.authService, required this.collectionSettings});

  final AuthService authService;
  final CollectionSettings? collectionSettings;

  @override
  State<_PersonalDrawerView> createState() => _PersonalDrawerViewState();
}

class _PersonalDrawerViewState extends State<_PersonalDrawerView> {
  AuthService get _authService => widget.authService;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<PersonalDrawerCubit, DataState<UserProfile>>(
        builder: (context, state) {
          final isLoading = state.isLoading;
          final hasError = state.hasError;
          final person = state.valueOrNull;
          final titleStyle = Theme.of(context).textTheme.titleLarge;
          return ListView(
            children: [
              _buildHeader(),
              _buildDivider(),
              if (!hasError) _buildPersonTile(context, isLoading, person),
              _buildDivider(),
              if (!hasError) _buildDataTileWidget(context, isLoading),
              ListTile(
                title: Text(LocaleKeys.personMyShelters.tr(), style: titleStyle),
                onTap: _openMyShelters,
              ),
              _buildDivider(),
              ListTile(
                title: Text(LocaleKeys.personChangePass.tr(), style: titleStyle),
                onTap: () => _openPersonalScreen(isChangePass: true),
              ),
              ListTile(
                title: Text(LocaleKeys.personChangeShelter.tr(), style: titleStyle),
                onTap: () async {
                  final shelter = await context.push<Shelter>(AppRoutes.pickShelterPath(autoSelectSingle: false));
                  if (shelter == null) return;
                },
              ),
              ListTile(
                title: Text(LocaleKeys.personFeedback.tr(), style: titleStyle),
                onTap: () => _open(supportMail(subject: LocaleKeys.feedbackMailSubject.tr())),
              ),
              ListTile(
                title: Text(LocaleKeys.personLogout.tr(), style: titleStyle),
                onTap: _authService.logout,
              ),
              _buildDivider(),
              const ThemeSwitcherTile(),
              if (widget.collectionSettings case final settings?) CollectionSwitchTile(settings: settings),
              ListTile(
                title: Text(LocaleKeys.commonLanguage.tr(), style: Theme.of(context).textTheme.bodyLarge),
                trailing: const LocaleSwitcher(size: 22.0),
              ),
              _buildDivider(),
              ListTile(
                title: Text(LocaleKeys.legalPrivacyPolicy.tr(), style: Theme.of(context).textTheme.bodyLarge),
                onTap: () => _open(LegalLinks.privacyPolicy),
              ),
              ListTile(
                title: Text(LocaleKeys.legalTerms.tr(), style: Theme.of(context).textTheme.bodyLarge),
                onTap: () => _open(LegalLinks.terms),
              ),
              ListTile(
                title: Text(LocaleKeys.legalLicenses.tr(), style: Theme.of(context).textTheme.bodyLarge),
                onTap: () => showLicensePage(context: context, applicationName: StringConst.commonAppName),
              ),
              if (!hasError && person != null)
                ListTile(
                  title: Text(
                    LocaleKeys.accountDelete.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                  onTap: () => confirmAccountDeletion(
                    context,
                    deletion: const SupportMailAccountDeletion(),
                    email: person.email,
                    shelter: _authService.currentShelter?.name ?? '',
                    onRequested: _authService.logout,
                  ),
                ),
              _buildDivider(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 12.0), child: AppVersionLabel()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDataTileWidget(BuildContext context, bool isLoading) {
    return ListTile(
      title: isLoading
          ? _buildSkeleton(156.0)
          : Text(LocaleKeys.personMyData.tr(), style: Theme.of(context).textTheme.titleLarge),
      onTap: _openPersonalScreen,
    );
  }

  Widget _buildPersonTile(BuildContext context, bool isLoading, UserProfile? person) {
    return ListTile(
      title: isLoading
          ? _buildSkeleton(156.0)
          : Text(person?.fullName ?? '', style: Theme.of(context).textTheme.titleLarge),
      subtitle: isLoading ? null : Text(_authService.shelterRole?.role ?? ''),
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

  Future<void> _open(Uri uri) async {
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      // No browser or mail app: nothing to open, the menu stays.
    }
  }

  void _openPersonalScreen({bool isChangePass = false}) =>
      _openScreen('${AppRoutes.personal}?changePass=$isChangePass');

  void _openMyShelters() => _openScreen(AppRoutes.myShelters);

  Future<void> _openScreen(String location) async {
    final scaffold = Scaffold.maybeOf(context);
    if (scaffold?.isDrawerOpen ?? false) {
      scaffold?.closeDrawer();
      await Future.delayed(_kBaseSettleDuration);
    }
    if (!mounted) return;
    context.push(location);
  }
}
