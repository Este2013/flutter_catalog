import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
                WidgetPresentation(
                  title: 'AppBar',
                  presentationWindowAlignment: Alignment.topCenter,
                  presentationDeletePadding: true,
                  defaultOptionsBuilder: (currentOptions, submitNewOptions) => Column(
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilterChip(
                            label: Text('Title'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['title'] = v),
                            selected: currentOptions?['title'] ?? true,
                          ),
                          FilterChip(
                            label: Text('Center title'),
                            onSelected: (currentOptions?['title'] ?? true) ? (v) => submitNewOptions((currentOptions ?? {})..['centerTitle'] = v) : null,
                            selected: currentOptions?['centerTitle'] ?? false,
                          ),
                          FilterChip(
                            label: Text('Actions'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['actions'] = v),
                            selected: currentOptions?['actions'] ?? true,
                          ),
                          FilterChip(
                            label: Text('Background color'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['bgColor'] = v),
                            selected: currentOptions?['bgColor'] ?? true,
                          ),
                          FilterChip(
                            label: Text('Leading'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['leading'] = v),
                            selected: currentOptions?['leading'] ?? false,
                          ),
                          FilterChip(
                            label: Text('Bottom'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['bottom'] = v),
                            selected: currentOptions?['bottom'] ?? false,
                          ),
                          FilterChip(
                            label: Text('FlexibleSpace'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['flexibleSpace'] = v),
                            selected: currentOptions?['flexibleSpace'] ?? false,
                          ),
                        ],
                      )
                    ],
                  ),
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.phone_iphone),
                      widgetBuilder: (p0, options) => DefaultTabController(
                        length: 3,
                        child: Scaffold(
                          appBar: AppBar(
                            centerTitle: options?['centerTitle'] ?? false,
                            title: (options?['title'] ?? true) ? Text('AppBar', style: TextStyle(color: (options?['bgColor'] ?? true) ? Theme.of(context).colorScheme.onPrimary : null)) : null,
                            backgroundColor: (options?['bgColor'] ?? true) ? Theme.of(context).colorScheme.primary : null,
                            actions: (options?['actions'] ?? true)
                                ? [
                                    IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
                                    IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                                    IconButton(onPressed: () {}, icon: Icon(Icons.account_circle)),
                                  ]
                                : null,
                            iconTheme: IconThemeData(color: (options?['bgColor'] ?? true) ? Theme.of(context).colorScheme.onPrimary : null),
                            leading: (options?['leading'] ?? false) ? IconButton(onPressed: () {}, icon: Icon(Icons.home)) : null,
                            automaticallyImplyLeading: false,
                            bottom: (options?['bottom'] ?? false)
                                ? TabBar(
                                    indicatorColor: (options?['bgColor'] ?? true) ? Theme.of(context).colorScheme.onPrimary : null,
                                    labelColor: (options?['bgColor'] ?? true) ? Theme.of(context).colorScheme.onPrimary : null,
                                    unselectedLabelColor: (options?['bgColor'] ?? true) ? Theme.of(context).colorScheme.onPrimaryFixedVariant : null,
                                    tabs: [
                                      Tab(icon: Icon(Icons.directions_car)),
                                      Tab(icon: Icon(Icons.directions_transit)),
                                      Tab(icon: Icon(Icons.directions_bike)),
                                    ],
                                  )
                                : null,
                            flexibleSpace: (options?['flexibleSpace'] ?? false)
                                ? FlexibleSpaceBar(
                                    background: Container(
                                        decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.blue, Colors.lightGreen],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    )),
                                  )
                                : null,
                            primary: false,
                          ),
                        ),
                      ),
                    )
                  ],
                  link: 'https://api.flutter.dev/flutter/material/AppBar-class.html?_gl=1*gsq41x*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTc0MTcwNjQzNS45MS4xLjE3NDE3MDY0NTguMC4wLjA.',
                ),
                WidgetPresentation(
                  title: 'BottomAppBar',
                  presentationWindowAlignment: Alignment.bottomCenter,
                  presentationDeletePadding: true,
                  defaultOptionsBuilder: (currentOptions, submitNewOptions) => Column(
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          FilterChip(
                            label: Text('Color'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['color'] = v),
                            selected: currentOptions?['color'] ?? false,
                          ),
                          FilterChip(
                            label: Text('Floating action button'),
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['fab'] = v),
                            selected: currentOptions?['fab'] ?? false,
                          ),
                          DropdownMenu(
                            label: Text('Notch shape'),
                            enabled: currentOptions?['fab'] ?? false,
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['notch'] = v),
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: null, label: 'None'),
                              DropdownMenuEntry(value: const CircularNotchedRectangle(), label: 'Circular'),
                              DropdownMenuEntry(
                                  value: AutomaticNotchedShape(
                                    ContinuousRectangleBorder(),
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(16),
                                      ),
                                    ),
                                  ),
                                  label: 'Rounded rectangle'),
                              // DropdownMenuEntry(
                              //   value: AutomaticNotchedShape(
                              //     ContinuousRectangleBorder(),
                              //     StadiumBorder(),

                              //   ),
                              //   label: 'Stadium',
                              // ),
                            ],
                            initialSelection: null,
                          ),
                        ],
                      )
                    ],
                  ),
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.phone_iphone),
                      widgetBuilder: (p0, options) => Scaffold(
                        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                        floatingActionButton: (options?['fab'] ?? false)
                            ? FloatingActionButton(
                                shape: (options?['notch'] is CircularNotchedRectangle) ? CircleBorder() : null,
                                onPressed: () {},
                                child: Icon(Icons.add),
                              )
                            : null,
                        bottomNavigationBar: BottomAppBar(
                          color: (options?['color'] ?? false) ? Theme.of(context).colorScheme.secondary : null,
                          shape: options?['notch'],
                          child: IconButtonTheme(
                              data: IconButtonThemeData(style: IconButton.styleFrom(foregroundColor: (options?['color'] ?? false) ? Theme.of(context).colorScheme.onSecondary : null)),
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    tooltip: 'Open navigation menu',
                                    icon: const Icon(Icons.menu),
                                    onPressed: () {},
                                  ),
                                  IconButton(tooltip: 'Search', icon: const Icon(Icons.search), onPressed: () {}),
                                  IconButton(tooltip: 'Favorite', icon: const Icon(Icons.favorite), onPressed: () {}),
                                ],
                              )),
                        ),
                      ),
                    )
                  ],
                  link: 'https://api.flutter.dev/flutter/material/BottomAppBar-class.html?_gl=1*1mqwwjz*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTc0MTcwNDE1OC45MC4xLjE3NDE3MDQxNjAuMC4wLjA.',
                ),
                WidgetPresentation(
                  title: 'NavigationBar',
                  presentationWindowAlignment: Alignment.bottomCenter,
                  presentationDeletePadding: true,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.phone_iphone),
                      widgetBuilder: (p0, options) {
                        ValueNotifier<int> selected = ValueNotifier(0);
                        return AnimatedBuilder(
                          animation: selected,
                          builder: (context, _) => Scaffold(
                            bottomNavigationBar: NavigationBar(
                              destinations: [
                                NavigationDestination(icon: Icon(Icons.newspaper), label: 'News'),
                                NavigationDestination(icon: Icon(Symbols.globe), label: 'Global'),
                                NavigationDestination(icon: Icon(Icons.star), label: 'For you'),
                              ],
                              selectedIndex: selected.value,
                              onDestinationSelected: (value) => selected.value = value,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                  link: 'https://api.flutter.dev/flutter/material/NavigationBar-class.html?_gl=1*1e08mrq*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTc0MTcwNjQzNS45MS4xLjE3NDE3MDY2MzguMC4wLjA.',
                ),
                WidgetPresentation(
                  title: 'NavigationDrawer',
                  presentationWindowAlignment: Alignment.center,
                  presentationDeletePadding: true,
                  presentationCardWidget: Stack(
                    children: [
                      Positioned.fill(
                        child: Column(
                          children: [
                            Container(color: Theme.of(context).colorScheme.primary, height: 40),
                            Expanded(
                              child: Container(
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  child: Center(
                                    child: Text('...'),
                                  )),
                            ),
                            Container(color: Theme.of(context).colorScheme.secondary, height: 40),
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
                      ),
                      Positioned.fill(child: Container(color: Colors.grey.shade800.withAlpha(100))),
                      Positioned(
                        width: 100,
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerLow,
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                            boxShadow: [BoxShadow(offset: Offset(2, 2))],
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (var e in [
                                (Icons.inbox, true),
                                (Icons.send, false),
                                (Icons.folder, false),
                                (Icons.delete, false),
                                (Icons.more_horiz, false),
                              ])
                                Container(
                                  decoration: (e.$2) ? BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(16)) : null,
                                  padding: EdgeInsets.all(4),
                                  child: Row(children: [Icon(e.$1, size: 20)]),
                                )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.phone_iphone),
                      widgetBuilder: (p0, options) {
                        ValueNotifier<int> selected = ValueNotifier(0);
                        return AnimatedBuilder(
                          animation: selected,
                          builder: (context, _) => Scaffold(
                            drawer: NavigationDrawer(
                              selectedIndex: selected.value,
                              onDestinationSelected: (value) => selected.value = value,
                              tilePadding: EdgeInsets.only(top: 8, left: 8, right: 8),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FloatingActionButton.extended(
                                    onPressed: () {},
                                    icon: Icon(Symbols.edit),
                                    label: Text('New message'),
                                  ),
                                ),
                                Divider(),
                                NavigationDrawerDestination(icon: Icon(Symbols.inbox), label: Text('Inbox')),
                                NavigationDrawerDestination(icon: Icon(Symbols.send), label: Text('Sent')),
                                NavigationDrawerDestination(icon: Icon(Symbols.folder), label: Text('Archived')),
                                NavigationDrawerDestination(icon: Icon(Symbols.delete), label: Text('Deleted')),
                                NavigationDrawerDestination(icon: Icon(Icons.more_horiz), label: Text('More')),
                              ],
                            ),
                            body: Center(
                              child: Builder(
                                builder: (context) => FloatingActionButton.extended(
                                  onPressed: () => Scaffold.of(context).openDrawer(),
                                  label: Text('Open drawer'),
                                  icon: Icon(Symbols.left_panel_open),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                  link:
                      'https://api.flutter.dev/flutter/material/NavigationDrawer-class.html?_gl=1*t94b1t*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTc0MTcxMzM0OC45Mi4xLjE3NDE3MTM1MzAuMC4wLjA.',
                ),
                WidgetPresentation(
                  title: 'NavigationRail',
                  presentationWindowAlignment: Alignment.centerLeft,
                  presentationDeletePadding: true,
                  presentationCardWidget: Builder(builder: (_) {
                    ValueNotifier<int> selected = ValueNotifier(0);
                    return AnimatedBuilder(
                      animation: selected,
                      builder: (context, _) => Row(
                        children: [
                          NavigationRail(
                            destinations: [
                              NavigationRailDestination(icon: Icon(Symbols.music_note, fill: 1), label: Text('Musics')),
                              NavigationRailDestination(icon: Icon(Symbols.artist, fill: 1), label: Text('Artists')),
                              NavigationRailDestination(icon: Icon(Symbols.album, fill: 1), label: Text('Albums')),
                            ],
                            selectedIndex: selected.value,
                            onDestinationSelected: (value) => selected.value = value,
                          ),
                        ],
                      ),
                    );
                  }),
                  defaultOptionsBuilder: (currentOptions, submitNewOptions) => Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilterChip(
                        label: Text('Leading'),
                        onSelected: (v) => submitNewOptions((currentOptions ?? {})..['leading'] = v),
                        selected: (currentOptions?['leading'] ?? false),
                      ),
                      FilterChip(
                        label: Text('Trailing'),
                        onSelected: (v) => submitNewOptions((currentOptions ?? {})..['trailing'] = v),
                        selected: (currentOptions?['trailing'] ?? false),
                      ),
                      Row(
                        spacing: 8,
                        children: [
                          Text('Group alignment'),
                          SegmentedButton<double>(
                            segments: [
                              ButtonSegment(value: -1, label: Text('-1')),
                              ButtonSegment(value: 0, label: Text('0')),
                              ButtonSegment(value: 1, label: Text('+1')),
                            ],
                            showSelectedIcon: false,
                            selected: {currentOptions?['align'] ?? -1},
                            onSelectionChanged: (p0) => submitNewOptions((currentOptions ?? {})..['align'] = p0.first),
                          )
                        ],
                      ),
                      Row(
                        spacing: 8,
                        children: [
                          Text('Label type'),
                          SegmentedButton(
                            segments: [
                              ButtonSegment(value: NavigationRailLabelType.none, label: Text('None')),
                              ButtonSegment(value: NavigationRailLabelType.selected, label: Text('Selected')),
                              ButtonSegment(value: NavigationRailLabelType.all, label: Text('All')),
                            ],
                            showSelectedIcon: false,
                            selected: {currentOptions?['label'] ?? NavigationRailLabelType.none},
                            onSelectionChanged: (p0) => submitNewOptions((currentOptions ?? {})..['label'] = p0.first),
                          )
                        ],
                      )
                    ],
                  ),
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.phone_iphone),
                      widgetBuilder: (p0, options) {
                        ValueNotifier<int> selected = ValueNotifier(0);
                        ValueNotifier<bool> isExtended = ValueNotifier(false);
                        return AnimatedBuilder(
                          animation: (Listenable.merge([selected, isExtended])),
                          builder: (context, _) => Row(
                            children: [
                              NavigationRail(
                                extended: isExtended.value,
                                leading: (options?['leading'] ?? false)
                                    ? Card(
                                        clipBehavior: Clip.hardEdge,
                                        child: InkWell(
                                          onTap: () {},
                                          child: SizedBox(
                                            width: isExtended.value ? 230 : null,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Row(
                                                spacing: 8,
                                                children: [
                                                  Icon(Icons.explore),
                                                  if (isExtended.value) Text('Discover'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : null,
                                destinations: [
                                  NavigationRailDestination(icon: Icon(Symbols.music_note, fill: 1), label: Text('Musics')),
                                  NavigationRailDestination(icon: Icon(Symbols.artist, fill: 1), label: Text('Artists')),
                                  NavigationRailDestination(icon: Icon(Symbols.album, fill: 1), label: Text('Albums')),
                                  NavigationRailDestination(icon: Icon(Symbols.playlist_play, fill: 1), label: Text('Playlists')),
                                  NavigationRailDestination(icon: Icon(Symbols.genres, fill: 1), label: Text('Genres')),
                                ],
                                trailing: (options?['trailing'] ?? false) ? IconButton(onPressed: () {}, icon: Icon(Icons.settings)) : null,
                                selectedIndex: selected.value,
                                onDestinationSelected: (value) => selected.value = value,
                                groupAlignment: options?['align'],
                                labelType: isExtended.value ? NavigationRailLabelType.none : options?['label'],
                              ),
                              Expanded(
                                child: Container(
                                  color: Theme.of(context).colorScheme.onInverseSurface,
                                  child: Center(
                                    child: FloatingActionButton.extended(
                                      onPressed: () => isExtended.value = !isExtended.value,
                                      icon: Icon(isExtended.value ? Symbols.left_panel_close : Symbols.left_panel_open),
                                      label: Text(isExtended.value ? 'Collapse rail' : 'Extend rail'),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                  link: 'https://api.flutter.dev/flutter/material/NavigationBar-class.html?_gl=1*1e08mrq*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTc0MTcwNjQzNS45MS4xLjE3NDE3MDY2MzguMC4wLjA.',
                ),
              ],
            ),
          ),
        ),
      );
}
