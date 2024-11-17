// Flutter packages
import 'package:flutter/cupertino.dart';
import 'package:indulge/restaurant/widgets/restaurant_item_widget.dart';
import 'package:indulge/routing/routes.dart';

// Our views
import 'package:indulge/lists/views/user_lists_view.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white,
          leading: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "indulge",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          //just text for now
          trailing: Text("+ 20 mi -"),
        ),
        child: MainPage()
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: CupertinoColors.white,
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.white,
        activeColor: CupertinoColors.black,
        inactiveColor: CupertinoColors.inactiveGray,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bars),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.pencil),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
          ),
        ],
      ), 
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              routes: <String, WidgetBuilder>{
                homeRoute: (context) => RestaurantScreen(),
              },
              builder: (context) => RestaurantScreen(),
            );
          case 1:
            return CupertinoTabView(
              routes: <String, WidgetBuilder>{
                listRoute: (context) => const UserListsView(),
              },
              builder: (context) => const UserListsView(),
            );
          case 2:
            return CupertinoTabView(
              routes: <String, WidgetBuilder>{
                reviewRoute: (context) => const Text("reviews route"),
              },
              builder: (context) => const Text("reviews route"),
            );
          case 3:
            return CupertinoTabView(
              routes: <String, WidgetBuilder>{
                profileRoute: (context) => const Text("profile route"),
              },
              builder: (context) => const Text("profile route"),
            );
          default:
            return CupertinoTabView(
              routes: <String, WidgetBuilder>{
                '/unknown': (context) => const Text("unknown route"),
              },
              builder: (context) => const Text("unkown route"),
            );
        }
      },
    );
  }
}