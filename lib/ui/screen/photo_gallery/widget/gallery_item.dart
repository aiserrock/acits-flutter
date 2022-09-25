part of '../photo_gallery_screen.dart';

const _maskSizePart = .6;

class _GalleryItemWidget extends StatelessWidget {
  const _GalleryItemWidget(
    this.child, {
    this.onPressed,
    this.isChoosed = false,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final bool isChoosed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed ?? () {},
      padding: const EdgeInsets.all(0.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: ColorRes.foreground,
                    child: child,
                  ),
                ),
                if (isChoosed) _buildChooseIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChooseIcon() {
    return Align(
      alignment: Alignment.bottomRight,
      child: LayoutBuilder(builder: (_, cons) {
        final maskSize = cons.biggest * _maskSizePart;
        return ClipPath(
          clipper: _CornerClipper(),
          child: Container(
            height: maskSize.width,
            width: maskSize.height,
            color: Colors.white54,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.done,
                  color: ColorRes.accent,
                  size: maskSize.shortestSide * .6,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
