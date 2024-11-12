import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/lists/views/user_lists_view.dart';
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/widgets/progress_bar.dart';
import 'package:indulge/user/widgets/toggle_button.dart';
import 'package:enough_platform_widgets/cupertino.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;

const actionColor = Color.fromRGBO(252, 162, 114, 1);


class DietaryRestrictionView extends StatefulWidget {
  const DietaryRestrictionView({super.key});

  @override
  State<DietaryRestrictionView> createState() => _DietaryRestrictionView();
}

class NewUserInfoView extends StatefulWidget {
  const NewUserInfoView({super.key});


  @override
  State<NewUserInfoView> createState() => _NewUserInfoViewState();
}

class FoodCategoryPreferencesView extends StatefulWidget {
  const FoodCategoryPreferencesView({super.key});


  @override
  State<FoodCategoryPreferencesView> createState() => _FoodCategoryPreferencesViewState();
}

class PriceAndRadiusPreferenceView extends StatefulWidget {
  const PriceAndRadiusPreferenceView({super.key});


  @override
  State<PriceAndRadiusPreferenceView> createState() => _PriceAndRadiusPreferenceViewState();
}


class _DietaryRestrictionView extends State<DietaryRestrictionView> {


  Map<String, bool> dietaryRestrictionCheckboxes = buttonList(UserConstants.dietaryRestrictions);
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
                            contentPadding: EdgeInsets.all(24),
                            activeColor: actionColor,
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
                          backgroundColor: WidgetStatePropertyAll(actionColor),
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


class _NewUserInfoViewState extends State<NewUserInfoView> {
  static const actionColor = Color.fromRGBO(252, 162, 114, 1);


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
                  stage: 1
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "Lets get you started!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                // TODO: Meat of screen (sign up info)
                const Expanded(
                  child: Placeholder(),
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
                        backgroundColor: WidgetStatePropertyAll(actionColor),
                      ),
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => const FoodCategoryPreferencesView(),));
                      }
                    ),
                  ]
                ),
              ),
            ],
          ),
        )
      ),
    );

  }
}


class _FoodCategoryPreferencesViewState extends State<FoodCategoryPreferencesView> {
  final formKey = GlobalKey<FormState>();
  Map<String, bool> foodExperienceCheckboxes = buttonList(UserConstants.foodExperiences);



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
                stage: 2
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                "What type of food experiences interest you?",
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
                  child: CupertinoScrollbar(
                    thumbVisibility: true,
                    child: ListView(
                      children: foodExperienceCheckboxes.keys.map((String key) {
                        return CupertinoCheckboxListTile(
                          title: Text(
                            key, 
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(24),
                          activeColor: actionColor,
                          value: foodExperienceCheckboxes[key],
                          onChanged: (value) {
                            setState( () {
                              foodExperienceCheckboxes[key] = value!;
                            });
                          },);
                        }
                      ).toList(),
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
                        backgroundColor: WidgetStatePropertyAll(actionColor),
                      ),
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => const DietaryRestrictionView(),));
                      }
                    ),
                  ]
                ),
              ),
            ],
          ),
        )
      ),
    );

  }
}


class _PriceAndRadiusPreferenceViewState extends State<PriceAndRadiusPreferenceView> {
  static const actionColor = Color.fromRGBO(252, 162, 114, 1);


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
                  stage: 4
                ),
                const SizedBox(
                  height: 32,
                ),
                const Text(
                  "One last thing...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                // TODO: Meat of screen (sign up info)
                const Expanded(
                  child: Placeholder(),
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
                        backgroundColor: WidgetStatePropertyAll(actionColor),
                      ),
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => const EndOfOnboardingView(),));
                      }
                    ),
                  ]
                ),
              ),
            ],
          ),
        )
      ),
    );

  }
}


class EndOfOnboardingView extends StatelessWidget {
  const EndOfOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Image(
                  image: AssetImage(
                    'assets/young-woman-eating-ramen.png'
                  )
                ),
                CupertinoButton(
                  color: actionColor,
                  child: const Text(
                    "Let's eat!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const UserListsView(),));
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}

Map<String, bool> buttonList(strings) {
  List<String> list = [];
  List<bool> selected = [];
  for (String word in strings) {
    list.add(word);
    selected.add(false);
  }
  return Map.fromIterables(list, selected);
}


