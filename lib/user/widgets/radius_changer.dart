

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/common/theme.dart';
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;

class RadiusChanger extends StatelessWidget {

  final UserViewModel vm;

  RadiusChanger({super.key, required this.vm});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          
          onPressed: () {
            vm.updateModelRadius(vm.userData.radius + 1);
            vm.updateDBAccountInfo();
          },
          icon: const Icon(CupertinoIcons.add),
          color: indulgePrimary,
        ),
        Container(
          width: 50,
          child: Center(
            child: Text(
              "${context.watch<UserViewModel>().userData.radius.round()} mi",
              style: const TextStyle(
                color: indulgePrimary,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            vm.updateModelRadius(vm.userData.radius - 1);
            vm.updateDBAccountInfo();
          },
          icon: const Icon(CupertinoIcons.minus),
          color: indulgePrimary,
        ),
      ],
    );
  }
}