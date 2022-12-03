import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:acits_flutter/ui/screen/onboarding/bloc/onboarding_bloc.dart';
import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:acits_flutter/ui/screen/auth/login_screen_route.dart';
import 'package:acits_flutter/ui/screen/onboarding/model/onboarding_data.dart';
import 'package:acits_flutter/ui/widget/button.dart';
import 'package:acits_flutter/ui/widget/debug_drawer.dart';

/// Экран онбординга при входе в приложение
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  _OnboardingScreenState();

  late List<OnboardingData> _onboardingData;
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(_pageScrollListen);
  }

  @override
  void didChangeDependencies() {
    _onboardingData = context.read<OnboardingBloc>().onboardingData;
    context.read<OnboardingBloc>().stream.listen((state) => _listenCloseState(context, state));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_pageScrollListen)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(child: DebugDrawerContent()),
      body: SafeArea(
        child: Column(
          children: [
            _buildCloseBtn(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildPager(),
                    const SizedBox(height: 24.0),
                    _buildBtn(context),
                    const SizedBox(height: 24.0),
                    _buildIndicator(),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return SmoothPageIndicator(
      count: _onboardingData.length,
      controller: _controller,
      onDotClicked: _scrollTo,
      effect: const ExpandingDotsEffect(
        activeDotColor: ColorRes.indicatorActive,
        dotColor: ColorRes.indicatorInactive,
        dotHeight: 8.0,
        dotWidth: 8.0,
        strokeWidth: 16.0,
      ),
    );
  }

  Widget _buildBtn(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return PrimaryButton(
          onPressed: () => _tapNext(context),
          text: state.isLast
              ? StringRes.current.commonBegin.toUpperCase()
              : StringRes.current.commonNext.toUpperCase(),
        );
      },
    );
  }

  Widget _buildPager() {
    final isSmallScreen = MediaQuery.of(context).size.width <= 320.0;
    return Expanded(
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _onboardingData.length,
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          final data = _onboardingData[index];
          return Column(
            children: [
              Expanded(
                child: SizedBox.expand(
                  child: data.image.svg(fit: BoxFit.fitWidth),
                ),
              ),
              SizedBox(height: isSmallScreen ? 16.0 : 24.0),
              Text(
                data.title,
                style: StyleRes.title,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isSmallScreen ? 16.0 : 24.0),
              Text(
                data.message,
                style: StyleRes.content,
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCloseBtn(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: CupertinoButton(
        onPressed: () => _closeScreen(context),
        child: Assets.icon.close.svg(),
      ),
    );
  }

  void _pageScrollListen() {
    final newPage = _controller.page?.round();
    if (newPage != null && _currentPage != newPage) {
      context.read<OnboardingBloc>().add(OnboardingEventOnPosition(newPage));
      setState(() => _currentPage = newPage);
    }
  }

  void _tapNext(BuildContext context) {
    context.read<OnboardingBloc>().add(OnboardingEventOnNext());
    if (_currentPage < _onboardingData.length - 1) {
      _controller.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  void _scrollTo(int index) {
    if (index != _currentPage) {
      context.read<OnboardingBloc>().add(OnboardingEventOnPosition(index));
      _controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  void _listenCloseState(BuildContext context, OnboardingState state) {
    if (state is OnboardingStateNeedCloseRoute) _closeScreen(context);
  }

  void _closeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(LoginScreenRoute());
  }
}
