import 'dart:async';

import 'package:flutter/material.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/service/auth/auth_service.dart';
import 'package:acits_flutter/service/config/config_service.dart';
import 'package:acits_flutter/ui/screen/root_screen.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/util/util.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/ui/widget/debug_drawer.dart';
import 'package:acits_flutter/api/openapi.swagger.dart';

class PickShelterScreen extends StatefulWidget {
  const PickShelterScreen({
    required this.autoSelectSingle,
    this.shelterList,
    Key? key,
  }) : super(key: key);

  static Route<ShelterShortSerializers> route({
    PaginatedShelterShortSerializersList? shelterList,
    bool autoSelectSingle = true,
  }) =>
      MaterialPageRoute<ShelterShortSerializers>(
        builder: (_) => PickShelterScreen(
          shelterList: shelterList,
          autoSelectSingle: autoSelectSingle,
        ),
      );

  final PaginatedShelterShortSerializersList? shelterList;
  final bool autoSelectSingle;

  @override
  _PickShelterScreenState createState() => _PickShelterScreenState(
        shelterList,
        autoSelectSingle,
      );
}

class _PickShelterScreenState extends State<PickShelterScreen> {
  _PickShelterScreenState(
    this._shelterList,
    this._autoSelectSingle,
  ) : _authService = getIt<AuthService>();

  final AuthService _authService;

  PaginatedShelterShortSerializersList? _shelterList;
  final bool _autoSelectSingle;

  @override
  void initState() {
    super.initState();
    if (_shelterList == null) _getShelterList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_autoSelectSingle && _shelterList?.results?.length == 1) _pickShelter(0);
  }

  final _state = StreamController<WidgetState<Object>>()..add(WidgetState()..content(Object()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorRes.background,
        endDrawer: const Drawer(
          child: DebugDrawerContent(),
        ),
        appBar: AppBar(
          backgroundColor: ColorRes.foreground,
          shadowColor: Colors.transparent,
          leading: Assets.image.logoLeadingBar.svg(),
          title: Text(
            StringRes.current.shelterSelectShelter,
            style: const TextStyle(color: ColorRes.textPrimary),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<WidgetState<Object>>(
                stream: _state.stream,
                builder: (_, snapshot) {
                  final hasError = snapshot.data?.hasError ?? false;
                  final isLoading = snapshot.data?.isLoading ?? true;

                  return isLoading
                      ? const LoaderHolderWidget()
                      : hasError
                          ? ErrorHolderWidget(
                              onPressed: () => _state.add(WidgetState()),
                            )
                          : _buildContent();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 40.0,
              ),
              child: Text(
                StringRes.current.loginDescribeMsg,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 16.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListView.separated(
          padding: const EdgeInsets.all(.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _shelterList?.results?.length ?? 0,
          itemBuilder: (_, index) => ListTile(
            title: Text((_shelterList?.results ?? [])[index].name ?? ''),
            onTap: () => _pickShelter(index),
          ),
          separatorBuilder: (_, __) => const Divider(
            indent: 16.0,
            endIndent: 16.0,
            height: 2.0,
            thickness: 2.0,
          ),
        ),
      ),
    );
  }

  void _getShelterList() {
    _shelterList = _authService.shelterList;
  }

  Future<void> _pickShelter(int index) async {
    _state.add(WidgetState()..loading());
    final shelter = (_shelterList?.results ?? [])[index];
    await Future.wait([
      _getConfig(shelter),
      _authService.setCurrentShelter(shelter.id!),
    ]).catchError((e) {
      _state.add(WidgetState()..error = e);
    }).then((_) {
      Navigator.of(context)
        ..popUntil((route) => false)
        ..push(MaterialPageRoute(builder: (_) => const RootScreen()));
    });
  }

  Future<void> _getConfig(ShelterShortSerializers shelter) {
    return getIt<ConfigService>().initConfig(currentShelterId: shelter.id);
  }
}
