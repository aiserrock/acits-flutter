import 'dart:async';
import 'dart:math';
import 'package:acits_flutter/ui/screen/comments/comment_edit_screen_route.dart';
import 'package:acits_flutter/ui/screen/comments/comment_list.dart';
import 'package:acits_flutter/ui/screen/doc_viewer/doc_viewer_route.dart';
import 'package:acits_flutter/ui/screen/photo_gallery/photo_gallery_route.dart';
import 'package:acits_flutter/ui/screen/prescription/prescription_edit_screen_route.dart';
import 'package:acits_flutter/ui/widget/error_holder.dart';
import 'package:acits_flutter/ui/widget/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:acits_flutter/di/di_container.dart';
import 'package:acits_flutter/export.dart';
import 'package:acits_flutter/service/animal/animal_service.dart';
import 'package:acits_flutter/service/prescription/prescription_service.dart';
import 'package:acits_flutter/ui/screen/animal_detail/animal_content_card.dart';
import 'package:acits_flutter/ui/widget/animal_prescription_card.dart';
import 'package:acits_flutter/ui/widget/default_app_bar.dart';
import 'package:acits_flutter/ui/widget/default_icon_button.dart';
import 'package:acits_flutter/ui/widget/error_stub.dart';
import 'package:acits_flutter/ui/widget/skeleton.dart';

part 'animal_common_info.dart';
part 'animal_prescriptions.dart';
part 'animal_curator.dart';
part 'animal_applicant.dart';
part 'animal_detail_stub.dart';

final _dateFormatter = DateFormat('dd.MM.yyyy');
const _expandedHeight = 408.0;
const _collapsedHeight = 235.0;

class AnimalDetailScreen extends StatefulWidget {
  const AnimalDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  final int id;

  @override
  _AnimalDetailScreenState createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  _AnimalDetailScreenState()
      : _animalService = getIt<AnimalService>(),
        _prescriptionService = getIt<PrescriptionService>();

  final AnimalService _animalService;
  final PrescriptionService _prescriptionService;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final _imagePageController = PageController();

  final _onCreateCommentStream = StreamController<AnimalNote>.broadcast();
  final _prescriptionSwichState = BehaviorSubject.seeded(_PrescriptionState.active);

  late bool _isSmallScreen;
  int _currentTab = 0;
  double _titleOpacity = .0;

