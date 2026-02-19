import 'package:flutter/material.dart';

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color beige = Color(0xFFF5F5DC);
    const Color blue = Color(0xFF2196F3);
    const Color navy = Color(0xFF001F3F);
    const Color brown = Color(0xFFA52A2A);

    final List<Map<String, String>> announcements = [
      {
        'header': 'Featured',
        'title': 'Special title treatment',
        'text':
            'With supporting text below as a natural lead-in to additional content.',
        'button': 'Go somewhere',
        'footer': '2 days ago',
      },
      {
        'header': 'Important',
        'title': 'New Event Scheduled',
        'text': 'Join us for a webinar on future technologies.',
        'button': 'Register Now',
        'footer': '5 hours ago',
      },
      {
        'header': 'Notice',
        'title': 'Holiday Announcement',
        'text': 'Campus will remain closed on Friday due to maintenance.',
        'button': 'More Info',
        'footer': '1 day ago',
      },
      // Add more announcements as needed
    ];

    return Scaffold(
      backgroundColor: beige,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final item = announcements[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              height: MediaQuery.of(context).size.height / 3.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      item['header']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: navy,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['text']!,
                            style: const TextStyle(color: brown),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                            ),
                            onPressed: () {},
                            child: Text(item['button']!),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      item['footer']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
