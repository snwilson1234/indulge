
import 'package:flutter/cupertino.dart';

class ReviewEditorWidget extends StatefulWidget {
  final String initialComment;
  const ReviewEditorWidget({Key? key, required this.initialComment}) : super(key : key);

  @override
  State<ReviewEditorWidget> createState() => _ReviewEditorWidgetState();
}

class _ReviewEditorWidgetState extends State<ReviewEditorWidget> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialComment);
  }
  @override
  void dispose() {
    _textController.dispose();
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
            controller: _textController,
            minLines: 10,
            maxLines: 10,
            maxLength: 255,
          )
        ],
      ),
    );
  }
  
}