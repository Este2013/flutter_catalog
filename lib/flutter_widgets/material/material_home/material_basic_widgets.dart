// This file is generated. Do not edit unless in the designated section.
// Generator Name   : BasicsWidgetPresentation
// Generator Version: 1.0.0

// ////////////////////////////////////////////////
// GENERATED IMPORTS - DO NOT EDIT
// ////////////////////////////////////////////////
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/flutter_widgets/basics_data.dart';
import 'package:flutter_catalog/presentation/base_presentation.dart';
import 'package:flutter_catalog/presentation/widget_page.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'material_home.dart';

// ////////////////////////////////////////////////
// NON-GENERATED SECTION
// ////////////////////////////////////////////////

Widget _iconFor(String className) {
  switch (className) {
    case "Directionality":
      return Icon(Symbols.format_textdirection_l_to_r);
    case "Opacity":
      return Icon(Symbols.opacity);
    case "ShaderMask":
      return Icon(Symbols.masked_transitions);
    case "BackdropGroup":
      return Icon(Symbols.background_grid_small);
    case "BackdropFilter":
      return Icon(Symbols.background_dot_small);
    case "CustomPaint":
      return Icon(Symbols.format_paint);
    case "ClipRect":
      return Icon(Symbols.crop);

    case "PhysicalModel":
      return Icon(Symbols.ar_stickers);
    case "PhysicalShape":
      return Icon(Symbols.view_in_ar);
    case "Transform":
      return Icon(Symbols.screen_rotation);
    case "CompositedTransformTarget":
      return Icon(Symbols.screen_rotation);
    case "CompositedTransformFollower":
      return Icon(Symbols.screen_rotation);
    case "FittedBox":
      return Icon(Symbols.fit_screen);
    case "FractionalTranslation":
      return Icon(Symbols.magnification_large);
    case "RotatedBox":
      return Icon(Symbols.rotate_90_degrees_ccw);
    case "Padding":
      return Icon(Symbols.padding);
    case "Align":
      return Icon(Symbols.align_horizontal_right);
    case "Center":
      return Icon(Symbols.recenter);
    case "CustomSingleChildLayout":
      return Icon(Symbols.view_array);
    case "LayoutId":
      return Icon(Symbols.category_search);
    case "CustomMultiChildLayout":
      return Icon(Symbols.view_carousel);
    case "SizedBox":
      return Icon(Symbols.resize);
    case "ConstrainedBox":
      return Icon(Symbols.arrows_input);

    case "FractionallySizedBox":
      return Icon(Symbols.magnification_large);
    case "LimitedBox":
      return Icon(Symbols.fit_page_width);
    case "OverflowBox":
      return Icon(Symbols.zoom_out_map);
    case "SizedOverflowBox":
      return Icon(Symbols.zoom_out_map);
    case "Offstage":
      return Icon(Symbols.hide_image);
    case "AspectRatio":
      return Icon(Symbols.aspect_ratio);
    case "IntrinsicWidth":
      return Icon(Symbols.width);
    case "IntrinsicHeight":
      return Icon(Symbols.height);
    case "Baseline":
      return Icon(Symbols.picture_in_picture_center);
    case "IgnoreBaseline":
      return Icon(Symbols.picture_in_picture_off);
    case "SliverToBoxAdapter":
      return Transform.rotate(angle: pi / 2, child: Icon(Symbols.view_carousel));
    case "SliverPadding":
      return Icon(Symbols.format_line_spacing);
    case "ListBody":
      return Icon(Symbols.format_list_bulleted);
    case "Stack":
      return Icon(Symbols.filter_none);
    case "IndexedStack":
      return Icon(Symbols.filter_2);
    case "Positioned":
      return Icon(Symbols.location_on);
    case "PositionedDirectional":
      return Icon(Symbols.location_on);
    case "Flex":
      return Icon(Symbols.table_rows);
    case "Row":
      return Transform.rotate(angle: pi / 2, child: Icon(Symbols.table_rows));
    case "Column":
      return Icon(Symbols.table_rows);
    case "Flexible":
      return Icon(Symbols.expand);
    case "Expanded":
      return Icon(Symbols.expand);
    case "Wrap":
      return Icon(Symbols.format_text_wrap);
    case "Flow":
      return Icon(Symbols.animation);
    // case "RichText":
    case "RawImage":
      return Icon(Symbols.image);
    case "DefaultAssetBundle":
      return Icon(Symbols.folder_zip);
    case "WidgetToRenderBoxAdapter":
      return Icon(Symbols.display_external_input);
    case "Listener":
      return Icon(Symbols.highlight_mouse_cursor);
    case "MouseRegion":
      return Icon(Symbols.touchpad_mouse);
    case "RepaintBoundary":
      return Icon(Symbols.wall_art);
    case "IgnorePointer":
      return Icon(Symbols.touchpad_mouse_off);
    case "AbsorbPointer":
      return Icon(Symbols.touchpad_mouse_off);
    case "MetaData":
      return Icon(Symbols.search_insights);
    case "Semantics":
      return Icon(Symbols.menu_book);

    case "KeyedSubtree":
      return Icon(Symbols.account_tree);
    case "Builder":
      return Icon(Symbols.precision_manufacturing);
    case "ColoredBox":
      return Icon(Symbols.colors);
    default:
      return Icon(Icons.close, color: Colors.red);
  }
}

