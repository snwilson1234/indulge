
import 'package:flutter/cupertino.dart';
import 'package:indulge/lists/views/user_lists_view.dart';
import 'package:indulge/reviews/views/review_detail_view.dart';
import 'package:indulge/reviews/views/user_reviews_view.dart';

import 'routes.dart';

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Add views that correspond to each route listed in routes.dart
      // Surround your view with Container with a color: CupertinoColors.white to get
      // rid of the gray "overlay" on each page.
      case homeRoute:
        return CupertinoPageRoute(builder: (_) => const Text("PLACE HOMEVIEW HERE"));
      case listRoute:
        // var data = settings.arguments as String;
        return CupertinoPageRoute(builder: (_) => const UserListsView());
      case reviewRoute:
        return CupertinoPageRoute(builder: (_) => const UserReviewsView());
      case profileRoute:
        return CupertinoPageRoute(builder: (_) => const Text("PLACE PROFILE VIEW HERE"));
      case reviewDetailRoute:
        var data = settings.arguments as String;
          if (data.isNotEmpty) {
            return CupertinoPageRoute(builder: (context) => 
            CupertinoPageScaffold(child: ReviewDetailView(restaurantName: data)));
          }
          return CupertinoPageRoute(builder: (_) => const ReviewDetailView(restaurantName: "ERROR"));
      default:
        return CupertinoPageRoute(
            builder: (_) => CupertinoPageScaffold(
              child: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}