
import 'package:enough_platform_widgets/cupertino.dart';
import 'package:flutter/cupertino.dart';

class ProgressBar extends StatelessWidget{

  const ProgressBar({
    super.key,
    required this.stage,
  });

  static const actionColor = Color.fromRGBO(252, 162, 114, 1);
  
  final dynamic stage;


  @override
  Widget build(BuildContext context) {

    List<Widget> bar = [];
    for (int i = 0; i < 4; i++) {
      bar.add(
        Container(
            width: 85,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: CupertinoProgressBar(
              value: i < stage ? 1 : 0,
              valueColor: actionColor,
            ),
          ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: bar,
      ),
    );
  }


}