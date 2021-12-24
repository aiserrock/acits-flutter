import 'package:acits_flutter/gen/assets.gen.dart';
import 'package:acits_flutter/generated/l10n.dart';
import 'package:acits_flutter/res/color.dart';
import 'package:acits_flutter/res/strings.dart';
import 'package:acits_flutter/res/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class _OnboardingData {
  final SvgGenImage image;
  final String title;
  final String message;

  _OnboardingData({
    required this.image,
    required this.title,
    required this.message,
  });
}

final _onboardingData = <_OnboardingData>[
  _OnboardingData(
    image: const $AssetsOnboardingGen().plan,
    title: StringRes.current.onboardingPlanTitle,
    message: StringRes.current.onboardingPlanMsg,
  ),
  _OnboardingData(
    image: const $AssetsOnboardingGen().news,
    title: StringRes.current.onboardingNewsTitle,
    message: StringRes.current.onboardingNewsMsg,
  ),
  _OnboardingData(
    image: const $AssetsOnboardingGen().drugs,
    title: StringRes.current.onboardingDrugsTitle,
    message: StringRes.current.onboardingDrugsMsg,
  ),
  _OnboardingData(
    image: const $AssetsOnboardingGen().free,
    title: StringRes.current.onboardingFreeTitle,
    message: StringRes.current.onboardingFreeMsg,
  ),
];

/// Экран онбординга при входе в приложение
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _controller.addListener(_pageScrollListen);
  }

  @override
  void dispose() {
    _controller.removeListener(_pageScrollListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    _buildBtn(),
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

  Widget _buildBtn() {
    return ElevatedButton(
      onPressed: _tapNext,
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(fontSize: 16.0),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        ),
        backgroundColor: MaterialStateProperty.all(ColorRes.primaryButton),
      ),
      child: Text(
        _currentPage == _onboardingData.length - 1
            ? StringRes.current.commonBegin.toUpperCase()
            : StringRes.current.commonNext.toUpperCase(),
      ),
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
        onPressed: Navigator.of(context).pop,
        child: const $AssetsIconGen().close.svg(),
      ),
    );
  }

  void _pageScrollListen() {
    final newPage = _controller.page?.round();
    if (newPage != null && _currentPage != newPage) {
      setState(() => _currentPage = newPage);
    }
  }

  void _tapNext() {
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
      _controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }
}