_pageFor(String className) {
  switch (className) {
    case "Directionality":
      return WidgetPresentation.createPageFrom(
        title: 'Directionality',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: DirectionalityData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Directionality-class.html',
      );
    case "Opacity":
      return WidgetPresentation.createPageFrom(
        title: 'Opacity',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: OpacityData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Opacity-class.html',
      );
    case "ShaderMask":
      return WidgetPresentation.createPageFrom(
        title: 'ShaderMask',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: ShaderMaskData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/ShaderMask-class.html',
      );
    case "BackdropGroup":
      return WidgetPresentation.createPageFrom(
        title: 'BackdropGroup',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: BackdropGroupData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/BackdropGroup-class.html',
      );
    case "BackdropFilter":
      return WidgetPresentation.createPageFrom(
        title: 'BackdropFilter',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: BackdropFilterData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/BackdropFilter-class.html',
      );
    case "CustomPaint":
      return WidgetPresentation.createPageFrom(
        title: 'CustomPaint',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: CustomPaintData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/CustomPaint-class.html',
      );
    case "ClipRect":
      return WidgetPresentation.createPageFrom(
        title: 'ClipRect',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: (_) => Icon(Icons.crop),
            widgetBuilder: null,
            widgetTreeExplanation: ClipRectData(),
          ),
          WidgetVariantData(
            "ClipRRect",
            variantExplanation: 'Clips along a Rounded Rectangle.',
            iconBuilder: (p0) => Icon(Symbols.rounded_corner),
            widgetBuilder: null,
            widgetTreeExplanation: ClipRRectData(),
            docsLink: 'https://api.flutter.dev/flutter/widgets/ClipRRect-class.html',
          ),
          WidgetVariantData(
            "ClipRSuperellipse",
            variantExplanation: 'Clips along an Apple-style superellipse.',
            iconBuilder: (_) => Icon(Symbols.desktop_mac),
            widgetBuilder: null,
            widgetTreeExplanation: ClipRSuperellipseData(),
            docsLink: 'https://api.flutter.dev/flutter/widgets/ClipRSuperellipse-class.html',
          ),
          WidgetVariantData(
            'ClipOval',
            variantExplanation: 'Clips along an oval shape.',
            iconBuilder: (_) => Icon(Symbols.circle),
            widgetBuilder: null,
            widgetTreeExplanation: ClipOvalData(),
            docsLink: 'https://api.flutter.dev/flutter/widgets/ClipOval-class.html',
          ),
          WidgetVariantData(
            "ClipPath",
            variantExplanation: 'Clips along a custom path.',
            iconBuilder: (_) => Icon(Symbols.conversion_path),
            widgetBuilder: null,
            widgetTreeExplanation: ClipPathData(),
            docsLink: 'https://api.flutter.dev/flutter/widgets/ClipPath-class.html',
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/ClipRect-class.html',
      );

    case "PhysicalModel":
      return WidgetPresentation.createPageFrom(
        title: 'PhysicalModel',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: PhysicalModelData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/PhysicalModel-class.html',
      );
    case "PhysicalShape":
      return WidgetPresentation.createPageFrom(
        title: 'PhysicalShape',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: PhysicalShapeData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/PhysicalShape-class.html',
      );
    case "Transform":
      return WidgetPresentation.createPageFrom(
        title: 'Transform',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: TransformData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Transform-class.html',
      );
    case "CompositedTransformTarget":
      return WidgetPresentation.createPageFrom(
        title: 'CompositedTransformTarget',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: CompositedTransformTargetData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/CompositedTransformTarget-class.html',
      );
    case "CompositedTransformFollower":
      return WidgetPresentation.createPageFrom(
        title: 'CompositedTransformFollower',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: CompositedTransformFollowerData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/CompositedTransformFollower-class.html',
      );
    case "FittedBox":
      return WidgetPresentation.createPageFrom(
        title: 'FittedBox',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: FittedBoxData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/FittedBox-class.html',
      );
    case "FractionalTranslation":
      return WidgetPresentation.createPageFrom(
        title: 'FractionalTranslation',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: FractionalTranslationData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/FractionalTranslation-class.html',
      );
    case "RotatedBox":
      return WidgetPresentation.createPageFrom(
        title: 'RotatedBox',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: RotatedBoxData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/RotatedBox-class.html',
      );
    case "Padding":
      return WidgetPresentation.createPageFrom(
        title: 'Padding',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: PaddingData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Padding-class.html',
      );
    case "Align":
      return WidgetPresentation.createPageFrom(
        title: 'Align',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: AlignData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Align-class.html',
      );
    case "Center":
      return WidgetPresentation.createPageFrom(
        title: 'Center',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: CenterData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Center-class.html',
      );
    case "CustomSingleChildLayout":
      return WidgetPresentation.createPageFrom(
        title: 'CustomSingleChildLayout',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: CustomSingleChildLayoutData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/CustomSingleChildLayout-class.html',
      );
    case "LayoutId":
      return WidgetPresentation.createPageFrom(
        title: 'LayoutId',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: LayoutIdData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/LayoutId-class.html',
      );
    case "CustomMultiChildLayout":
      return WidgetPresentation.createPageFrom(
        title: 'CustomMultiChildLayout',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: CustomMultiChildLayoutData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/CustomMultiChildLayout-class.html',
      );
    case "SizedBox":
      return WidgetPresentation.createPageFrom(
        title: 'SizedBox',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: SizedBoxData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/SizedBox-class.html',
      );
    case "ConstrainedBox":
      return WidgetPresentation.createPageFrom(
        title: 'ConstrainedBox',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: (_) => Icon(Symbols.arrows_input),
            widgetBuilder: null,
            widgetTreeExplanation: ConstrainedBoxData(),
          ),
          WidgetVariantData(
            'UnconstrainedBox',
            variantExplanation: '',
            iconBuilder: (_) => Icon(Symbols.arrows_output),
            widgetBuilder: null,
            widgetTreeExplanation: UnconstrainedBoxData(),
            docsLink: 'https://api.flutter.dev/flutter/widgets/UnconstrainedBox-class.html',
          ),
          WidgetVariantData(
            'ConstraintsTransformBox',
            variantExplanation: '',
            iconBuilder: (_) => Icon(Symbols.crop_rotate),
            widgetBuilder: null,
            widgetTreeExplanation: UnconstrainedBoxData(),
            docsLink: 'https://api.flutter.dev/flutter/widgets/ConstraintsTransformBox-class.html',
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/ConstrainedBox-class.html',
      );

    case "FractionallySizedBox":
      return WidgetPresentation.createPageFrom(
        title: 'FractionallySizedBox',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: FractionallySizedBoxData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/FractionallySizedBox-class.html',
      );
    case "LimitedBox":
      return WidgetPresentation.createPageFrom(
        title: 'LimitedBox',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: LimitedBoxData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/LimitedBox-class.html',
      );
    case "OverflowBox":
      return WidgetPresentation.createPageFrom(
        title: 'OverflowBox',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: OverflowBoxData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/OverflowBox-class.html',
      );
    case "SizedOverflowBox":
      return WidgetPresentation.createPageFrom(
        title: 'SizedOverflowBox',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: SizedOverflowBoxData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/SizedOverflowBox-class.html',
      );
    case "Offstage":
      return WidgetPresentation.createPageFrom(
        title: 'Offstage',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: OffstageData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Offstage-class.html',
      );
    case "AspectRatio":
      return WidgetPresentation.createPageFrom(
        title: 'AspectRatio',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: AspectRatioData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/AspectRatio-class.html',
      );
    case "IntrinsicWidth":
      return WidgetPresentation.createPageFrom(
        title: 'IntrinsicWidth',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: IntrinsicWidthData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/IntrinsicWidth-class.html',
      );
    case "IntrinsicHeight":
      return WidgetPresentation.createPageFrom(
        title: 'IntrinsicHeight',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: IntrinsicHeightData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/IntrinsicHeight-class.html',
      );
    case "Baseline":
      return WidgetPresentation.createPageFrom(
        title: 'Baseline',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: BaselineData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Baseline-class.html',
      );
    case "IgnoreBaseline":
      return WidgetPresentation.createPageFrom(
        title: 'IgnoreBaseline',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: IgnoreBaselineData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/IgnoreBaseline-class.html',
      );
    case "SliverToBoxAdapter":
      return WidgetPresentation.createPageFrom(
        title: 'SliverToBoxAdapter',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: SliverToBoxAdapterData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/SliverToBoxAdapter-class.html',
      );
    case "SliverPadding":
      return WidgetPresentation.createPageFrom(
        title: 'SliverPadding',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: SliverPaddingData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/SliverPadding-class.html',
      );
    case "ListBody":
      return WidgetPresentation.createPageFrom(
        title: 'ListBody',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: ListBodyData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/ListBody-class.html',
      );
    case "Stack":
      return WidgetPresentation.createPageFrom(
        title: 'Stack',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: StackData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Stack-class.html',
      );
    case "IndexedStack":
      return WidgetPresentation.createPageFrom(
        title: 'IndexedStack',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: IndexedStackData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/IndexedStack-class.html',
      );
    case "Positioned":
      return WidgetPresentation.createPageFrom(
        title: 'Positioned',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: PositionedData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Positioned-class.html',
      );
    case "PositionedDirectional":
      return WidgetPresentation.createPageFrom(
        title: 'PositionedDirectional',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: PositionedDirectionalData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/PositionedDirectional-class.html',
      );
    case "Flex":
      return WidgetPresentation.createPageFrom(
        title: 'Flex',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: FlexData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Flex-class.html',
      );
    case "Row":
      return WidgetPresentation.createPageFrom(
        title: 'Row',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: RowData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Row-class.html',
      );
    case "Column":
      return WidgetPresentation.createPageFrom(
        title: 'Column',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: ColumnData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Column-class.html',
      );
    case "Flexible":
      return WidgetPresentation.createPageFrom(
        title: 'Flexible',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: FlexibleData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Flexible-class.html',
      );
    case "Expanded":
      return WidgetPresentation.createPageFrom(
        title: 'Expanded',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: ExpandedData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Expanded-class.html',
      );
    case "Wrap":
      return WidgetPresentation.createPageFrom(
        title: 'Wrap',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: WrapData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Wrap-class.html',
      );
    case "Flow":
      return WidgetPresentation.createPageFrom(
        title: 'Flow',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: FlowData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Flow-class.html',
      );
    case "RichText":
      return WidgetPresentation.createPageFrom(
        title: 'RichText',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: RichTextData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/RichText-class.html',
      );
    case "RawImage":
      return WidgetPresentation.createPageFrom(
        title: 'RawImage',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: RawImageData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/RawImage-class.html',
      );
    case "DefaultAssetBundle":
      return WidgetPresentation.createPageFrom(
        title: 'DefaultAssetBundle',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: DefaultAssetBundleData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/DefaultAssetBundle-class.html',
      );
    case "WidgetToRenderBoxAdapter":
      return WidgetPresentation.createPageFrom(
        title: 'WidgetToRenderBoxAdapter',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: WidgetToRenderBoxAdapterData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/WidgetToRenderBoxAdapter-class.html',
      );
    case "Listener":
      return WidgetPresentation.createPageFrom(
        title: 'Listener',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: ListenerData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Listener-class.html',
      );
    case "MouseRegion":
      return WidgetPresentation.createPageFrom(
        title: 'MouseRegion',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: MouseRegionData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/MouseRegion-class.html',
      );
    case "RepaintBoundary":
      return WidgetPresentation.createPageFrom(
        title: 'RepaintBoundary',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: RepaintBoundaryData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/RepaintBoundary-class.html',
      );
    case "IgnorePointer":
      return WidgetPresentation.createPageFrom(
        title: 'IgnorePointer',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: IgnorePointerData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/IgnorePointer-class.html',
      );
    case "AbsorbPointer":
      return WidgetPresentation.createPageFrom(
        title: 'AbsorbPointer',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: AbsorbPointerData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/AbsorbPointer-class.html',
      );
    case "MetaData":
      return WidgetPresentation.createPageFrom(
        title: 'MetaData',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: MetaDataData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/MetaData-class.html',
      );
    case "Semantics":
      return WidgetPresentation.createPageFrom(
        title: 'Semantics',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: (_) => Icon(Symbols.book_2),
            widgetBuilder: null,
            widgetTreeExplanation: SemanticsData(),
          ),
          WidgetVariantData(
            'MergeSemantics',
            variantExplanation: '',
            iconBuilder: (_) => Transform.rotate(angle: pi / 2, child: Icon(Symbols.merge)),
            widgetBuilder: null,
            widgetTreeExplanation: MergeSemanticsData(),
            docsLink: 'https://api.flutter.dev/flutter/widgets/MergeSemantics-class.html',
          ),
          WidgetVariantData(
            'BlockSemantics',
            variantExplanation: '',
            iconBuilder: (_) => Icon(Symbols.block),
            widgetBuilder: null,
            widgetTreeExplanation: BlockSemanticsData(),
            docsLink: 'https://api.flutter.dev/flutter/widgets/BlockSemantics-class.html',
          ),
          WidgetVariantData(
            "ExcludeSemantics",
            variantExplanation: '',
            iconBuilder: (_) => Icon(Symbols.remove_circle),
            widgetBuilder: null,
            widgetTreeExplanation: ExcludeSemanticsData(),
            docsLink: 'https://api.flutter.dev/flutter/widgets/ExcludeSemantics-class.html',
          ),
          WidgetVariantData(
            'IndexedSemantics',
            variantExplanation: '',
            iconBuilder: (_) => Icon(Symbols.numbers),
            widgetBuilder: null,
            widgetTreeExplanation: IndexedSemanticsData(),
            docsLink: 'https://api.flutter.dev/flutter/widgets/IndexedSemantics-class.html',
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Semantics-class.html',
      );

    case "KeyedSubtree":
      return WidgetPresentation.createPageFrom(
        title: 'KeyedSubtree',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: KeyedSubtreeData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/KeyedSubtree-class.html',
      );
    case "Builder":
      return WidgetPresentation.createPageFrom(
        title: 'Builder',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: BuilderData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/Builder-class.html',
      );
    case "ColoredBox":
      return WidgetPresentation.createPageFrom(
        title: 'ColoredBox',
        variantsData: [
          WidgetVariantData(
            null,
            variantExplanation: '',
            iconBuilder: null,
            widgetBuilder: null,
            widgetTreeExplanation: ColoredBoxData(),
          ),
        ],
        link: 'https://api.flutter.dev/flutter/widgets/ColoredBox-class.html',
      );
    default:
      return WidgetPresentationPage('NULL', variantsData: []);
  }
}

