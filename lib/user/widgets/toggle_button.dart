

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/user/view_models/user_view_model.dart';

class ToggleButton extends StatefulWidget{
  final String value;
  final UserViewModel vm;

  const ToggleButton({super.key, required this.value, required this.vm});


  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {

  @override
  Widget build(BuildContext context) {
    if (widget.vm.userData.pricePoints[widget.value]!) {
      return Container(
        width: 90,
        height: 50,
        child: CupertinoButton(
            color: const Color.fromRGBO(241, 149, 120, 1),
            padding: EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(12),
            child: Text(
              widget.value,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              setState(() {
                widget.vm.updateModelPrices(widget.value);
              });
            },
        ),
      );
    }
    else {
      return Container(
        width: 90,
        height: 50,
        child: CupertinoButton(
            color: const Color.fromARGB(255, 41, 41, 41),
            padding: EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(12),
            child: Text(
              widget.value,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              setState(() {
                widget.vm.updateModelPrices(widget.value);
              });
            },
        ),
      );
    }
  }
  
}


