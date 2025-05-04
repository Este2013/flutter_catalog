import 'dart:math' as math;

import 'package:flutter/material.dart';

const _kTabHorizontalPadding = 24.0; // 12.0 on each side – same as TabBar’s default
const _kMinTabWidth = 72.0; // Material spec for scrollable tabs
const double _kTabHeight = 46.0; // Same as TabBar._kTabHeight

// A TabBar widget which decides dynamically to become scrollable or not depending on available screen size.
class AdaptiveTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AdaptiveTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.indicator,
    this.labelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorWeight = 2.0, // Same as TabBar default
    this.isSecondary = false,
  });

  final List<Widget> tabs;
  final TabController? controller;
  final Decoration? indicator;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final double indicatorWeight;
  final bool isSecondary;

  factory AdaptiveTabBar.secondary({required List<Widget> tabs}) => AdaptiveTabBar(
        tabs: tabs,
        isSecondary: true,
      );

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) => !isSecondary
          ? TabBar(
              controller: controller,
              tabs: tabs,
              isScrollable: _needsScrolling(context, constraints.maxWidth),
              indicator: indicator,
              labelColor: labelColor,
              unselectedLabelColor: unselectedLabelColor,
              labelStyle: labelStyle,
              unselectedLabelStyle: unselectedLabelStyle,
              indicatorWeight: indicatorWeight,
            )
          : TabBar.secondary(
              controller: controller,
              tabs: tabs,
              isScrollable: _needsScrolling(context, constraints.maxWidth),
              indicator: indicator,
              labelColor: labelColor,
              unselectedLabelColor: unselectedLabelColor,
              labelStyle: labelStyle,
              unselectedLabelStyle: unselectedLabelStyle,
              indicatorWeight: indicatorWeight,
            ));

  bool _needsScrolling(BuildContext context, double maxWidth) {
    final textDirection = Directionality.of(context);

    // Sum the *intrinsic* widths of every tab
    double maxActualTabWidth = 0;
    for (final t in tabs) {
      if (t is Tab && t.text != null) {
        final painter = TextPainter(
          text: TextSpan(text: t.text, style: Theme.of(context).tabBarTheme.labelStyle),
          textDirection: textDirection,
          maxLines: 1,
        )..layout();
        var tabWidth = painter.width + 2 * _kTabHorizontalPadding;
        if (tabWidth > maxActualTabWidth) {
          maxActualTabWidth = tabWidth;
        }
      } else {
        // icon-only tab or any custom widget – fall back to the Material minimum so we don’t underestimate
        if (_kMinTabWidth > maxActualTabWidth) {
          maxActualTabWidth = _kMinTabWidth;
        }
      }
    }
    return (maxActualTabWidth * tabs.length) > maxWidth;
  }

  @override
  Size get preferredSize {
    double maxHeight = _kTabHeight;
    for (final Widget item in tabs) {
      if (item is PreferredSizeWidget) {
        final double itemHeight = item.preferredSize.height;
        maxHeight = math.max(itemHeight, maxHeight);
      }
    }
    return Size.fromHeight(maxHeight + indicatorWeight);
  }
}
