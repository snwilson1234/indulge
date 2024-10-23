
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            "List Name",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("num"),
              Text("entries")
            ]
          ),
        )
      ],
    );
  }

}