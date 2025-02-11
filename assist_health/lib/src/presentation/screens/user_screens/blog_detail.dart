import 'package:assist_health/src/others/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogPage extends StatefulWidget {
  final Map<String, dynamic> blogData;

  const BlogPage({Key? key, required this.blogData}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _sectionKeys = {};

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    final keyContext = _sectionKeys[index]?.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(keyContext,
          duration: const Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  // String processContent(String content) {
  //   List<String> parts = content.split('@');
  //   return parts.join('\n   ');
  // }
  String processContent(String content) {
    List<String> parts = content.split('@');

    for (int i = 0; i < parts.length; i++) {
      parts[i] = parts[i].replaceAll('#', '\n   ');
    }

    return parts.join('\n\n');
  }

  @override
  Widget build(BuildContext context) {
    final blogData = widget.blogData;

    final title = blogData['title'] ?? 'No title';
    final verifiedName = blogData['verifiedName'] ?? 'Unknown verifier';
    final verifiedDay = blogData['verifiedDay'] != null
        ? DateFormat.yMd().format(blogData['verifiedDay'].toDate())
        : 'Unknown date';
    final category = blogData['category'] ?? 'Uncategorized';
    final imageTitle = blogData['imageTitle'] ?? '';
    final appendix = (blogData['appendix'] as List?) ?? [];
    final body = (blogData['body'] as List?) ?? [];
    final content = blogData['content'] ?? 'No content';

    for (int i = 0; i < body.length; i++) {
      _sectionKeys[i] = GlobalKey();
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Bài viết'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Themes.gradientDeepClr, Themes.gradientLightClr],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          if (imageTitle.isNotEmpty)
            Center(
              child: Image.network(
                imageTitle,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Text('Kiểm duyệt: '),
                    Text('$verifiedName',
                        style: const TextStyle(
                            color: Themes.gradientDeepClr,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    const Text('Ngày kiểm duyệt: '),
                    Text(verifiedDay,
                        style: const TextStyle(
                            color: Themes.gradientDeepClr,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8.0),
                const SizedBox(height: 16.0),
                if (appendix.isNotEmpty) ...[
                  const SizedBox(height: 16.0),
                  const Text(
                    'Mục lục',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ...appendix.asMap().entries.map((entry) {
                    int index = entry.key;
                    String item = entry.value;
                    String romanNumeral = intToRoman(index + 1);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: InkWell(
                        onTap: () => _scrollToSection(index),
                        child: Text(
                          '$romanNumeral. $item',
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                              fontSize: 18.0, color: Colors.blue),
                        ),
                      ),
                    );
                  }).toList(),
                ],
                const SizedBox(height: 16.0),
                const Text(
                  'Nội dung',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                ...body.asMap().entries.map((entry) {
                  final index = entry.key;
                  final section = entry.value;
                  final header = section['header'] ?? 'No header';
                  final content = section['content'] ?? 'No content';
                  final imageUrl = section['imageUrl'] ?? '';

                  return Column(
                    key: _sectionKeys[index],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        header,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (imageUrl.isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            Center(
                              child: Image.network(imageUrl),
                            ),
                          ],
                        ),
                      const SizedBox(height: 4.0),
                      Text(
                        processContent(content),
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            _scrollController.position.minScrollExtent,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Themes.gradientDeepClr,
        foregroundColor: Colors.white,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}

String intToRoman(int num) {
  const List<Map<String, int>> romanNumerals = [
    {'M': 1000},
    {'CM': 900},
    {'D': 500},
    {'CD': 400},
    {'C': 100},
    {'XC': 90},
    {'L': 50},
    {'XL': 40},
    {'X': 10},
    {'IX': 9},
    {'V': 5},
    {'IV': 4},
    {'I': 1},
  ];

  String result = '';
  int remaining = num;

  for (var romanNumeral in romanNumerals) {
    String romanSymbol = romanNumeral.keys.first;
    int value = romanNumeral.values.first;

    while (remaining >= value) {
      result += romanSymbol;
      remaining -= value;
    }
  }

  return result;
}
