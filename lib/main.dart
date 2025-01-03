// Flutter packages
import 'package:flutter/cupertino.dart';
import 'package:indulge/common/theme.dart';
import 'package:indulge/lists/viewmodels/list_view_model.dart';
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/views/login_view.dart';
import 'package:indulge/user/views/user_profile_view.dart';
import 'package:indulge/user/widgets/radius_changer.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart';

// Our views
import 'package:indulge/lists/views/user_lists_view.dart';
import 'package:indulge/lists/viewmodels/lists_view_model.dart';
import 'package:indulge/lists/views/list_detail_view.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/views/create_review_view.dart';
import 'package:indulge/routing/routes.dart';
import 'package:indulge/reviews/viewmodels/reviews_view_model.dart';
import 'package:indulge/reviews/views/user_reviews_view.dart';
import 'package:indulge/reviews/views/review_detail_view.dart';
import 'package:indulge/restaurant/views/restaurant_view.dart';
import 'package:indulge/restaurant/viewmodels/restaurant_view_model.dart';

void main() async {
  // Ensure Flutter widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize `sqflite_common_ffi` for desktop platforms
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Test database connection and foreign keys
  final dbPath = join(await getDatabasesPath(), 'indulge.db');
  print("DB PATH, changes with simulator restarts: $dbPath");

  // Start your app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ReviewViewModel()),
        ChangeNotifierProvider(create: (context) => ReviewsViewModel()),
        ChangeNotifierProvider(create: (context) => ListsViewModel()),
        ChangeNotifierProvider(create: (context) => ListViewModel()),
        ChangeNotifierProvider(create: (context) => RestaurantViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
      ],
      child: const MainApp(),
    ),
  );
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      routes: {
        "/login": (context) => const LoginView(),
      },
      theme: indulgeTheme,
      home: const LoginView(),
    );
  }
}

class MainPage extends StatefulWidget {
  final UserViewModel userVM;
  const MainPage({super.key, required this.userVM});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: indulgeSecondary,
        leading: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "indulge",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: indulgePrimary,
              ),
            ),
          ],
        ),
        trailing: RadiusChanger(vm: widget.userVM),
      ),
      child: CupertinoTabScaffold(
        backgroundColor: CupertinoColors.white,
        tabBar: CupertinoTabBar(
          backgroundColor: indulgeSecondary,
          activeColor: indulgePrimary,
          inactiveColor: indulgePrimaryInactive,
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
                  homeRoute: (context) => ChangeNotifierProvider(
                    create: (_) => RestaurantViewModel()..fetchRestaurants(),
                    child: RestaurantView(),
                  ),
                },
                builder: (context) => ChangeNotifierProvider(
                  create: (_) => RestaurantViewModel()..fetchRestaurants(),
                  child: RestaurantView(),
                ),
              );
            case 1:
              return CupertinoTabView(
                routes: <String, WidgetBuilder>{
                  listRoute: (context) => const UserListsView(),
                  listDetailRoute: (context) => const ListDetailView(),
                },
                builder: (context) => const UserListsView(),
              );
            case 2:
              return CupertinoTabView(
                routes: <String, WidgetBuilder>{
                  reviewRoute: (context) => const UserReviewsView(),
                  reviewDetailRoute: (context) => const ReviewDetailView(),
                  newReviewRoute: (context) => const CreateReviewView(),
                },
                builder: (context) => const UserReviewsView(),
              );
            case 3:
              return CupertinoTabView(
                routes: <String, WidgetBuilder>{
                  profileRoute: (context) => UserProfileView(vm: widget.userVM),
                },
                builder: (context) => UserProfileView(vm: widget.userVM),
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
      )
    );
  }
}
