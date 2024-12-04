

import 'package:flutter/cupertino.dart';
import 'package:indulge/common/list_separator.dart';
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/views/login_view.dart';
import 'package:indulge/user/views/account_editing_view.dart';
import 'package:indulge/user/widgets/profile_list_item.dart';

class UserProfileView extends StatelessWidget{

  final UserViewModel vm;
  UserProfileView({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Account",
            style: TextStyle(
              color: CupertinoColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          const ListSeparator(),
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(75),
                  ),
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                    child: const Image(
                      image: AssetImage("assets/profile-avatar-placeholder.png"),
                    ),
                  ),
                ),
                Text(
                  vm.userData.username,
                  style: const TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${vm.userData.reviewed}",
                            style: const TextStyle(
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const Text(
                            "Spots Reviewed",
                            style: TextStyle(
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "${vm.userData.saved}",
                            style: const TextStyle(
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const Text(
                            "Spots Saved",
                            style: TextStyle(
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          const Text(
            "Edit Preferences",
            style: TextStyle(
              color: CupertinoColors.black,
              fontStyle: FontStyle.italic
            ),
          ),
          const ListSeparator(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => AccountEditingView(preferenceType: "food", vm: vm,)));
            },
            child: const ProfileItemWidget(text: "Food Experience"),
          ),
          const ListSeparator(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => AccountEditingView(preferenceType: "p&r", vm: vm,)));
            },
            child: const ProfileItemWidget(text: "Price and Distance"),
          ),
          const ListSeparator(),
          GestureDetector(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute(builder: (context) => AccountEditingView(preferenceType: "diet", vm: vm,)));
            },
            child: const ProfileItemWidget(text: "Dietary Restrictions"),
          ),
          const ListSeparator(),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CupertinoButton(
                  child: const Text(
                    "Change Password",
                  ), 
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) =>  AccountEditingView(preferenceType: "cp", vm: vm,),));
                  }
                ),
                CupertinoButton.filled(
                  child: const Text(
                    "Log Out",
            
                  ), 
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                    .pushAndRemoveUntil( 
                      CupertinoPageRoute(builder: (context) => const LoginView()), 
                      (route) => false);
                  }
                )
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}