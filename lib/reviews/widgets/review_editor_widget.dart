
import 'package:flutter/cupertino.dart';

class ReviewEditorWidget extends StatefulWidget {
  final String initialComment;
  final TextEditingController controller;
  const ReviewEditorWidget({Key? key, required this.initialComment, required this.controller}) : super(key : key);

  @override
  State<ReviewEditorWidget> createState() => _ReviewEditorWidgetState();
}

class _ReviewEditorWidgetState extends State<ReviewEditorWidget> {

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.darkBackgroundGray,
      padding: const EdgeInsets.symmetric(
        vertical: 15.0, 
        horizontal: 20.0
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CupertinoTextField(
            style: TextStyle(
              color: CupertinoColors.black
            ),
            decoration: const BoxDecoration(
              color: CupertinoColors.white,
            ),
            placeholder: "Say something...",
            placeholderStyle: TextStyle(
              color: CupertinoColors.systemGrey
            ),
            controller: widget.controller,
            minLines: 10,
            maxLines: 10,
            maxLength: 255,
          )
        ],
      ),
    );
  }
  
}