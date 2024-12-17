
import 'package:flutter/cupertino.dart';
import 'package:indulge/common/theme.dart';

// Custom List Separator used throughout the application.
class ListSeparator extends StatelessWidget {
  const ListSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.9,  // Thickness of the separator
      color: indulgeSecondary,  // iOS separator color
      margin: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }
  
}