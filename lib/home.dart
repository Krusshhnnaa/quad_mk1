import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings.dart';
import 'announcements.dart';
import 'discussions.dart';
import 'assignments.dart';
import 'components/chatpage.dart';
import 'components/themes.dart'; // Contains ThemeProvider and GradientBackground

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _selectedTag = 'All';

  final List<String> _tags = ['All', 'Unread', 'Favourites', 'Groups'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.themeMode == ThemeMode.dark;

    final List<Widget> pages = [
      _buildChatsList(),
      const AnnouncementsPage(),
      const DiscussionsPage(),
      const AssignmentsPage(),
    ];

    return GradientBackground(
      isDark: isDark,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            children: [
              const Placeholder(fallbackHeight: 40, fallbackWidth: 40),
              const SizedBox(width: 8),
              const Text(
                'Quad',
                style: TextStyle(
                  color: Color(0xFF001F3F),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 148, 127, 127),
                ),
                onSelected: (String value) {
                  if (value == 'Settings') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );
                  } else if (value == 'Logout') {
                    _logout(context);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'ThemeToggle',
                    enabled: false,
                    child: Row(
                      children: [
                        Icon(
                          isDark
                              ? Icons.wb_sunny_outlined
                              : Icons.nightlight_round_outlined,
                          color: isDark ? Colors.yellow : Colors.blueGrey,
                        ),
                        const SizedBox(width: 10),
                        AnimatedThemeSwitch(
                          isDark: isDark,
                          onToggle: () => themeProvider.switchTheme(),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem(value: 'Logout', child: Text('Logout')),
                ],
              ),
            ],
          ),
          bottom: _selectedIndex == 0
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _tags.map((tag) {
                          final bool isSelected = _selectedTag == tag;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: ChoiceChip(
                              label: Text(tag),
                              selected: isSelected,
                              onSelected: (_) {
                                setState(() {
                                  _selectedTag = tag;
                                });
                              },
                              selectedColor: const Color(0xFF2196F3),
                              backgroundColor: const Color.fromARGB(
                                255,
                                220,
                                224,
                                245,
                              ),
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF001F3F),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
              : null,
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white70,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF2196F3),
          unselectedItemColor: const Color(0xFF001F3F),
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
            BottomNavigationBarItem(
              icon: Icon(Icons.campaign),
              label: 'Announcements',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.forum),
              label: 'Discussions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Assignments',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsList() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 144, 142, 142),
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            'Contact ${index + 1}',
            style: getChatTitleStyle(context),
          ),
          subtitle: Text(
            'Last message preview...',
            style: getChatSubtitleStyle(context),
          ),
          trailing: Text(
            '12:${index.toString().padLeft(2, '0')} PM',
            style: getChatTimeStyle(context),
          ),

          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatPage(contactName: 'Contact ${index + 1}'),
              ),
            );
          },
        );
      },
    );
  }
}
