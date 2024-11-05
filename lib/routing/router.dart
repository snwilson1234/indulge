
import 'package:flutter/cupertino.dart';
import 'package:indulge/lists/views/user_lists_view.dart';
import 'routes.dart';

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return CupertinoPageRoute(builder: (_) => const Text("PLACE HOMEVIEW HERE"));
      case listRoute:
        // var data = settings.arguments as String;
        return CupertinoPageRoute(builder: (_) => const UserListsView());
      case reviewRoute:
        return CupertinoPageRoute(builder: (_) => const Text("PLACE REVIEW VIEW HERE"));
      case profileRoute:
        return CupertinoPageRoute(builder: (_) => const Text("PLACE PROFILE VIEW HERE"));
      // case reviewDetailRoute:
      //   var data = settings.arguments as String;
      //     if (data.isNotEmpty) {
      //       return CupertinoPageRoute(builder: (context) => 
      //       CupertinoPageScaffold(child: ReviewDetailView(restaurantName: data)));
      //     }
      //     return CupertinoPageRoute(builder: (_) => const ReviewDetailView(restaurantName: "ERROR"));
      default:
        return CupertinoPageRoute(
            builder: (_) => CupertinoPageScaffold(
              child: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}