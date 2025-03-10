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
                        child: IgnorePointer(
                          child: MaterialApp(
                            debugShowCheckedModeBanner: false,
                            home: Center(child: Icon(Icons.home, color: Theme.of(context).iconTheme.color)),
                          ),
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
                  defaultOptionsBuilder: (currentOptions, submitNewOptions) => Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Text('UI elements', style: Theme.of(context).textTheme.titleMedium),
                          FilterChip(
                            label: Text('AppBar'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['appBar'] = v),
                            selected: currentOptions?['appBar'] ?? true,
                          ),
                          FilterChip(
                            label: Text('BottomNavBar'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['bottomNavBar'] = v),
                            selected: currentOptions?['bottomNavBar'] ?? true,
                          ),
                          FilterChip(
                            label: Text('BottomSheet'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['bottomSheet'] = v),
                            selected: currentOptions?['bottomSheet'] ?? false,
                          ),
                        ],
                      ),
                      Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 8, runSpacing: 8, children: [
                        Text('Body:'),
                        Checkbox(
                          value: currentOptions?['body'] ?? true,
                          onChanged: (v) => submitNewOptions((currentOptions ?? {})..['body'] = v),
                        ),
                        FilterChip(
                          label: Text('extendBody'),
                          onSelected: (currentOptions?['body'] ?? true) ? (v) => submitNewOptions((currentOptions ?? {})..['extendBody'] = v) : null,
                          selected: currentOptions?['extendBody'] ?? false,
                        ),
                        FilterChip(
                          label: Text('extendBodyBehindAppBar'),
                          onSelected: (currentOptions?['body'] ?? true) ? (v) => submitNewOptions((currentOptions ?? {})..['extendBodyBehindAppBar'] = v) : null,
                          selected: currentOptions?['extendBodyBehindAppBar'] ?? false,
                        ),
                      ]),
                      Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 8, runSpacing: 8, children: [
                        Text('Drawers:'),
                        FilterChip(
                          label: Text('Drawer'),
                          onSelected: (v) => submitNewOptions((currentOptions ?? {})..['drawer'] = v),
                          selected: currentOptions?['drawer'] ?? false,
                        ),
                        FilterChip(
                          label: Text('EndDrawer'),
                          onSelected: (v) => submitNewOptions((currentOptions ?? {})..['endDrawer'] = v),
                          selected: currentOptions?['endDrawer'] ?? false,
                        ),
                        if (!(currentOptions?['appBar'] ?? true))
                          Tooltip(
                            message: 'In this example, you need the AppBar to open drawers.\nBy default, AppBar handles drawers automatically.',
                            child: Icon(Icons.info),
                          )
                      ]),
                      Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 8, runSpacing: 8, children: [
                        Text('FloatingActionButton:'),
                        Checkbox(
                          value: currentOptions?['floatingActionButton'] ?? false,
                          onChanged: (v) => submitNewOptions((currentOptions ?? {})..['floatingActionButton'] = v),
                        ),
                        DropdownMenu(
                          dropdownMenuEntries: [
                            for (var l in [
                              FloatingActionButtonLocation.centerDocked,
                              FloatingActionButtonLocation.centerFloat,
                              FloatingActionButtonLocation.centerTop,
                              FloatingActionButtonLocation.endContained,
                              FloatingActionButtonLocation.endDocked,
                              FloatingActionButtonLocation.endFloat,
                              FloatingActionButtonLocation.endTop,
                              FloatingActionButtonLocation.miniCenterDocked,
                              FloatingActionButtonLocation.miniCenterFloat,
                              FloatingActionButtonLocation.miniCenterTop,
                              FloatingActionButtonLocation.miniEndDocked,
                              FloatingActionButtonLocation.miniEndFloat,
                              FloatingActionButtonLocation.miniEndTop,
                              FloatingActionButtonLocation.miniStartDocked,
                              FloatingActionButtonLocation.startFloat,
                              FloatingActionButtonLocation.miniStartTop,
                              FloatingActionButtonLocation.startDocked,
                              FloatingActionButtonLocation.startFloat,
                              FloatingActionButtonLocation.startTop,
                            ])
                              DropdownMenuEntry(value: l, label: l.toString().split('.')[1])
                          ],
                          initialSelection: FloatingActionButtonLocation.endFloat,
                          enabled: currentOptions?['floatingActionButton'] ?? false,
                          label: Text('Location'),
                          onSelected: (v) => submitNewOptions((currentOptions ?? {})..['floatingActionButtonLocation'] = v),
                        )
                      ]),
                      Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 8, runSpacing: 8, children: [
                        Text('PersistentFooterButtons:'),
                        Checkbox(
                          value: currentOptions?['persistentFooterButtons'] ?? false,
                          onChanged: (v) => submitNewOptions((currentOptions ?? {})..['persistentFooterButtons'] = v),
                        ),
                        DropdownMenu(
                          dropdownMenuEntries: [
                            for (var l in [
                              AlignmentDirectional.bottomCenter,
                              AlignmentDirectional.bottomEnd,
                              AlignmentDirectional.bottomStart,
                              AlignmentDirectional.center,
                              AlignmentDirectional.centerEnd,
                              AlignmentDirectional.centerStart,
                              AlignmentDirectional.topCenter,
                              AlignmentDirectional.topEnd,
                              AlignmentDirectional.topStart,
                            ])
                              DropdownMenuEntry(value: l, label: l.toString().split('.')[1])
                          ],
                          initialSelection: AlignmentDirectional.centerEnd,
                          enabled: currentOptions?['persistentFooterButtons'] ?? false,
                          label: Text('Alignment'),
                          onSelected: (v) => submitNewOptions((currentOptions ?? {})..['persistentFooterAlignment'] = v),
                        )
                      ]),
                    ],
                  ),
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Symbols.house_siding),
                      widgetBuilder: (p0, options) => Scaffold(
                        key: Key('demo scaffold'),
                        appBar: (options?['appBar'] ?? true) ? AppBar(title: Text('AppBar')) : null,
                        body: (options?['body'] ?? true)
                            ? ListView(
                                children: [
                                  for (int i = 0; i < 1000; i++)
                                    ListTile(
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: [
                                          Colors.deepPurple,
                                          Colors.purple,
                                          Colors.indigo,
                                          Colors.blue,
                                          Colors.green,
                                          Colors.lime,
                                          Colors.yellow,
                                          Colors.amber,
                                          Colors.orange,
                                          Colors.red,
                                          Colors.red.shade900
                                        ][(i / 10).floor() % 10],
                                      ),
                                      title: Text('Music #$i'),
                                      subtitle: Text('by artist #${(i / 10).floor()}'),
                                      onTap: () {},
                                      trailing: Row(
                                        spacing: 8,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.more_horiz),
                                        ],
                                      ),
                                    )
                                ],
                              )
                            : null,
                        bottomSheet: (options?['bottomSheet'] ?? false)
                            ? BottomSheet(
                                onClosing: () {},
                                builder: (context) => Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(onPressed: () {}, icon: Icon(Icons.skip_previous)),
                                        IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
                                        IconButton(onPressed: () {}, icon: Icon(Icons.skip_next)),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : null,
                        bottomNavigationBar: (options?['bottomNavBar'] ?? true)
                            ? BottomNavigationBar(items: [
                                BottomNavigationBarItem(icon: Icon(Symbols.music_note), label: 'Songs'),
                                BottomNavigationBarItem(icon: Icon(Symbols.artist, fill: 1), label: 'Artists'),
                                BottomNavigationBarItem(icon: Icon(Symbols.album, fill: 1), label: 'Albums'),
                              ])
                            : null,
                        drawer: (options?['drawer'] ?? false) ? Drawer() : null,
                        endDrawer: (options?['endDrawer'] ?? false) ? Drawer() : null,
                        extendBody: (options?['extendBody'] ?? false),
                        extendBodyBehindAppBar: options?['extendBodyBehindAppBar'] ?? false,
                        floatingActionButton: (options?['floatingActionButton'] ?? false) ? FloatingActionButton(onPressed: () {}, child: Icon(Icons.settings)) : null,
                        floatingActionButtonLocation: options?['floatingActionButtonLocation'],
                        persistentFooterAlignment: options?['persistentFooterAlignment'] ?? AlignmentDirectional.centerEnd,
                        persistentFooterButtons: (options?['persistentFooterButtons'] ?? false) ? [OutlinedButton(onPressed: () {}, child: Text('Licenses'))] : null,
                      ),
                    )
                  ],
                  link: 'https://api.flutter.dev/flutter/material/MaterialApp-class.html',
                ),
                Row(
                  spacing: 16,
                  children: [Text('Navigation', style: Theme.of(context).textTheme.titleLarge), Expanded(child: Divider())],
                ),
                // TODO
              ],
            ),
          ),
        ),
      );
}
