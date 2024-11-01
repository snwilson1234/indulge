import 'package:flutter/cupertino.dart';
import 'package:indulge/routing/router.dart' as local_router;
import 'package:indulge/routing/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
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
          return CupertinoTabView(
            builder: (BuildContext context) {
              return CupertinoPageScaffold(
                backgroundColor: CupertinoColors.transparent,
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
                child: Navigator(
                  onGenerateRoute: (RouteSettings settings) {
                    switch (index) {
                      case 0:
                        return local_router.Router.generateRoute(const RouteSettings(name: homeRoute));
                      case 1:
                        return local_router.Router.generateRoute(const RouteSettings(name: listRoute));
                      case 2:
                        return local_router.Router.generateRoute(const RouteSettings(name: reviewRoute));
                      case 3:
                        return local_router.Router.generateRoute(const RouteSettings(name: profileRoute));
                      default:
                        // default to home if invalid tab index
                        return local_router.Router.generateRoute(const RouteSettings(name: homeRoute));
                    }
                  },
                )
              );
            },
          );
        },
      )
    );
  }
}
