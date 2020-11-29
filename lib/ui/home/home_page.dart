import 'package:Twitvid/constants/app_theme.dart';
import 'package:Twitvid/ui/download/pages/get_link_page.dart';
import 'package:Twitvid/ui/history/pages/history_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  int currentIndex = 0;
  final List<Widget> _pages = <Widget>[GetLinkPage(), HistoryPage()];

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fcm.requestNotificationPermissions();
    _fcm.configure(
      onMessage: (message) async {},
      onLaunch: (message) async {},
      onResume: (message) async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 14,
                      child: Image.asset(
                        "assets/logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      "witvid",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : kPrimaryBlue,
                      ),
                    )
                  ],
                ),
                centerTitle: true,
                elevation: 0,
                floating: true,
                snap: true,
                actions: [
                  IconButton(
                    icon: Icon(
                      Feather.settings,
                      color: kPrimaryBlue,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/settings_page");
                    },
                  )
                ],
              ),
            ];
          },
          body: IndexedStack(
            index: currentIndex,
            children: _pages,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryBlue,
        items: _items,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Ionicons.ios_home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history),
      label: 'History',
    ),
  ];
}
