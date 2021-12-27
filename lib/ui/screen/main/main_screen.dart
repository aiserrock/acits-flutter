import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool _isSmallScreen;
  bool _isSearchActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isSmallScreen = MediaQuery.of(context).size.width <= 340.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: _buildDrawer(),
      backgroundColor: ColorRes.background,
      appBar: AppBar(
        backgroundColor: ColorRes.foreground,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(
            Icons.menu,
            color: ColorRes.accent,
          ),
          onTap: () => scaffoldKey.currentState?.openDrawer(),
        ),
        title: _buildTitle(),
        actions: _buildAppBarActions,
        centerTitle: true,
      ),
      floatingActionButton: _buidFab(),
      body: _buildBody(),
    );
  }

  Widget _buidFab() {
    return FloatingActionButton(
      mini: _isSmallScreen,
      onPressed: () {},
      child: const Icon(
        Icons.add,
        color: ColorRes.foreground,
      ),
      backgroundColor: ColorRes.accent,
    );
  }

  List<Widget> get _buildAppBarActions {
    return [
      if (!_isSearchActive)
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            child: const Icon(
              Icons.search,
              color: ColorRes.accent,
            ),
            onTap: () => setState(() => _isSearchActive = !_isSearchActive),
          ),
        ),
    ];
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Assets.common.emptyState.svg(),
            Text(
              StringRes.current.mainEmptyState,
              style: const TextStyle(
                fontSize: 16.0,
                color: ColorRes.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() => const Drawer();

  Widget _buildTitle() {
    return _isSearchActive
        ? SizedBox(
            height: 40.0,
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 16.0, right: 8.0),
                suffix: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Assets.icon.close.svg(height: 16.0, width: 16.0, color: ColorRes.accent),
                  ),
                  onTap: () => setState(() => _isSearchActive = !_isSearchActive),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              style: StyleRes.content.copyWith(color: ColorRes.textPrimary),
            ),
          )
        : Text(
            StringRes.current.mainTitle,
            style: const TextStyle(color: ColorRes.textPrimary),
          );
  }
}
