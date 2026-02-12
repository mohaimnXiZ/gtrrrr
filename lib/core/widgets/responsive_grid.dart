import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final EdgeInsets padding;
  final bool forHomeScreen;
  final bool forFavoriteScreen;
  final bool forSearchScreen;

  const ResponsiveGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
    this.padding = const EdgeInsets.all(16),
    this.forHomeScreen = false,
    this.forFavoriteScreen = false,
    this.forSearchScreen = false,
  });

  int _calculateColumnsDefault(double width) {
    if (width < 600) return 1;
    if (width < 1000) return 2;
    if (width < 1400) return 3;
    return 4;
  }

  int _calculateColumnsForHome(double width) {
    if (width < 600) return 1;
    if (width < 1000) return 2;
    if (width < 1400) return 3;
    return 4;
  }

  int _calculateColumnsForFavorite(double width) {
    if (width < 600) return 1;
    if (width < 1000) return 2;
    if (width < 1400) return 3;
    return 4;
  }

  int _calculateColumnsForSearch(double width) {
    if (width < 600) return 1;
    if (width < 1000) return 2;
    if (width < 1400) return 3;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    // Get width from MediaQuery instead of LayoutBuilder to avoid hit-test nulls
    final double width = MediaQuery.of(context).size.width;
    final int columns = forHomeScreen
        ? _calculateColumnsForHome(width)
        : forFavoriteScreen
        ? _calculateColumnsForFavorite(width)
        : forSearchScreen
        ? _calculateColumnsForSearch(width)
        : _calculateColumnsDefault(width);
    final List<Widget> rowWidgets = [];

    for (int i = 0; i < itemCount; i += columns) {
      final int rowEndIndex = (i + columns < itemCount) ? i + columns : itemCount;

      rowWidgets.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(columns, (columnIndex) {
              final int itemIndex = i + columnIndex;

              if (itemIndex >= itemCount) {
                return const Expanded(child: SizedBox.shrink());
              }

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: columnIndex == 0 ? 0 : crossAxisSpacing / 2,
                    right: columnIndex == columns - 1 ? 0 : crossAxisSpacing / 2,
                    bottom: mainAxisSpacing,
                  ),
                  child: itemBuilder(context, itemIndex),
                ),
              );
            }),
          ),
        ),
      );
    }

    return Padding(
      padding: padding,
      child: Column(mainAxisSize: MainAxisSize.min, children: rowWidgets),
    );
  }
}
