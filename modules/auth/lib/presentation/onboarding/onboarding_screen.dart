import 'dart:async';

import 'package:acits_ui_kit/acits_ui_kit.dart';
import 'package:acits_l10n/acits_l10n.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:auth/domain/domain.dart';
import 'package:auth/presentation/onboarding/onboarding.dart';

/// Экран онбординга при входе в приложение.
///
/// [OnboardingBloc] поднимается корнем (см. app_router). App-виджеты (иконка
/// закрытия, debug-шторка) и роутер приходят параметрами — модуль не знает про
/// app-ассеты и app-роуты.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({required this.router, required this.closeIcon, required this.debugDrawer, super.key});

  final AuthRouterService router;
  final Widget closeIcon;
  final Widget debugDrawer;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  _OnboardingScreenState();

  late List<OnboardingData> _onboardingData;
  late final PageController _controller;
  StreamSubscription<OnboardingState>? _blocSub;
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
    _blocSub ??= context.read<OnboardingBloc>().stream.listen(_listenCloseState);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _blocSub?.cancel();
    _controller
      ..removeListener(_pageScrollListen)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(child: widget.debugDrawer),
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
      effect: ExpandingDotsEffect(
        activeDotColor: context.appColors.indicatorActive,
        dotColor: context.appColors.indicatorInactive,
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
          text: state.isLast ? LocaleKeys.commonBegin.tr().toUpperCase() : LocaleKeys.commonNext.tr().toUpperCase(),
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
              Expanded(child: SizedBox.expand(child: data.image)),
              SizedBox(height: isSmallScreen ? 16.0 : 24.0),
              Text(data.title, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
              SizedBox(height: isSmallScreen ? 16.0 : 24.0),
              Text(data.message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCloseBtn(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: CupertinoButton(onPressed: () => _closeScreen(context), child: widget.closeIcon),
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
      _controller.animateToPage(_currentPage + 1, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  void _scrollTo(int index) {
    if (index != _currentPage) {
      context.read<OnboardingBloc>().add(OnboardingEventOnPosition(index));
      _controller.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  void _listenCloseState(OnboardingState state) {
    if (!mounted) return;
    if (state is OnboardingStateNeedCloseRoute) _closeScreen(context);
  }

  void _closeScreen(BuildContext context) {
    widget.router.toLogin();
  }
}
