part of 'animal_detail_screen.dart';

const _minHeight = 130.0;
const _maxHeight = 340.0;
const _duration = Duration(milliseconds: 100);

class _AnimalCardHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _AnimalCardHeaderDelegate(
    this.animal, {
    this.tabBar,
  });

  final AnimalRead animal;
  final Widget? tabBar;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final delta = (maxExtent - shrinkOffset - minExtent) / (maxExtent - minExtent);
    final shrink = min(1.0, max(0, 1.0 - delta)).toDouble();
    return Container(
      color: ColorRes.foreground,
      child: Column(
        children: [
          Expanded(
            child: AnimatedContainer(
              duration: _duration,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildBackBtn(context),
                    _buildTitle(shrink),
                    _buildTitleExpand(shrink),
                    _buildImage(shrink),
                  ],
                ),
              ),
            ),
          ),
          tabBar ?? const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildImage(double shrink) {
    final thumb = animal.thumb;
    return Align(
      alignment: Alignment.lerp(
            Alignment.center,
            Alignment.topLeft,
            Curves.easeOutExpo.transform(shrink),
          ) ??
          Alignment.center,
      child: Padding(
        padding: EdgeInsets.lerp(
              const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 4.0),
              Curves.easeInExpo.transform(shrink),
            ) ??
            const EdgeInsets.only(top: 64.0),
        child: SizedBox(
          height: 120.0,
          width: 120.0,
          child: thumb != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(thumb),
                  backgroundColor: ColorRes.background,
                )
              : Assets.image.animalStub.image(),
        ),
      ),
    );
  }

  Widget _buildTitleExpand(double shrink) {
    return Align(
      alignment: Alignment.lerp(
            Alignment.bottomCenter,
            Alignment.topLeft,
            Curves.easeInExpo.transform(shrink),
          ) ??
          Alignment.center,
      child: Padding(
        padding: EdgeInsets.lerp(
              const EdgeInsets.only(bottom: 16.0),
              const EdgeInsets.only(left: 118.0),
              shrink,
            ) ??
            const EdgeInsets.only(bottom: 16.0),
        child: SizedBox(
          height: 80.0,
          child: Align(
            alignment: Alignment.lerp(
                  Alignment.bottomCenter,
                  Alignment.centerLeft,
                  shrink,
                ) ??
                Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.lerp(
                          Alignment.center,
                          Alignment.centerLeft,
                          shrink,
                        ) ??
                        Alignment.center,
                    child: Text(
                      animal.name ?? '',
                      style: TextStyle.lerp(
                        StyleRes.title.copyWith(fontSize: 28.0),
                        StyleRes.title,
                        shrink,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.lerp(
                        Alignment.center,
                        Alignment.centerLeft,
                        shrink,
                      ) ??
                      Alignment.center,
                  child: Text(
                    animal.id?.toString() ?? '',
                    style: TextStyle.lerp(
                      StyleRes.titleLight.copyWith(fontSize: 22.0),
                      StyleRes.titleLight.copyWith(fontSize: 16.0),
                      shrink,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(double shrink) {
    return AnimatedOpacity(
      duration: _duration,
      opacity: Curves.easeInExpo.transform(1.0 - shrink),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 80.0,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              StringRes.current.animalCardTitle,
              style: StyleRes.title,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackBtn(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 80.0,
        child: CupertinoButton(
          padding: const EdgeInsets.only(),
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorRes.accent,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  double get maxExtent => _maxHeight;

  @override
  double get minExtent => _minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
