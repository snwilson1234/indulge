// Flutter packages
import 'package:flutter/cupertino.dart';
import 'package:indulge/routing/router.dart' as local_router;
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
      initialRoute: homeRoute,
      onGenerateRoute: local_router.Router.generateRoute,
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
        return const <Widget>[
          CupertinoPageScaffold(child:Text("placeholder for home")),
          CupertinoPageScaffold(child:UserListsView()),
          CupertinoPageScaffold(child:Text("placeholder for home")),
          CupertinoPageScaffold(child:Text("placeholder for profile"))
        ][index];
      },
    );
  }
}