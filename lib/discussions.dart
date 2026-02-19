import 'package:flutter/material.dart';

class DiscussionsPage extends StatefulWidget {
  const DiscussionsPage({Key? key}) : super(key: key);

  @override
  _DiscussionsPageState createState() => _DiscussionsPageState();
}

class _DiscussionsPageState extends State<DiscussionsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  // Sample discussion threads
  final List<Map<String, dynamic>> _threads = List.generate(
    5,
    (index) => {
      'title': 'Thread Message #\${5 - index}',
      'replies': List.generate(
        3,
        (r) => 'Reply \${r + 1} to thread #\${5 - index}',
      ),
    },
  );
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = List<bool>.filled(_threads.length, false);
    _scrollController.addListener(() {
      if (_scrollController.offset > 200 && !_showScrollToTop) {
        setState(() => _showScrollToTop = true);
      } else if (_scrollController.offset <= 200 && _showScrollToTop) {
        setState(() => _showScrollToTop = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            reverse: true, // latest threads on top
            itemCount: _threads.length,
            itemBuilder: (context, index) {
              final threadIndex = index;
              final thread = _threads[threadIndex];
              final replies = thread['replies'] as List<String>;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(thread['title']),
                    onTap: () {
                      setState(() {
                        _expanded[threadIndex] = !_expanded[threadIndex];
                      });
                    },
                  ),
                  if (_expanded[threadIndex])
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: replies
                            .map(
                              (reply) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
                                child: Text(reply),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                ],
              );
            },
          ),
          // Scroll to top button
          if (_showScrollToTop)
            Positioned(
              bottom: 16,
              left: 16,
              child: FloatingActionButton(
                onPressed: _scrollToTop,
                mini: true,
                child: const Icon(Icons.arrow_upward),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Start new thread action
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
