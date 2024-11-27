

import 'package:enough_platform_widgets/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/views/TODO.dart';
import 'package:indulge/user/views/price_radius_view.dart';
import 'package:indulge/user/widgets/checkbox_list.dart';
import 'package:indulge/user/widgets/dietary_restrictions_checkboxes.dart';
import 'package:indulge/user/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

class DietaryRestrictionView extends StatefulWidget {
  const DietaryRestrictionView({super.key});

  @override
  State<DietaryRestrictionView> createState() => _DietaryRestrictionView();
}

class _DietaryRestrictionView extends State<DietaryRestrictionView> {

  @override
  void initState() {
    super.initState();
    Provider.of<UserViewModel>(context, listen: false).initDietaryButtonList(UserConstants.dietaryRestrictions);
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

  final vm = Provider.of<UserViewModel>(context);

    return CupertinoPageScaffold(
      
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                const ProgressBar(
                  stage: 3
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Do you have any dietary restrictions?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                

                CheckboxList(checkboxes: vm.dietaryRestrictionCheckboxes),


                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton.outlined(
                        icon: const Icon(Icons.chevron_left_sharp, color: Colors.white),
                        iconSize: 50,
                        onPressed: () {
                          Navigator.pop(context);
                        }
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton.filled(
                        icon: const Icon(Icons.chevron_right_sharp, color: Colors.black,),
                        iconSize: 50,
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(UserConstants.actionColor),
                        ),
                        onPressed: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => const PriceAndRadiusPreferenceView(),));
                        }
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ), 
        ),
      
    );
  }
}