


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileItemWidget extends StatelessWidget {
  final dynamic text;


  
  const ProfileItemWidget({
    required this.text,
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 10.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.black,
                ),
              ),
            ],
          ),
          const IconTheme(
            data: IconThemeData(
              color: CupertinoColors.black
            ), 
            child: Icon(
              CupertinoIcons.right_chevron
            )
          )
        ],
      )
    );
  }

}