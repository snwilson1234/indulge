

import 'package:flutter/cupertino.dart';
import 'package:indulge/common/list_separator.dart';
import 'package:indulge/user/views/login_view.dart';
import 'package:indulge/user/widgets/profile_list_item.dart';

class UserProfileView extends StatelessWidget{

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
          ListSeparator(),
          Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(12),
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
                const Text(
                  "Username",
                  style: TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "8",
                            style: TextStyle(
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
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
                            "23",
                            style: TextStyle(
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
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
          const ProfileItemWidget(text: "Food Experience"),
          const ListSeparator(),
          const ProfileItemWidget(text: "Price and Distance"),
          const ListSeparator(),
          const ProfileItemWidget(text: "Dietary Restrictions"),
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
                    
                  }
                ),
                CupertinoButton.filled(
                  child: const Text(
                    "Log Out",
            
                  ), 
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                    .pushAndRemoveUntil( CupertinoPageRoute(builder: (context) => LoginView()), 
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