Map<String?, Iterable<CustomCardItem>> get groupedBasicWidgetsList {
  var list = filteredBasicWidgetsList.toList();
  return {
    'Size and alignment': _removeWhereAndReturn(
        list,
        (e) => [
              'FittedBox',
              'Align',
              'Center',
              'Padding',
              'SizedBox',
              'ConstrainedBox',
              'LimitedBox',
              'IntrinsicWidth',
              'IntrinsicHeight',
              'FractionallySizedBox',
              'AspectRatio',
            ].contains(e.title)),
    'Rows and columns': _removeWhereAndReturn(
        list,
        (e) => [
              'Flex',
              'Row',
              'Column',
              'Flexible',
              'Expanded',
              'Wrap',
            ].contains(e.title)),
    'Stacking': _removeWhereAndReturn(
        list,
        (e) => [
              'Stack',
              'IndexedStack',
              'Positioned',
              'PositionedDirectional',
            ].contains(e.title)),
    'Transformations': _removeWhereAndReturn(
        list,
        (e) => [
              'Transform',
              'CompositedTransformTarget',
              'CompositedTransformFollower',
              'FractionalTranslation',
              'RotatedBox',
            ].contains(e.title)),
    'Mouse interactions': _removeWhereAndReturn(
        list,
        (e) => [
              'Listener',
              'MouseRegion',
              'IgnorePointer',
              'AbsorbPointer',
            ].contains(e.title)),
    null: list,
  };
}

