
import 'package:enough_platform_widgets/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;

class CheckboxList extends StatefulWidget {

  final Map<String, bool> checkboxes;
  final UserViewModel vm;

  CheckboxList({required this.checkboxes, required this.vm});

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {

  @override
  Widget build(BuildContext context) {

    return Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white12
            ),
            color: Theme.of(context).canvasColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CupertinoScrollbar(
                thumbVisibility: true,
                child: ListView(
                  children: widget.checkboxes.keys.map((String key) {
                    return CupertinoCheckboxListTile(
                      title: Text(
                        key, 
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(24),
                      activeColor: UserConstants.actionColor,
                      value: widget.checkboxes[key],
                      onChanged: (value) {
                        setState(() {
                        widget.vm.setCheckbox(widget.checkboxes, key, value);
                        });
                      },);
                    }
                  ).toList(),
                ),
              ),
            ),
          ),
        ),
    );
  }
}