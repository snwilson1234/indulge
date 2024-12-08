


import 'package:flutter/cupertino.dart';
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/widgets/toggle_button.dart';

class PriceOptions extends StatefulWidget{

  final UserViewModel vm;

  PriceOptions({super.key, required this.vm});

  @override
  State<PriceOptions> createState() => _PriceOptionsState();
}

class _PriceOptionsState extends State<PriceOptions> {
  @override
  Widget build(BuildContext context) {
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButton(value: "\$", vm: widget.vm),
        SizedBox(width: 12,),
        ToggleButton(value: "\$\$", vm: widget.vm),
        SizedBox(width: 12,),
        ToggleButton(value: "\$\$\$", vm: widget.vm),
      ],
    );
  }
}