List<CustomCardItem> get filteredBasicWidgetsList => basicWidgetsList
    .where((e) => ![
          'ClipRRect',
          'ClipRSuperellipse',
          'ClipOval',
          'ClipPath',
          'RichText',
          'MergeSemantics',
          'BlockSemantics',
          'ExcludeSemantics',
          'IndexedSemantics',
          'UnconstrainedBox',
          'ConstraintsTransformBox',
        ].contains(e.title))
    .toList();

List<T> _removeWhereAndReturn<T>(List<T> list, bool Function(T) test) {
  final removed = <T>[];
  list.removeWhere((element) {
    if (test(element)) {
      removed.add(element);
      return true;
    }
    return false;
  });
  return removed;
}

// ////////////////////////////////////////////////
// GENERATED CODE - DO NOT EDIT
// ////////////////////////////////////////////////

List<CustomCardItem> get basicWidgetsList => [
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Directionality"),
        title: 'Directionality',
        page: _pageFor("Directionality"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Opacity"),
        title: 'Opacity',
        page: _pageFor("Opacity"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ShaderMask"),
        title: 'ShaderMask',
        page: _pageFor("ShaderMask"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("BackdropGroup"),
        title: 'BackdropGroup',
        page: _pageFor("BackdropGroup"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("BackdropFilter"),
        title: 'BackdropFilter',
        page: _pageFor("BackdropFilter"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("CustomPaint"),
        title: 'CustomPaint',
        page: _pageFor("CustomPaint"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ClipRect"),
        title: 'ClipRect',
        page: _pageFor("ClipRect"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ClipRRect"),
        title: 'ClipRRect',
        page: _pageFor("ClipRRect"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ClipRSuperellipse"),
        title: 'ClipRSuperellipse',
        page: _pageFor("ClipRSuperellipse"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ClipOval"),
        title: 'ClipOval',
        page: _pageFor("ClipOval"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ClipPath"),
        title: 'ClipPath',
        page: _pageFor("ClipPath"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("PhysicalModel"),
        title: 'PhysicalModel',
        page: _pageFor("PhysicalModel"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("PhysicalShape"),
        title: 'PhysicalShape',
        page: _pageFor("PhysicalShape"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Transform"),
        title: 'Transform',
        page: _pageFor("Transform"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("CompositedTransformTarget"),
        title: 'CompositedTransformTarget',
        page: _pageFor("CompositedTransformTarget"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("CompositedTransformFollower"),
        title: 'CompositedTransformFollower',
        page: _pageFor("CompositedTransformFollower"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("FittedBox"),
        title: 'FittedBox',
        page: _pageFor("FittedBox"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("FractionalTranslation"),
        title: 'FractionalTranslation',
        page: _pageFor("FractionalTranslation"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("RotatedBox"),
        title: 'RotatedBox',
        page: _pageFor("RotatedBox"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Padding"),
        title: 'Padding',
        page: _pageFor("Padding"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Align"),
        title: 'Align',
        page: _pageFor("Align"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Center"),
        title: 'Center',
        page: _pageFor("Center"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("CustomSingleChildLayout"),
        title: 'CustomSingleChildLayout',
        page: _pageFor("CustomSingleChildLayout"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("LayoutId"),
        title: 'LayoutId',
        page: _pageFor("LayoutId"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("CustomMultiChildLayout"),
        title: 'CustomMultiChildLayout',
        page: _pageFor("CustomMultiChildLayout"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("SizedBox"),
        title: 'SizedBox',
        page: _pageFor("SizedBox"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ConstrainedBox"),
        title: 'ConstrainedBox',
        page: _pageFor("ConstrainedBox"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ConstraintsTransformBox"),
        title: 'ConstraintsTransformBox',
        page: _pageFor("ConstraintsTransformBox"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("UnconstrainedBox"),
        title: 'UnconstrainedBox',
        page: _pageFor("UnconstrainedBox"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("FractionallySizedBox"),
        title: 'FractionallySizedBox',
        page: _pageFor("FractionallySizedBox"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("LimitedBox"),
        title: 'LimitedBox',
        page: _pageFor("LimitedBox"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("OverflowBox"),
        title: 'OverflowBox',
        page: _pageFor("OverflowBox"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("SizedOverflowBox"),
        title: 'SizedOverflowBox',
        page: _pageFor("SizedOverflowBox"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Offstage"),
        title: 'Offstage',
        page: _pageFor("Offstage"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("AspectRatio"),
        title: 'AspectRatio',
        page: _pageFor("AspectRatio"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("IntrinsicWidth"),
        title: 'IntrinsicWidth',
        page: _pageFor("IntrinsicWidth"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("IntrinsicHeight"),
        title: 'IntrinsicHeight',
        page: _pageFor("IntrinsicHeight"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Baseline"),
        title: 'Baseline',
        page: _pageFor("Baseline"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("IgnoreBaseline"),
        title: 'IgnoreBaseline',
        page: _pageFor("IgnoreBaseline"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("SliverToBoxAdapter"),
        title: 'SliverToBoxAdapter',
        page: _pageFor("SliverToBoxAdapter"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("SliverPadding"),
        title: 'SliverPadding',
        page: _pageFor("SliverPadding"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ListBody"),
        title: 'ListBody',
        page: _pageFor("ListBody"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Stack"),
        title: 'Stack',
        page: _pageFor("Stack"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("IndexedStack"),
        title: 'IndexedStack',
        page: _pageFor("IndexedStack"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Positioned"),
        title: 'Positioned',
        page: _pageFor("Positioned"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("PositionedDirectional"),
        title: 'PositionedDirectional',
        page: _pageFor("PositionedDirectional"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Flex"),
        title: 'Flex',
        page: _pageFor("Flex"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Row"),
        title: 'Row',
        page: _pageFor("Row"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Column"),
        title: 'Column',
        page: _pageFor("Column"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Flexible"),
        title: 'Flexible',
        page: _pageFor("Flexible"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Expanded"),
        title: 'Expanded',
        page: _pageFor("Expanded"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Wrap"),
        title: 'Wrap',
        page: _pageFor("Wrap"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Flow"),
        title: 'Flow',
        page: _pageFor("Flow"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("RichText"),
        title: 'RichText',
        page: _pageFor("RichText"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("RawImage"),
        title: 'RawImage',
        page: _pageFor("RawImage"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("DefaultAssetBundle"),
        title: 'DefaultAssetBundle',
        page: _pageFor("DefaultAssetBundle"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("WidgetToRenderBoxAdapter"),
        title: 'WidgetToRenderBoxAdapter',
        page: _pageFor("WidgetToRenderBoxAdapter"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Listener"),
        title: 'Listener',
        page: _pageFor("Listener"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("MouseRegion"),
        title: 'MouseRegion',
        page: _pageFor("MouseRegion"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("RepaintBoundary"),
        title: 'RepaintBoundary',
        page: _pageFor("RepaintBoundary"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("IgnorePointer"),
        title: 'IgnorePointer',
        page: _pageFor("IgnorePointer"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("AbsorbPointer"),
        title: 'AbsorbPointer',
        page: _pageFor("AbsorbPointer"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("MetaData"),
        title: 'MetaData',
        page: _pageFor("MetaData"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Semantics"),
        title: 'Semantics',
        page: _pageFor("Semantics"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("MergeSemantics"),
        title: 'MergeSemantics',
        page: _pageFor("MergeSemantics"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("BlockSemantics"),
        title: 'BlockSemantics',
        page: _pageFor("BlockSemantics"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ExcludeSemantics"),
        title: 'ExcludeSemantics',
        page: _pageFor("ExcludeSemantics"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("IndexedSemantics"),
        title: 'IndexedSemantics',
        page: _pageFor("IndexedSemantics"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("KeyedSubtree"),
        title: 'KeyedSubtree',
        page: _pageFor("KeyedSubtree"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("Builder"),
        title: 'Builder',
        page: _pageFor("Builder"),
      ),
      CustomCardItem.widgetPresentation(
        leading: _iconFor("ColoredBox"),
        title: 'ColoredBox',
        page: _pageFor("ColoredBox"),
      ),
    ];
