import 'package:flutter/material.dart';
import 'dart:math';

class InfiniteIconScroll extends StatefulWidget {
  const InfiniteIconScroll({super.key, required this.size, this.iconSize});

  final Size size;
  final double? iconSize;

  @override
  State<InfiniteIconScroll> createState() => _InfiniteIconScrollState();
}

class _InfiniteIconScrollState extends State<InfiniteIconScroll> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<List<IconData>> icons5x5 = [
    [
      Icons.star,
      Icons.favorite,
      Icons.cake,
      Icons.thumb_up,
      Icons.flash_on,
    ],
    [
      Icons.abc,
      Icons.leave_bags_at_home_outlined,
      Icons.read_more,
      Icons.zoom_out,
      Icons.ac_unit,
    ],
    [
      Icons.camera_indoor_sharp,
      Icons.headset,
      Icons.format_shapes,
      Icons.explore,
      Icons.open_in_new,
    ],
    [
      Icons.repeat_sharp,
      Icons.real_estate_agent,
      Icons.snapchat,
      Icons.sync_rounded,
      Icons.toll,
    ],
    [
      Icons.umbrella,
      Icons.u_turn_left,
      Icons.share,
      Icons.stadium,
      Icons.qr_code,
    ],
  ];
  final List<List<IconData>> icons3x3 = [
    [
      Icons.star,
      Icons.favorite,
      Icons.cake,
    ],
    [
      Icons.abc,
      Icons.leave_bags_at_home_outlined,
      Icons.read_more,
    ],
    [
      Icons.camera_indoor_sharp,
      Icons.headset,
      Icons.format_shapes,
    ],
  ];

  double offset = 0;
  final double speed = .001; // Speed of movement

  late double iconSize;
  late double wIconSpacing;
  late double hIconSpacing;

  @override
  void initState() {
    super.initState();

    iconSize = widget.iconSize ?? 24;
    wIconSpacing = 2 * iconSize;
    hIconSpacing = wIconSpacing * (widget.size.height / widget.size.width);

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 30),
    )..addListener(() {
        _updatePositions();
      });
    _controller.repeat();
  }

  void _updatePositions() {
    setState(() {
      offset += speed;
      if (offset > 1) {
        print('${TimeOfDay.now().hashCode} restart');
        offset = 0;
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    var iconsData = icons5x5; // TODO Why is 3 a magic number here?
    double wShifter = offset * widget.size.width * iconsData.first.length / 3;
    double hShifter = offset * widget.size.height * iconsData.length / 3;
    return Stack(
      children: [
        for (var iconList in iconsData.indexed)
          for (var icon in iconList.$2.indexed)
            Builder(builder: (context) {
              double left = iconList.$1 * wIconSpacing - wShifter;
              double top = icon.$1 * hIconSpacing - hShifter;

              if (left < -iconSize) left += iconsData[iconList.$1].length * wIconSpacing;
              if (top < -iconSize) top += iconList.$2.length * hIconSpacing;

              return Positioned(
                left: left,
                top: top,
                child: Icon(
                  icon.$2,
                  size: iconSize,
                ),
              );
            })
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