  WidgetState<AnimalRead> _state = WidgetState()..loading();
  WidgetState<List<Prescription?>?> _statePrescriptions = WidgetState()..loading();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isSmallScreen = MediaQuery.of(context).size.width <= 340.0;
    _scrollController.addListener(_onScroll);
  }

  @override
  void initState() {
    super.initState();
    _loadAnimal();
    _loadPrescriptions();
    _prescriptionSwichState.listen((value) => _loadPrescriptions());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _onCreateCommentStream.close();
    _prescriptionSwichState.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: _buildDrawer(),
      backgroundColor: ColorRes.background,
      body: _buildBody(),
      floatingActionButton: _buildFab(),
    );
  }

  FloatingActionButton? _buildFab() {
    return (_currentTab == 1 || _currentTab == 4)
        ? FloatingActionButton(
            mini: _isSmallScreen,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            foregroundColor: ColorRes.accent,
            onPressed: () => _onFabPressed(context),
          )
        : null;
  }

  Widget _buildDrawer() => const Drawer();

  Widget _buildBody() {
    return StateBuilder<AnimalRead>(
      state: _state,
      builder: _buildContent,
      errorBuilder: (_, error) => _AnimalDetailStub(
        error: error,
        onRefresh: _loadAnimal,
      ),
      loader: (_) => _AnimalDetailStub(
        onRefresh: _loadAnimal,
      ),
    );
  }

  Widget _buildContent(BuildContext context, AnimalRead animal) {
    return RefreshIndicator(
      onRefresh: _loadAnimal,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildHeader(context, animal),
          _buildPage((_currentTab + 1) * 5, animal),
        ],
      ),
    );
  }

  SliverAppBar _buildHeader(
    BuildContext context,
    AnimalRead animal,
  ) {
    return SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        title: _buildHeaderTitle(context, animal),
        background: _buildHeaderImagePager(context, animal),
      ),
      elevation: 2.0,
      pinned: true,
      expandedHeight: _expandedHeight,
      collapsedHeight: _collapsedHeight,
      backgroundColor: ColorRes.foreground,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: true,
      titleSpacing: .0,
      floating: true,
    );
  }

  Widget _buildHeaderTitle(
    BuildContext context,
    AnimalRead animal,
  ) {
    final avatar = animal.thumb;
    return Column(
      children: [
        DefaultAppBar(
          titleString: StringRes.current.animalCardTitle,
          onBackPressure: Navigator.of(context).pop,
          elevation: .0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Opacity(
              opacity: Curves.easeInOutExpo.transform(_titleOpacity),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(30.0),
                    onTap: () => _onPhotoPressed(context, animal),
                    child: avatar != null
                        ? CircleAvatar(
                            radius: 30.0,
                            backgroundColor: ColorRes.background,
                            backgroundImage: NetworkImage(avatar),
                          )
                        : _buildAddPhotoIcon(30.0),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        animal.name ?? '',
                        style: StyleRes.mainContent.copyWith(fontSize: 24.0),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        animal.id.toString(),
                        style: StyleRes.titleLight.copyWith(fontSize: 16.0),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 56.0, child: _buildTabBar()),
      ],
    );
  }

  Widget _buildAddPhotoIcon(double radius) {
    return Container(
      height: radius * 2,
      width: radius * 2,
      decoration: BoxDecoration(
        color: ColorRes.background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: const Center(
        child: Icon(
          Icons.add_a_photo_outlined,
          color: ColorRes.accent,
          size: 32.0,
        ),
      ),
    );
  }

  Widget _buildHeaderImagePager(
    BuildContext context,
    AnimalRead animal,
  ) {
    return Stack(
      children: [
        if (animal.images?.isEmpty ?? true)
          Center(
            child: CupertinoButton(
              onPressed: () => _onPhotoPressed(context, animal),
              child: _buildAddPhotoIcon(60.0),
            ),
          ),
        if (animal.images?.isNotEmpty ?? false)
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                child: PageView(
                  controller: _imagePageController,
                  children: animal.images?.map<Widget>(
                        (image) {
                          return Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  UrlCorsProxy.add(image.image?.medium) ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: ColorRes.accent.withOpacity(.4),
                                    onTap: () => _onPhotoPressed(context, animal),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList() ??
                      [],
                ),
              ),
            ),
          ),
        _buildHeaderExpandedTitle(animal),
        _buildHeaderImageIndicator(context, animal),
      ],
    );
  }

  Widget _buildHeaderExpandedTitle(AnimalRead animal) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 116.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: ColorRes.textPrimary.withOpacity(.3),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Text(
                animal.name ?? '',
                style: StyleRes.mainContent.copyWith(
                  fontSize: 24.0,
                  color: ColorRes.foreground,
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 4.0),
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: ColorRes.textPrimary.withOpacity(.3),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Text(
                animal.id.toString(),
                style: StyleRes.titleLight.copyWith(
                  fontSize: 16.0,
                  color: ColorRes.foreground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImageIndicator(BuildContext context, AnimalRead animal) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            DefaultIconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorRes.accent,
              ),
              onPressed: Navigator.of(context).pop,
            ),
            const Spacer(),
            if ((animal.images?.length ?? 1) > 1)
              SmoothPageIndicator(
                controller: _imagePageController,
                count: animal.images?.length ?? 1,
                effect: const ExpandingDotsEffect(
                  activeDotColor: ColorRes.indicatorActive,
                  dotColor: ColorRes.indicatorInactive,
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  strokeWidth: 16.0,
                ),
              ),
            const Spacer(),
            // TODO: impl for web
            if (!kIsWeb)
              DefaultIconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: ColorRes.accent,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    DocViewerScreenRoute(
                      fetcher: (() async {
                        final pdf = await _animalService.fetchPdfAnimalCard(widget.id);
                        return pdf;
                      }),
                      title: '${StringRes.current.mainAnimal} ${widget.id}',
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(int count, AnimalRead animal) {
    switch (_currentTab) {
      case 0:
        return _buildCommonInfoPage(animal);
      case 1:
        return _buildPrescriptionsPage(
          _statePrescriptions,
          _prescriptionSwichState,
          _loadPrescriptions,
        );
      case 2:
        return _buildCuratorPage(animal);
      case 3:
        return _buildApplicantPage(animal);
      default:
        return CommentListWidget(
          animal.id!,
          scrollController: _scrollController,
          onCreateCommentStream: _onCreateCommentStream,
        );
    }
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: CupertinoSlidingSegmentedControl<int>(
          children: <int, Widget>{
            0: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.animalFace.svg(
                height: 28.0,
                width: 28.0,
                color: _currentTab == 0 ? ColorRes.accent : Colors.white,
              ),
            ),
            1: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.prescription.svg(
                height: 28.0,
                width: 28.0,
                color: _currentTab == 1 ? ColorRes.accent : Colors.white,
              ),
            ),
            2: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.curator.svg(
                height: 28.0,
                width: 28.0,
                color: _currentTab == 2 ? ColorRes.accent : Colors.white,
              ),
            ),
            3: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.applicant.svg(
                height: 28.0,
                width: 28.0,
                color: _currentTab == 3 ? ColorRes.accent : Colors.white,
              ),
            ),
            4: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Assets.icon.comment.svg(
                height: 28.0,
                width: 28.0,
                color: _currentTab == 4 ? ColorRes.accent : Colors.white,
              ),
            ),
          },
          groupValue: _currentTab,
          backgroundColor: ColorRes.indicatorActive,
          onValueChanged: (int? index) {
            setState(() {
              if (index != null) _currentTab = index;
            });
            proceedOnNextFrame(_onScroll);
          },
        ),
      ),
    );
  }

  void _onPhotoPressed(BuildContext context, AnimalRead animal) {
    final id = animal.id;
    if (id != null) {
      Navigator.of(context).push(PhotoGalleryScreenRoute(animalId: animal.id!)).then(
        (value) {
          if (value is bool && value) _loadAnimal();
        },
      );
    }
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      const delta = _expandedHeight - _collapsedHeight;
      final scroll = min(delta, max(.0, _scrollController.offset));
      setState(() => _titleOpacity = scroll / delta);
    }
  }

  Future<void> _loadAnimal() async {
    setState(() => _state = WidgetState()..loading());
    await _animalService
        .fetchAnimalDetail(id: widget.id)
        .then((value) => setState(() => _state = WidgetState()..content(value)))
        .catchError((e) => setState(() => _state = WidgetState()..error = e));
  }

  Future<void> _loadPrescriptions() async {
    setState(() => _statePrescriptions = WidgetState()..loading());
    await _prescriptionService
        .fetchPrescriptionListByAnimal(
          widget.id,
          isActual: _prescriptionSwichState.value == _PrescriptionState.active,
          isOld: _prescriptionSwichState.value == _PrescriptionState.inactive,
        )
        .then(
            (value) => setState(() => _statePrescriptions = WidgetState()..content(value?.results)))
        .catchError((e) => setState(() => _state = WidgetState()..error = e));
  }

  void _onFabPressed(BuildContext context) {
    if (_currentTab == 4) {
      Navigator.of(context).push(CommentEditScreenRoute(animalId: widget.id)).then(
        (value) {
          if (value != null) {
            _onCreateCommentStream.add(value);
          }
        },
      );
    }
    if (_currentTab == 1) {
      Navigator.of(context).push(PrescriptionEditScreenRoute(animal: _state.value)).then(
        (value) {
          if (value != null) {
            _loadPrescriptions();
          }
        },
      );
    }
  }
}
