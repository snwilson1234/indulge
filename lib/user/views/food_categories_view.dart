
import 'package:enough_platform_widgets/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/views/dietary_restrictions_view.dart';
import 'package:indulge/user/widgets/progress_bar.dart';

class FoodCategoryPreferencesView extends StatefulWidget {
  const FoodCategoryPreferencesView({super.key});


  @override
  State<FoodCategoryPreferencesView> createState() => _FoodCategoryPreferencesViewState();
}

class _FoodCategoryPreferencesViewState extends State<FoodCategoryPreferencesView> {
  final formKey = GlobalKey<FormState>();
  Map<String, bool> foodExperienceCheckboxes = UserViewModel.buttonList(UserConstants.foodExperiences);



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
                                children: foodExperienceCheckboxes.keys.map((String key) {
                                  return CupertinoCheckboxListTile(
                                    title: Text(
                                      key, 
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.all(24),
                                    activeColor: UserConstants.actionColor,
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
