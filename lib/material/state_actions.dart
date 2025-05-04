import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/main.dart';
import 'package:material_symbols_icons/symbols.dart';

class StateActionsPresentationPage extends StatelessWidget {
  const StateActionsPresentationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Row(
              spacing: 16,
              children: [
                Text('Boolean state widgets:', style: Theme.of(context).textTheme.titleLarge),
                Expanded(child: Divider()),
              ],
            ),
            Wrap(
              runSpacing: 32,
              spacing: 32,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                WidgetPresentation(
                  title: 'Checkbox',
                  presentationWindowAlignment: Alignment.center,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, _) {
                        ValueNotifier<bool> state1 = ValueNotifier(true);
                        ValueNotifier<bool?> state2 = ValueNotifier(false);
                        return AnimatedBuilder(
                            animation: Listenable.merge([state1, state2]),
                            builder: (context, _) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 8,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Checkbox(value: state1.value, onChanged: (value) => state1.value = value!), Text('Two-state box')],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Checkbox(value: state2.value, onChanged: (value) => state2.value = value, tristate: true), Text('Tri-state box')],
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ],
                  link: 'https://api.flutter.dev/flutter/material/Checkbox-class.html?_gl=1*1xfqjdj*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTczODc0ODAwMS40NS4xLjE3Mzg3NTAyNzYuMC4wLjA.',
                ),
                WidgetPresentation(
                  title: 'Switch',
                  presentationWindowAlignment: Alignment.topRight,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, _) {
                        ValueNotifier<bool> state1 = ValueNotifier(true);
                        return AnimatedBuilder(
                          animation: state1,
                          builder: (context, _) => Switch(value: state1.value, onChanged: (value) => state1.value = value),
                        );
                      },
                    ),
                  ],
                  link: 'https://api.flutter.dev/flutter/material/Switch-class.html?_gl=1*1o5zano*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTczODc0ODAwMS40NS4xLjE3Mzg3NTE5MDQuMC4wLjA.',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                spacing: 16,
                children: [
                  Text('Choice widgets:', style: Theme.of(context).textTheme.titleLarge),
                  Expanded(child: Divider()),
                ],
              ),
            ),
            Wrap(
              runSpacing: 32,
              spacing: 32,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                WidgetPresentation(
                  title: 'SegmentedButton',
                  presentationWindowAlignment: Alignment.topCenter,
                  presentationSplits: 7,
                  defaultOptionsBuilder: (currentOptions, submitNewOptions) => Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 8,
                        children: [
                          Text('Layout:', style: Theme.of(context).textTheme.titleMedium),
                          ActionChip(
                            avatar: Transform.rotate(angle: [Axis.horizontal, null].contains((currentOptions ?? {})['direction']) ? pi / 2 : 0, child: Icon(Symbols.expand_all)),
                            label: Text('Direction'),
                            onPressed: () =>
                                submitNewOptions((currentOptions ?? {})..['direction'] = [Axis.horizontal, null].contains((currentOptions ?? {})['direction']) ? Axis.vertical : Axis.horizontal),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text('Segments:', style: Theme.of(context).textTheme.titleMedium),
                          SizedBox(
                            width: 200,
                            child: Slider(
                              min: 2,
                              max: 5,
                              divisions: 3,
                              value: currentOptions?['segmentsCount'] ?? 2,
                              onChanged: (v) => submitNewOptions((currentOptions ?? {})..['segmentsCount'] = v),
                            ),
                          ),
                          SegmentedButton(
                            segments: [
                              ButtonSegment(value: 'label', label: Text('Labels'), icon: Icon(Icons.text_fields)),
                              ButtonSegment(value: 'icon', label: Text('Icons'), icon: Icon(Icons.text_fields)),
                            ],
                            multiSelectionEnabled: true,
                            selected: currentOptions?['segmentsUI'] ?? {'label'},
                            onSelectionChanged: (p0) => submitNewOptions((currentOptions ?? {})..['segmentsUI'] = p0),
                          ),
                          ChoiceChip(
                            avatar: Icon(Symbols.block),
                            label: Text('Disable some options'),
                            showCheckmark: false,
                            selected: currentOptions?['disabled'] == true,
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['disabled'] = v),
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text('Selection:', style: Theme.of(context).textTheme.titleMedium),
                          ChoiceChip(
                            avatar: Icon(Symbols.check_box_outline_blank),
                            label: Text('Empty selection allowed'),
                            showCheckmark: false,
                            selected: currentOptions?['emptySelectionAllowed'] ?? false,
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['emptySelectionAllowed'] = v),
                          ),
                          ChoiceChip(
                            avatar: Icon(Symbols.checklist),
                            label: Text('Multiple selection enabled'),
                            showCheckmark: false,
                            selected: currentOptions?['multiSelectionEnabled'] ?? false,
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['multiSelectionEnabled'] = v),
                          ),
                          ChoiceChip(
                            avatar: Icon(Symbols.check),
                            label: Text('Show selected icon'),
                            showCheckmark: false,
                            selected: currentOptions?['showSelectedIcon'] ?? true,
                            onSelected: (v) => submitNewOptions((currentOptions ?? {})..['showSelectedIcon'] = v),
                          ),
                        ],
                      ),
                    ],
                  ),
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0, opt) {
                        ValueNotifier<Set<String>> selected = ValueNotifier({'Songs'});
                        return AnimatedBuilder(
                          animation: selected,
                          builder: (context, child) => SegmentedButton(
                            segments: [
                              ButtonSegment(
                                value: 'Songs',
                                label: (opt?['segmentsUI']?.contains('label') ?? true) ? Text('Songs') : null,
                                icon: (opt?['segmentsUI']?.contains('icon') ?? false) ? Icon(Icons.music_note) : null,
                                enabled: opt?['disabled'] != true,
                              ),
                              ButtonSegment(
                                value: 'Albums',
                                label: (opt?['segmentsUI']?.contains('label') ?? true) ? Text('Albums') : null,
                                icon: (opt?['segmentsUI']?.contains('icon') ?? false) ? Icon(Icons.album) : null,
                              ),
                              if ((opt?['segmentsCount'] ?? 2) > 2)
                                ButtonSegment(
                                  value: 'Artists',
                                  label: (opt?['segmentsUI']?.contains('label') ?? true) ? Text('Artists') : null,
                                  icon: (opt?['segmentsUI']?.contains('icon') ?? false) ? Icon(Symbols.person, fill: 1) : null,
                                  enabled: opt?['disabled'] != true,
                                ),
                              if ((opt?['segmentsCount'] ?? 2) > 3)
                                ButtonSegment(
                                  value: 'Genre',
                                  label: (opt?['segmentsUI']?.contains('label') ?? true) ? Text('Genre') : null,
                                  icon: (opt?['segmentsUI']?.contains('icon') ?? false) ? Icon(Icons.category) : null,
                                  enabled: opt?['disabled'] != true,
                                ),
                              if ((opt?['segmentsCount'] ?? 2) > 4)
                                ButtonSegment(
                                  value: 'Playlists',
                                  label: (opt?['segmentsUI']?.contains('label') ?? true) ? Text('Playlists') : null,
                                  icon: (opt?['segmentsUI']?.contains('icon') ?? false) ? Icon(Symbols.playlist_play) : null,
                                ),
                            ],
                            selected: selected.value,
                            direction: opt?['direction'] ?? Axis.horizontal,
                            showSelectedIcon: opt?['showSelectedIcon'] ?? true,
                            emptySelectionAllowed: opt?['emptySelectionAllowed'] ?? false,
                            multiSelectionEnabled: opt?['multiSelectionEnabled'] ?? false,
                            onSelectionChanged: (p0) => selected.value = p0,
                          ),
                        );
                      },
                    ),
                  ],
                  link: 'https://api.flutter.dev/flutter/material/SegmentedButton-class.html?_gl=1*87nwyj*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTczODc2MzE5Ny40Ny4xLjE3Mzg3NjMzMTIuMC4wLjA.',
                ),
                WidgetPresentation(
                  title: 'Chip',
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (_) => Icon(Symbols.chips),
                      widgetBuilder: (p0, options) => Chip(label: Text('me@email.com')),
                    ),
                    WidgetVariantData(
                      'InputChip',
                      iconBuilder: (_) => Icon(Symbols.input_circle),
                      widgetBuilder: (p0, options) => InputChip(
                        label: Text('me@email.com'),
                        onPressed: () {},
                      ),
                    ),
                    WidgetVariantData(
                      'ChoiceChip',
                      iconBuilder: (_) => Icon(Symbols.toggle_on),
                      // optionsBuilder: ,
                      widgetBuilder: (p0, opt) {
                        ValueNotifier<bool> isSelected = ValueNotifier(false);
                        return AnimatedBuilder(
                            key: Key('demoChoiceChipAnim'),
                            animation: isSelected,
                            builder: (context, _) {
                              return ChoiceChip(
                                key: Key('demoChoiceChip'),
                                label: Text('me@email.com'),
                                onSelected: (value) => isSelected.value = value,
                                selected: isSelected.value,
                              );
                            });
                      },
                    ),
                    WidgetVariantData(
                      'FilterChip',
                      iconBuilder: (_) => Icon(Symbols.filter_alt),
                      widgetBuilder: (p0, opt) {
                        ValueNotifier<bool> isSelected = ValueNotifier(false);
                        return AnimatedBuilder(
                            key: Key('demoFilterChipAnim'),
                            animation: isSelected,
                            builder: (context, _) {
                              return FilterChip(
                                key: Key('demoFilterChip'),
                                // avatar: Icon(Icons.restaurant),
                                label: Text('Restaurants'),
                                onSelected: (value) => isSelected.value = value,
                                selected: isSelected.value,
                              );
                            });
                      },
                    ),
                    WidgetVariantData(
                      'ActionChip',
                      iconBuilder: (_) => Icon(Symbols.touch_app),
                      widgetBuilder: (p0, opt) {
                        ValueNotifier<bool> isSelected = ValueNotifier(false);
                        return AnimatedBuilder(
                            key: Key('demoActionChipAnim'),
                            animation: isSelected,
                            builder: (context, _) {
                              return ActionChip(
                                key: Key('demoActionChip'),
                                label: Text('Favourite'),
                                avatar: Icon(isSelected.value ? Icons.favorite : Icons.favorite_border),
                                onPressed: () => isSelected.value = !isSelected.value,
                              );
                            });
                      },
                    ),
                  ],
                  link: 'https://api.flutter.dev/flutter/material/Chip-class.html?_gl=1*xne2sz*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTc0MTA5MzgwNC42Ni4xLjE3NDEwOTUwNjkuMC4wLjA.',
                ),
                WidgetPresentation(
                  title: 'Radio',
                  presentationWindowAlignment: Alignment.centerLeft,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.radio_button_checked),
                      widgetBuilder: (p0, options) {
                        ValueNotifier<int> groupValue = ValueNotifier(0);
                        return AnimatedBuilder(
                            animation: groupValue,
                            builder: (_, __) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    leading: Radio(value: 0, groupValue: groupValue.value, onChanged: (value) => groupValue.value = value ?? 0),
                                    title: Text('Happi'),
                                  ),
                                  ListTile(
                                    leading: Radio(value: 1, groupValue: groupValue.value, onChanged: (value) => groupValue.value = value ?? 1),
                                    title: Text('Sod'),
                                  ),
                                ],
                              );
                            });
                      },
                    )
                  ],
                ),
                WidgetPresentation(
                  title: 'Slider',
                  presentationWindowAlignment: Alignment.center,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.radio_button_checked),
                      optionsBuilder: (currentOptions, submitNewOptions) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text('Layout:', style: Theme.of(context).textTheme.titleMedium),
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Text('SliderTheme.showValueIndicator:'),
                              SegmentedButton(
                                segments: [for (var e in ShowValueIndicator.values) ButtonSegment(value: e, label: Text(e.name))],
                                selected: {currentOptions?['theme::showValueIndicator'] ?? ShowValueIndicator.onlyForDiscrete},
                                onSelectionChanged: (p0) => submitNewOptions((currentOptions ?? {})..['theme::showValueIndicator'] = p0.firstOrNull),
                              ),
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Text('Divisions:'),
                              Checkbox(
                                value: currentOptions?['divisionsEnabled'] ?? false,
                                onChanged: (v) => submitNewOptions((currentOptions ?? {})..['divisionsEnabled'] = v),
                              ),
                              Slider(
                                value: currentOptions?['divisions'] ?? 2,
                                divisions: 4,
                                min: 1,
                                max: 5,
                                onChanged: currentOptions?['divisionsEnabled'] == true ? (v) => submitNewOptions((currentOptions ?? {})..['divisions'] = v) : null,
                              ),
                              if ([ShowValueIndicator.always, ShowValueIndicator.onlyForDiscrete, null].contains(currentOptions?['theme::showValueIndicator']))
                                FilterChip(
                                  label: Text('Show label'),
                                  selected: currentOptions?['label'] ?? false,
                                  onSelected: (currentOptions?['theme::showValueIndicator'] == ShowValueIndicator.always || currentOptions?['divisionsEnabled'] == true)
                                      ? (v) => submitNewOptions((currentOptions ?? {})..['label'] = v)
                                      : null,
                                ),
                            ],
                          ),
                          Row(
                            spacing: 8,
                            children: [
                              Text('Allowed interaction', style: Theme.of(context).textTheme.titleMedium),
                              SegmentedButton(
                                segments: [for (var e in SliderInteraction.values) ButtonSegment(value: e, label: Text(e.name))],
                                selected: {currentOptions?['allowedInteraction'] ?? SliderInteraction.tapAndSlide},
                                onSelectionChanged: (p0) => submitNewOptions((currentOptions ?? {})..['allowedInteraction'] = p0.firstOrNull),
                              ),
                            ],
                          )
                        ],
                      ),
                      widgetBuilder: (p0, options) {
                        ValueNotifier<double> slider = ValueNotifier(.5);
                        return AnimatedBuilder(
                          animation: slider,
                          builder: (_, __) => Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 300),
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  showValueIndicator: options?['theme::showValueIndicator'],
                                ),
                                child: Slider(
                                  allowedInteraction: options?['allowedInteraction'],
                                  value: slider.value,
                                  divisions: options?['divisionsEnabled'] == true ? (options?['divisions']?.floor()) ?? 2 : null,
                                  onChanged: (v) => slider.value = v,
                                  label: options?['label'] == true ? '${(slider.value * 100).floor()}%' : null,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                WidgetPresentation(
                  title: 'DropdownButton',
                  presentationWindowAlignment: Alignment.topCenter,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.radio_button_checked),
                      widgetBuilder: (p0, options) {
                        ValueNotifier<String> value = ValueNotifier('happi');
                        return AnimatedBuilder(
                            key: Key('DropdownButton builder'),
                            animation: value,
                            builder: (_, __) => DropdownButton(
                                  items: [
                                    DropdownMenuItem(value: 'happi', child: Text('Happi')),
                                    DropdownMenuItem(value: 'sod', child: Text('Sod'), onTap: () => value.value = 'sod'),
                                    DropdownMenuItem(value: 'anggy', child: Text('Anggy')),
                                  ],
                                  value: value.value,
                                  onChanged: (v) => value.value = v ?? 'anggy',
                                ));
                      },
                    )
                  ],
                  deprecationMessage: 'Prefer using DropdownMenu instead, the more recent version compliant to Material3.',
                  link: 'https://api.flutter.dev/flutter/material/DropdownButton-class.html?_gl=1*oke3ux*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTc0MTI1NTc5MS43MC4xLjE3NDEyNTY1NDAuMC4wLjA.',
                ),
                WidgetPresentation(
                  title: 'DropdownMenu',
                  presentationWindowAlignment: Alignment.topCenter,
                  // TODO Actual dropdownmenu options
                  defaultOptionsBuilder: (currentOptions, submitNewOptions) => IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.radio_button_checked),
                      widgetBuilder: (p0, options) => DropdownMenu(
                        initialSelection: 'happi',
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: 'happi', label: 'Happi'),
                          DropdownMenuEntry(value: 'sod', label: 'Sod'),
                          DropdownMenuEntry(value: 'anggy', label: 'Anggy'),
                        ],
                      ),
                    )
                  ],
                  link: 'https://api.flutter.dev/flutter/material/DropdownMenu-class.html',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                spacing: 16,
                children: [
                  Text('Time-picking widgets:', style: Theme.of(context).textTheme.titleLarge),
                  Expanded(child: Divider()),
                ],
              ),
            ),
            Wrap(
              runSpacing: 32,
              spacing: 32,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                WidgetPresentation(
                  title: 'DatePicker',
                  presentationWindowAlignment: null,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => IconButton(onPressed: () {}, icon: Icon(Icons.date_range)),
                      widgetBuilder: (p0, options) => Navigator(
                        clipBehavior: Clip.hardEdge,
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => Material(
                            color: Colors.transparent,
                            child: Center(
                              child: FloatingActionButton(
                                onPressed: () => showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(3000),
                                  useRootNavigator: false,
                                ),
                                child: Icon(Symbols.calendar_month),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  link: 'https://api.flutter.dev/flutter/material/showDatePicker.html?_gl=1*ingwgt*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTczODc0ODAwMS40NS4xLjE3Mzg3NTI1MTYuMC4wLjA.',
                ),
                WidgetPresentation(
                  title: 'TimePicker',
                  defaultOptionsBuilder: (currentOptions, submitNewOptions) {
                    return Column(
                      spacing: 8,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Text('Initial entry mode:', style: Theme.of(context).textTheme.titleMedium),
                            SegmentedButton(
                              segments: [
                                for (var e in TimePickerEntryMode.values)
                                  ButtonSegment(
                                    value: e,
                                    label: Text(e.name),
                                  )
                              ],
                              selected: {currentOptions?['initialEntryMode'] ?? TimePickerEntryMode.dial},
                              onSelectionChanged: (p0) => submitNewOptions((currentOptions ?? {})..['initialEntryMode'] = p0.firstOrNull),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 8,
                          children: [
                            Text('Orientation:', style: Theme.of(context).textTheme.titleMedium),
                            SegmentedButton(
                              segments: [
                                ButtonSegment(
                                  value: null,
                                  label: Text('Auto'),
                                ),
                                for (var e in Orientation.values)
                                  ButtonSegment(
                                    value: e,
                                    label: Text(e.name),
                                  )
                              ],
                              selected: {currentOptions?['orientation']},
                              onSelectionChanged: (p0) => submitNewOptions((currentOptions ?? {})..['orientation'] = p0.firstOrNull),
                            ),
                            // ActionChip(
                            //   label: Text([null, Orientation.landscape].contains(currentOptions?['orientation']) ? 'Landscape' : 'Portrait'),
                            //   onPressed: () => submitNewOptions((currentOptions ?? {})..['orientation'] = [null, Orientation.landscape].contains(currentOptions?['orientation']) ? Orientation.portrait : Orientation.landscape),
                            // ),
                          ],
                        )
                      ],
                    );
                  },
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => Icon(Icons.av_timer),
                      widgetBuilder: (p0, options) => Navigator(
                        key: Key('${options?['initialEntryMode']?.toString() ?? 'null'}${options?['orientation']}'),
                        clipBehavior: Clip.hardEdge,
                        onGenerateRoute: (settings) => MaterialPageRoute(
                          builder: (context) => Material(
                            color: Colors.transparent,
                            child: Center(
                              child: FloatingActionButton(
                                onPressed: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    useRootNavigator: false,
                                    initialEntryMode: options?['initialEntryMode'] ?? TimePickerEntryMode.dial,
                                    orientation: options?['orientation'],
                                  );
                                },
                                child: Icon(Symbols.access_time),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  link: 'https://api.flutter.dev/flutter/material/showTimePicker.html?_gl=1*1sb07l5*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTc0MTEwNTgwNC42Ny4xLjE3NDExMDU4MzUuMC4wLjA.',
                )
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      );
}
