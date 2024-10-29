import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:indulge/lists/views/user_lists_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        // const Navigation bar for now to fix display
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: UserListsView(),
          ),
        ),
      ),
    );
  }
}
