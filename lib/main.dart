// Flutter packages
import 'package:flutter/cupertino.dart';
import 'package:indulge/routing/router.dart' as local_router;
import 'package:indulge/routing/routes.dart';

// Our views
import 'package:indulge/lists/views/user_lists_view.dart';
import 'package:indulge/reviews/viewmodels/reviews_view_model.dart';
import 'package:indulge/reviews/views/user_reviews_view.dart';
import 'package:provider/provider.dart';
import 'package:indulge/reviews/views/review_detail_view.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ReviewsViewModel(),
      child: MainApp(),
    ),
  );
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
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoPageScaffold(
              backgroundColor: CupertinoColors.transparent,
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
    );
  }
}
