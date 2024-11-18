

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget{
  final dynamic value;

  const ToggleButton({
    Key? key,
    required this.value,
    })
    : super(key: key);


  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool selected = false;



  @override
  Widget build(BuildContext context) {
    if (selected) {
      return CupertinoButton(
          color: const Color.fromRGBO(241, 149, 120, 1),
          minSize: 10,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          borderRadius: BorderRadius.circular(24),
          child: Text(
            widget.value,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            setState(() {
              selected = false;
            });
          },
      );
    }
    else {
      return CupertinoButton(
          color: Colors.white54,
          minSize: 10,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          borderRadius: BorderRadius.circular(24),
          child: Text(
            widget.value,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {
            setState(() {
              selected = true;
            });
          },
      );
    }
  }
  
}


