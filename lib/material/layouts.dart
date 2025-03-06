import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/main.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class LayoutsPresentationPage extends StatelessWidget {
  const LayoutsPresentationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Center(
            child: Wrap(
              runSpacing: 32,
              spacing: 32,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                WidgetPresentation(
                  title: 'MaterialApp',
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.phone_iphone),
                      widgetBuilder: (p0, options) => Container(
                        margin: EdgeInsets.all(8),
                        constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: Center(child: Icon(Icons.home, color: Theme.of(context).iconTheme.color)),
                        ),
                      ),
                    )
                  ],
                  link: 'https://api.flutter.dev/flutter/material/MaterialApp-class.html',
                ),
                WidgetPresentation(
                  title: 'WidgetsApp',
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.phone_iphone),
                      widgetBuilder: (p0, options) => Container(
                        margin: EdgeInsets.all(8),
                        constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: WidgetsApp(
                          debugShowCheckedModeBanner: false,
                          color: Theme.of(context).colorScheme.primary,
                          builder: (context, child) {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3))),
                                  height: 40,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    spacing: 16,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onPrimary),
                                      Text('Widgets app', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 15)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Transform.rotate(angle: pi / 4, child: Icon(Icons.navigation)),
                                  ),
                                ),
                                SizedBox(height: 20)
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                  link: 'https://api.flutter.dev/flutter/widgets/WidgetsApp-class.html',
                ),
                WidgetPresentation(
                  title: 'Scaffold',
                  presentationWindowAlignment: Alignment.center,
                  presentationDeletePadding: true,
                  presentationCardWidget: Stack(
                    children: [
                      Positioned.fill(
                        child: Column(
                          children: [
                            Container(
                              color: Theme.of(context).colorScheme.primary,
                              height: 40,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: 16,
                                children: [
                                  SizedBox(),
                                  Icon(Icons.menu, color: Theme.of(context).colorScheme.onPrimary),
                                  Text('Appbar', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 15)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  child: Center(
                                    child: Text('...'),
                                  )),
                            ),
                            Container(
                              color: Theme.of(context).colorScheme.secondary,
                              height: 40,
                              child: Row(
                                spacing: 16,
                                children: [
                                  SizedBox(),
                                  Text('Bottom bar', style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 15)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned.directional(
                        textDirection: TextDirection.ltr,
                        bottom: 20,
                        end: 10,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primaryContainer,
                            boxShadow: [BoxShadow(offset: Offset(2, 2))],
                          ),
                        ),
                      )
                    ],
                  ),
                  variantsData: [
                    // TODO Scaffold demo
                  ],
                  link: 'https://api.flutter.dev/flutter/material/MaterialApp-class.html',
                ),
              ],
            ),
          ),
        ),
      );
}
