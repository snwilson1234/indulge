
import 'package:flutter/cupertino.dart';
import 'package:indulge/lists/viewmodels/list_view_model.dart';

class ListItemWidget extends StatelessWidget {
  final ListViewModel list;
  final int size;
  
  const ListItemWidget({
    super.key, required this.list, required this.size
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Text(
            list.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.white,
            ),),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Text(
                '$size ',
                style: const TextStyle(
                  color: CupertinoColors.white,
                ),
              ),
              Text(
                size == 1 ? 'entry' : 'entries',
                style: const TextStyle(
                  color: CupertinoColors.white,
                ),
              )
            ]
          )
        )
      ],
    );
  }

}