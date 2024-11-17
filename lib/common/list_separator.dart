
import 'package:flutter/cupertino.dart';

class ListSeparator extends StatelessWidget {
  const ListSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.9,  // Thickness of the separator
      color: CupertinoColors.separator,  // iOS separator color
      margin: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }
  
}