import 'package:flutter/cupertino.dart';

class StarWidget extends StatelessWidget {
  final int value;
  const StarWidget({super.key, this.value = 0})
      : assert(value != null);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? CupertinoIcons.star_fill : CupertinoIcons.star,
        );
      }),
    );
  }
}