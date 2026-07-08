import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:acits_flutter/api/openapi.swagger.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/navigation/app_router.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/ui/screen/auth/cubit/pick_shelter_cubit.dart';
import 'package:acits_flutter/ui/screen/auth/cubit/pick_shelter_state.dart';
import 'package:acits_flutter/ui/widget/debug_drawer.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:acits_flutter/util/data_state.dart';

/// Экран выбора приюта.
class PickShelterScreen extends StatelessWidget {
  const PickShelterScreen({required this.autoSelectSingle, this.shelterList, super.key});

  final PaginatedShelterShortSerializersList? shelterList;
  final bool autoSelectSingle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PickShelterCubit(autoSelectSingle: autoSelectSingle, shelterList: shelterList),
      child: const _PickShelterView(),
    );
  }
}

class _PickShelterView extends StatefulWidget {
  const _PickShelterView();

  @override
  State<_PickShelterView> createState() => _PickShelterViewState();
}

class _PickShelterViewState extends State<_PickShelterView> {
  final _scrollController = ScrollController();

  /// Guard: автовыбор запускаем ровно один раз из [didChangeDependencies].
  bool _autoSelectTriggered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_autoSelectTriggered) return;
    _autoSelectTriggered = true;
    _autoSelectSingle();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.background,
      endDrawer: const Drawer(child: DebugDrawerContent()),
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
            child: BlocBuilder<PickShelterCubit, PickShelterState>(
              builder: (context, state) => DataStateBuilder<Object>(
                state: state.status,
                loader: (_) => const LoaderHolderWidget(),
                errorBuilder: (_, _) =>
                    ErrorHolderWidget(onPressed: () => context.read<PickShelterCubit>().retry()),
                builder: (_, _) => _buildContent(state),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 40.0),
            child: Text(StringRes.current.loginDescribeMsg, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(PickShelterState state) {
    final results = state.results;
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: ListView.separated(
          padding: const EdgeInsets.all(.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: results.length,
          itemBuilder: (_, index) =>
              ListTile(title: Text(results[index].name ?? ''), onTap: () => _pickShelter(index)),
          separatorBuilder: (_, _) =>
              const Divider(indent: 16.0, endIndent: 16.0, height: 2.0, thickness: 2.0),
        ),
      ),
    );
  }

  Future<void> _autoSelectSingle() async {
    final picked = await context.read<PickShelterCubit>().maybeAutoSelectSingle();
    if (picked && mounted) context.go(AppRoutes.root);
  }

  Future<void> _pickShelter(int index) async {
    final picked = await context.read<PickShelterCubit>().pickShelter(index);
    if (picked && mounted) context.go(AppRoutes.root);
  }
}
