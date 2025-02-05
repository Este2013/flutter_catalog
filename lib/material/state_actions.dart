import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_catalog/main.dart';

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
                      widgetBuilder: (p0) {
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
                      widgetBuilder: (p0) {
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
                  title: 'DatePicker',
                  presentationWindowAlignment: null,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => IconButton(onPressed: () {}, icon: Icon(Icons.date_range)),
                      widgetBuilder: (p0) => ClipRect(
                        child: SingleChildScrollView(
                          child: OverflowBox(
                            fit: OverflowBoxFit.deferToChild,
                            alignment: Alignment.center,
                            minWidth: 0,
                            minHeight: 0,
                            maxWidth: double.infinity,
                            maxHeight: double.infinity,
                            child: Transform.scale(
                              scale: 0.7,
                              child: SizedBox(
                                height: 400,
                                width: 400,
                                child: DatePickerDialog(
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(3000),
                                ),
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
                  title: 'SegmentedButton',
                  presentationWindowAlignment: Alignment.topCenter,
                  splits: 7,
                  variantsData: [
                    WidgetVariantData(
                      null,
                      iconBuilder: (p0) => IconButton(onPressed: () {}, icon: Icon(Icons.person)),
                      widgetBuilder: (p0) {
                        ValueNotifier<Set<String>> selected = ValueNotifier({'Songs'});
                        return AnimatedBuilder(
                          animation: selected,
                          builder: (context, child) => SegmentedButton(
                            segments: [
                              ButtonSegment(value: 'Songs', label: Text('Songs')),
                              ButtonSegment(value: 'Albums', label: Text('Albums')),
                            ],
                            selected: selected.value,
                            onSelectionChanged: (p0) => selected.value = p0,
                          ),
                        );
                      },
                    ),
                  ],
                  link: 'https://api.flutter.dev/flutter/material/SegmentedButton-class.html?_gl=1*87nwyj*_ga*MjcwMTE3ODUwLjE3MjY1ODY0NjI.*_ga_04YGWK0175*MTczODc2MzE5Ny40Ny4xLjE3Mzg3NjMzMTIuMC4wLjA.',
                ),
              ],
            ),
          ],
        ),
      );
}
