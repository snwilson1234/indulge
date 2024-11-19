

import 'package:enough_platform_widgets/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/views/TODO.dart';
import 'package:indulge/user/views/price_radius_view.dart';
import 'package:indulge/user/widgets/progress_bar.dart';

class DietaryRestrictionView extends StatefulWidget {
  const DietaryRestrictionView({super.key});

  @override
  State<DietaryRestrictionView> createState() => _DietaryRestrictionView();
}

class _DietaryRestrictionView extends State<DietaryRestrictionView> {


  Map<String, bool> dietaryRestrictionCheckboxes = UserViewModel.buttonList(UserConstants.dietaryRestrictions);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                
                Expanded(
                  child: Form(
                    key: formKey,
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
                              children: dietaryRestrictionCheckboxes.keys.map((String key) {
                                return CupertinoCheckboxListTile(
                                  title: Text(
                                    key, 
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(24),
                                  activeColor: UserConstants.actionColor,
                                  value: dietaryRestrictionCheckboxes[key],
                                  onChanged: (value) {
                                    setState( () {
                                      dietaryRestrictionCheckboxes[key] = value!;
                                    });
                                  },);
                                }
                              ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

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