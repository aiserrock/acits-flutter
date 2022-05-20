import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/ui/screen/prescription/prescription_edit_screen_controller.dart';

/// Экран создания и редактирования назначений
class PrescriptionEditScreen extends StatefulWidget {
  const PrescriptionEditScreen({
    this.editPrescription,
    this.editPrescriptionId,
    Key? key,
  }) : super(key: key);

  final int? editPrescriptionId;
  final Prescription? editPrescription;

  @override
  State<PrescriptionEditScreen> createState() => _PrescriptionEditScreenState();
}

class _PrescriptionEditScreenState extends State<PrescriptionEditScreen>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PrescriptionEditScreenController(
      scaffoldKey: scaffoldKey,
      tickerProvider: this,
      editPrescriptionId: widget.editPrescriptionId,
      editPrescription: widget.editPrescription,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Builder(builder: (context) {
      final controller = PrescriptionEditScreenController.of(context);
      return StreamBuilder<WidgetState<Prescription>?>(
          stream: controller?.screenState,
          builder: (context, state) {
            final isLoading = state.data?.isLoading ?? false;
            final hasError = state.data?.hasError ?? false;
            return controller?.isEdit ?? false
                ? isLoading
                    ? const Scaffold(body: LoaderHolderWidget())
                    : hasError
                        ? Scaffold(body: ErrorHolderWidget(onPressed: controller?.setEditedState))
                        : _buildForm(context, controller)
                : _buildForm(context, controller);
          });
    });
  }

  Widget _buildForm(
    BuildContext context,
    PrescriptionEditScreenController? controller,
  ) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorRes.accent,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: _buildTitle(),
        centerTitle: true,
        bottom: TabBar(
          tabs: (controller?.getTabs() ?? [])
              .map<Widget>(
                (tab) => SizedBox(
                  height: 64.0,
                  child: Center(
                    child: Text(
                      tab,
                      style: StyleRes.title,
                      maxLines: 2,
                    ),
                  ),
                ),
              )
              .toList(),
          controller: controller?.tabController,
          isScrollable: true,
        ),
      ),
      floatingActionButton: _buildFab(),
      body: _buildBody(),
    );
  }

  Widget _buildFab() {
    return Builder(builder: (context) {
      final controller = PrescriptionEditScreenController.of(context);
      return FloatingActionButton(
        child: const Icon(
          Icons.done_all,
          color: Colors.white,
        ),
        onPressed: controller?.onFabPressed,
        backgroundColor: ColorRes.accent,
      );
    });
  }

  Widget _buildTitle() {
    return Builder(builder: (context) {
      final controller = PrescriptionEditScreenController.of(context);
      return Text(
        controller?.isEdit ?? false
            ? StringRes.current.prescriptionTitleEdit
            : StringRes.current.prescriptionTitleAdd,
        style: const TextStyle(color: ColorRes.textPrimary),
      );
    });
  }

  Widget _buildBody() {
    return Builder(builder: (context) {
      final controller = PrescriptionEditScreenController.of(context);
      return Column(
        children: [
          StreamBuilder<bool>(
            stream: controller?.loadingState,
            builder: (_, state) {
              return AnimatedCrossFade(
                duration: kThemeAnimationDuration, //  Duration(milliseconds: 500),
                crossFadeState:
                    state.data ?? false ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                firstChild: const SizedBox(),
                secondChild: SizedBox(
                  height: 64.0,
                  child: Center(child: LottieBuilder.asset(LottieRes.dogLoading)),
                ),
              );
            },
          ),
          Expanded(
            child: _buildPages(),
          ),
        ],
      );
    });
  }

  Widget _buildPages() {
    return Builder(builder: (context) {
      final controller = context.controller;
      return TabBarView(
        controller: controller?.tabController,
        children: _buildTabs(),
      );
    });
  }

  List<Widget> _buildTabs() {
    return [
      const Center(child: Text('0')),
      const Center(child: Text('1')),
      const Center(child: Text('2')),
      const Center(child: Text('3')),
      const Center(child: Text('4')),
      const Center(child: Text('5')),
    ];
  }
}

extension _PrescriptionEditScreenControllerX on BuildContext {
  PrescriptionEditScreenController? get controller => PrescriptionEditScreenController.of(this);
}
