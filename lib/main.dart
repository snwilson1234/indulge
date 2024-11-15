// Flutter packages
import 'package:flutter/cupertino.dart';
import 'package:indulge/database/db_service.dart';
import 'package:indulge/lists/models/dummy_restaurant.dart';
import 'package:indulge/lists/viewmodels/lists_view_model.dart';
import 'package:indulge/lists/views/list_detail_view.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/views/create_review_view.dart';
import 'package:indulge/routing/routes.dart';
import 'package:flutter/widgets.dart';

// Our views
import 'package:indulge/lists/views/user_lists_view.dart';
import 'package:indulge/reviews/viewmodels/reviews_view_model.dart';
import 'package:indulge/reviews/views/user_reviews_view.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:indulge/reviews/views/review_detail_view.dart';
import 'package:sqflite/sqflite.dart';


void main() async {

  // this is required for some reason
  WidgetsFlutterBinding.ensureInitialized();
  Database db = await DatabaseService.database;
  final dbPath = join(await getDatabasesPath(), 'indulge.db');
  print("DB PATH, changes with simulator restarts: $dbPath");

  var result = await db.rawQuery('PRAGMA foreign_keys;');
  print("Foreign keys enabled ?: ${result.first['foreign_keys']}");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ReviewsViewModel()),
        ChangeNotifierProvider(create: (context) => ListsViewModel()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
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
  const MainPage({super.key});

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
                homeRoute: (context) => const Text("home route"),
              },
              builder: (context) => const Text("home route"),
            );
          case 1:
            return CupertinoTabView(
              routes: <String, WidgetBuilder>{
                listRoute: (context) => const UserListsView(),
                listDetailRoute: (context) {
                  final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
                  final String name = arguments['name'];
                  final List<DummyRestaurant> list = arguments['listItems'];
                  return ListDetailView(name: name, listItems: list);
                }
              },
              builder: (context) => const UserListsView(),
            );
          case 2:
            return CupertinoTabView(
              routes: <String, WidgetBuilder>{
                reviewRoute: (context) => const UserReviewsView(),
                reviewDetailRoute: (context) {
                  final reviewViewModel = ModalRoute.of(context)!.settings.arguments as ReviewViewModel;
                  return ReviewDetailView(reviewViewModel: reviewViewModel);
                },
                newReviewRoute: (context) => const CreateReviewView(),
              },
              builder: (context) => const UserReviewsView(),
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
