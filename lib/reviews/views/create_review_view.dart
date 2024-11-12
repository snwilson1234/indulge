import 'package:flutter/cupertino.dart';
import 'package:indulge/common/star_widget.dart';
import 'package:indulge/lists/models/dummy_restaurant.dart';
import 'package:indulge/lists/viewmodels/list_view_model.dart';
import 'package:indulge/lists/viewmodels/lists_view_model.dart';
import 'package:indulge/reviews/viewmodels/review_view_model.dart';
import 'package:indulge/reviews/widgets/review_editor_widget.dart';

import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';


const List<String> _restaurantNames = <String>[
  'Test1',
  'Test2',
  'Test3',
  'Test4',
  'Test5',
  'Test6',
];


class CreateReviewView extends StatefulWidget {
  const CreateReviewView({super.key});

  @override
  State<CreateReviewView> createState() => _CreateReviewViewState();
}


class _CreateReviewViewState extends State<CreateReviewView> {
  int _selectedRestaurant = 0;

  // This shows a CupertinoModalPopup with a reasonable fixed height which hosts CupertinoPicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ListsViewModel>(context, listen: false).fetchListsJson("Been There");
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ListsViewModel>(context);
    // var beenThereList = null;
    if (vm.lists.isEmpty) {
      print("Empty list!");
      return Text("something went wrong.");
    }
    else {
      final beenThereList = vm.lists[0].listItems
        .where((item) => item.reviewed == false)
        .toList();
      return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("New Review"),
        backgroundColor: CupertinoColors.white,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
        color: CupertinoColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Selected:"),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showDialog(
                CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  // This sets the initial item.
                  scrollController: FixedExtentScrollController(
                    initialItem: 0,
                  ),
                  // This is called when selected item is changed.
                  onSelectedItemChanged: (int selectedItem) {
                    setState(() {
                      _selectedRestaurant = selectedItem;
                    });
                  },
                  children:
                      List<Widget>.generate(beenThereList.length, (int index) {
                    return Center(child: Text(beenThereList[index].name));
                  }),
                ),
              ),
              // This displays the selected restaurant name.
              child: Text(
                beenThereList[_selectedRestaurant].name,
                style: const TextStyle(
                  fontSize: 22.0,
                ),
              ),
            ),
            const Text(
              "Choose your rating:",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20.0),
            const IconTheme(
              data: IconThemeData(
                color: CupertinoColors.black,
                size: 40.0
              ), 
              child: StarWidget(
                initialRating: 0.0
              )
            ),
            const SizedBox(height: 30.0),
            const Text(
              "Describe your experience:",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 10.0),
            const ReviewEditorWidget(
              initialComment: ""
            ),
            const SizedBox(height: 50.0),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  CupertinoButton(
                    color: CupertinoColors.black,
                    onPressed: () {
                      print("pressed submit!");
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  CupertinoButton(
                    color: CupertinoColors.inactiveGray,
                    onPressed: () {
                      // go back to reviews page
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
    }
    // final restaurantName = reviewViewModel.restaurantName; 
    // final rating = reviewViewModel.rating; 
    // final comment = reviewViewModel.comment;    
    // return CupertinoPageScaffold(
    //   navigationBar: const CupertinoNavigationBar(
    //     middle: Text("New Review"),
    //     backgroundColor: CupertinoColors.white,
    //   ),
    //   child: Container(
    //     padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
    //     color: CupertinoColors.white,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Text("Selected:"),
    //         CupertinoButton(
    //           padding: EdgeInsets.zero,
    //           onPressed: () => _showDialog(
    //             CupertinoPicker(
    //               magnification: 1.22,
    //               squeeze: 1.2,
    //               useMagnifier: true,
    //               itemExtent: 32.0,
    //               // This sets the initial item.
    //               scrollController: FixedExtentScrollController(
    //                 initialItem: 0,
    //               ),
    //               // This is called when selected item is changed.
    //               onSelectedItemChanged: (int selectedItem) {
    //                 setState(() {
    //                   _selectedRestaurant = selectedItem;
    //                 });
    //               },
    //               children:
    //                   List<Widget>.generate(vm.lists[0].listItems.length, (int index) {
    //                 return Center(child: Text(vm.lists[0].listItems[index].name));
    //               }),
    //             ),
    //           ),
    //           // This displays the selected restaurant name.
    //           child: Text(
    //             vm.lists[0].listItems[_selectedRestaurant].name,
    //             style: const TextStyle(
    //               fontSize: 22.0,
    //             ),
    //           ),
    //         ),
    //         const Text(
    //           "Choose your rating:",
    //           style: TextStyle(
    //             fontSize: 30,
    //           ),
    //         ),
    //         const SizedBox(height: 20.0),
    //         const IconTheme(
    //           data: IconThemeData(
    //             color: CupertinoColors.black,
    //             size: 40.0
    //           ), 
    //           child: StarWidget(
    //             initialRating: 0.0
    //           )
    //         ),
    //         const SizedBox(height: 30.0),
    //         const Text(
    //           "Describe your experience:",
    //           style: TextStyle(
    //             fontSize: 30,
    //           ),
    //         ),
    //         const SizedBox(height: 10.0),
    //         const ReviewEditorWidget(
    //           initialComment: ""
    //         ),
    //         const SizedBox(height: 50.0),
    //         Container(
    //           alignment: Alignment.center,
    //           child: Column(
    //             children: <Widget>[
    //               CupertinoButton(
    //                 color: CupertinoColors.black,
    //                 onPressed: () {
    //                   print("pressed submit!");
    //                 },
    //                 child: const Text(
    //                   "Submit",
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(height: 10.0),
    //               CupertinoButton(
    //                 color: CupertinoColors.inactiveGray,
    //                 onPressed: () {
    //                   print("pressed cancel!");
    //                 },
    //                 child: const Text(
    //                   "Cancel",
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   )
    // );
  }

}