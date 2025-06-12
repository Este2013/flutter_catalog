import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';
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

    // Look specifically for the 'desc markdown' section
    final descSection = document.querySelector('.desc.markdown');

    // Return its text (or an empty string if not found)
    return descSection?.innerHtml.trim(); //?.text.trim() ?? '';
  }

  Future<dynamic> _fetchAndParseDoc(String apiDocUrl) async {
    final html = await _fetchApiPage(apiDocUrl);
    return _extractDocComment(html);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('${pageName != null ? "$pageName " : ""}Documentation'),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder(
          future: _fetchAndParseDoc(url),
          builder: (context, snapshot) {
            if (snapshot.hasError) return ErrorWidget(snapshot.error!);
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SingleChildScrollView(
                child: Html(
                  data: snapshot.data!.toString(),
                  // you can customize link tap behavior, styling, etc.
                  onLinkTap: (href, _, __) {
                    if (href == null) return;
                    if (!href.startsWith('https://api.flutter.dev/flutter/')) href = 'https://api.flutter.dev/flutter/$href';
                    launchUrl(Uri.parse(href));
                  },
                  style: {
                    // override any tags if you like
                    "code": Style(
                      backgroundColor: Colors.grey.shade200,
                      padding: HtmlPaddings.all(4),
                    ),
                  },
                ),
              ),
            );
          },
        ),
      );
}
