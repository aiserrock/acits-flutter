part of '../photo_gallery_screen.dart';

const _maskSizePart = .6;

class _GalleryItemWidget extends StatelessWidget {
  const _GalleryItemWidget(this.child, {this.onPressed, this.isChoosed = false, this.onEdit});

  final Widget child;
  final VoidCallback? onPressed;
  final bool isChoosed;

  /// Если задан — на ячейке рисуется кнопка «редактировать» (только у фото с
  /// исходными байтами). Тап по ней открывает редактор, не выбирая элемент.
  final VoidCallback? onEdit;

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
                  child: Container(color: Theme.of(context).colorScheme.surface, child: child),
                ),
                if (isChoosed) _buildChooseIcon(context),
                if (onEdit != null) _buildEditButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Material(
          color: Colors.black54,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onEdit,
            child: const Padding(
              padding: EdgeInsets.all(9.0),
              child: Icon(Icons.edit, color: Colors.white, size: 24.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChooseIcon(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: LayoutBuilder(
        builder: (_, cons) {
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
                    color: Theme.of(context).colorScheme.primary,
                    size: maskSize.shortestSide * .6,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
