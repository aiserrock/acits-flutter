part of 'animal_detail_screen.dart';

class _AnimalDetailStub extends StatelessWidget {
  const _AnimalDetailStub({required this.onRefresh, this.error});

  final Object? error;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, cons) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        _buildBackBtn(context),
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: 80.0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                LocaleKeys.animalCardTitle.tr(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                        ),
                        if (error == null)
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 80.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Skeleton(height: 120.0, width: 120.0, radius: 60.0),
                                  SizedBox(height: 16.0),
                                  Skeleton(height: 28.0, width: 120.0),
                                  SizedBox(height: 8.0),
                                  Skeleton(height: 22.0, width: 90.0),
                                  SizedBox(height: 24.0),
                                  Skeleton(height: 42.0, width: double.infinity),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (error != null)
                SliverToBoxAdapter(
                  child: ErrorStubWidget(onPressed: onRefresh, height: cons.maxHeight - 80.0),
                ),
              if (error == null) const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
              if (error == null)
                SliverToBoxAdapter(
                  child: Row(
                    children: const [
                      Padding(padding: EdgeInsets.only(left: 16.0), child: Skeleton(height: 22.0, width: 195.0)),
                    ],
                  ),
                ),
              if (error == null)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 64.0),
                    child: Skeleton(height: 148.0),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackBtn(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 80.0,
        child: CupertinoButton(
          padding: const EdgeInsets.all(0.0),
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
