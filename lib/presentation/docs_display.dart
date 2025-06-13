import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

class DocsDisplayer extends StatelessWidget {
  const DocsDisplayer(this.url, {super.key, this.pageName});

  final String url;
  final String? pageName;

  Future<String> _fetchApiPage(String url) async {
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode != 200) {
      throw Exception('Failed to load documentation ($url)');
    }
    return resp.body;
  }

  dynamic _extractDocComment(String htmlSource) {
    final document = parse(htmlSource);

    // Return its text (or an empty string if not found)
    return {
      'desc': '.desc.markdown',
      'constructors': '.constructor-summary-list',
      'properties': '.properties',
      'implementation': '.language-dart',
    }
        .map(
          (k, v) => MapEntry(k, document.querySelector(v)),
        )
        .map(
          (key, value) => MapEntry(key, value?.innerHtml.trim()),
        );
  }

  Future<dynamic> _fetchAndParseDoc(String apiDocUrl) async {
    final html = await _fetchApiPage(apiDocUrl);
    return _extractDocComment(html);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('${pageName != null ? "$pageName " : ""}Documentation'),
          actionsPadding: EdgeInsets.only(right: 16),
          actions: [
            IconButton.filledTonal(
              tooltip: 'Open the documentation',
              onPressed: () => launchUrl(Uri.parse(url)),
              icon: Icon(Symbols.book_2, fill: 1),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
          future: _fetchAndParseDoc(url),
          builder: (context, snapshot) {
            if (snapshot.hasError) return ErrorWidget(snapshot.error!);
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            var foundSections = snapshot.data;
            int foundSectionsNb = foundSections.values.where((e) => e != null).length;

            print(foundSections['implementation']);

            return DefaultTabController(
              length: foundSectionsNb,
              child: Column(
                children: [
                  if (foundSectionsNb > 1)
                    TabBar(
                      tabs: [
                        Tab(icon: Icon(Symbols.description), text: 'Description'),
                        if (foundSections['constructors'] != null) Tab(icon: Icon(Symbols.construction), text: 'Constructors'),
                        if (foundSections['properties'] != null) Tab(icon: Icon(Symbols.data_array), text: 'Properties'),
                        if (foundSections['implementation'] != null) Tab(icon: Icon(Symbols.code), text: 'Implementation'),
                      ],
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: TabBarView(children: [
                        _HtmlDisplay(snapshot.data!['desc'].toString()),
                        if (foundSections['constructors'] != null) _HtmlDisplay(snapshot.data!['constructors'].toString()),
                        if (foundSections['properties'] != null) _HtmlDisplay(snapshot.data!['properties'].toString()),
                        if (foundSections['implementation'] != null) _HtmlDisplay(snapshot.data!['implementation'].toString()),
                      ]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
}

class _HtmlDisplay extends StatelessWidget {
  const _HtmlDisplay(this.display);

  final String display;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Html(
          data: display,
          // you can customize link tap behavior, styling, etc.
          onLinkTap: (href, _, __) {
            if (href == null) return;
            if (!href.startsWith('https://api.flutter.dev/flutter/')) href = 'https://api.flutter.dev/flutter/$href';
            launchUrl(Uri.parse(href));
          },
          style: Style.fromCss(
            r'''
              dt .name {
                font-weight: 500;
              }
              section.summary .name {
                  font-size: 1.5em;
                  margin-right: 0.2em;
              }
            ''',
            // _cssFromWebsite, // not working, everything shows white.
            (css, errors) => 'CSS ERROR i guess',
          ),
        ),
      );
}
