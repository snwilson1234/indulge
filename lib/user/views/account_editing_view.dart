

import 'package:button_multiselect/button_multiselect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/widgets/checkbox_list.dart';
import 'package:provider/provider.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;

class AccountEditingView extends StatefulWidget{
  
  final UserViewModel vm;
  final String preferenceType;

  AccountEditingView({super.key, required this.preferenceType, required this.vm});

  @override
  State<AccountEditingView> createState() => _AccountEditingViewState();
}

class _AccountEditingViewState extends State<AccountEditingView> {
  final formKey = GlobalKey<FormState>();
  
  
  double radius = 1;
  @override
  void initState() {
    super.initState();
    radius = Provider.of<UserViewModel>(context, listen: false).userData.radius;
    Provider.of<UserViewModel>(context, listen: false).initDietaryButtonList(UserConstants.dietaryRestrictions);
    Provider.of<UserViewModel>(context, listen: false).initFoodButtonList(UserConstants.foodExperiences);
  }
  
  

  Map<String, String> userInfo = {
    "old_pass": "",
    "new_pass": "",
    "confirm_pass": "",
  };

  Map<String, bool> foodExperienceCheckboxes = UserViewModel.buttonList(UserConstants.foodExperiences);

  Widget build(BuildContext context) {

    final vm = widget.vm;
    return getContentWidget(context, vm, widget.preferenceType);

    
  }

  Widget getContentWidget(BuildContext context, UserViewModel vm, String preferenceType) {

    switch (preferenceType) {
      case "cp":
        return changePasswordWidget(context, vm);
      case "food":
        return foodExperienceWidget(context, vm);
      case "diet":
        return dietaryRestrictionsWidget(context, vm);
      case "p&r":
        return priceRadiusWidget(context, vm);
      default:
        return Text("Invalid screen");
    }

  }

  Widget changePasswordWidget(BuildContext context, UserViewModel vm) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  CupertinoFormSection.insetGrouped(
                    backgroundColor: CupertinoColors.transparent,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black45
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black12,
                    ),
                    children: [
                      CupertinoTextFormFieldRow(
                        placeholder: "Old Password",
                        placeholderStyle: const TextStyle(
                          color: Colors.black38
                        ),
                        style: const TextStyle(
                          color: Colors.black
                        ),
                        key: const Key("old"),
                        onChanged: (value) {
                          userInfo["old_pass"] = value;
                        },
                        validator: (value) {
                          return vm.checkOldPassword(userInfo["old_pass"]);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CupertinoFormSection.insetGrouped(
                    backgroundColor: CupertinoColors.transparent,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black12,
                    ),
                    children: [
                      CupertinoTextFormFieldRow(
                        placeholder: "New Password",
                        placeholderStyle: const TextStyle(
                          color: Colors.black38
                        ),
                        style: const TextStyle(
                          color: Colors.black
                        ),
                        key: const Key("new_pass"),
                        onChanged: (value) {
                          userInfo["new_pass"] = value;
                        },
                      ),
                      CupertinoTextFormFieldRow(
                        placeholder: "Confirm Password",
                        placeholderStyle: const TextStyle(
                          color: Colors.black38
                        ),
                        style: const TextStyle(
                          color: Colors.black
                        ),
                        key: const Key("confirm_pass"),
                        onChanged: (value) {
                          userInfo["confirm_pass"] = value;
                        },
                        validator: (value) {
                          return UserViewModel.validatePasswordConfirmation(userInfo["confirm_pass"], userInfo["new_pass"]);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CupertinoButton.filled(
              child: Text("Change Password"), 
              onPressed: () {
                final form = formKey.currentState;
                if (form!.validate()) {
                  // TODO: update model and db
                  Navigator.pop(context);
                }
              }
            ),
            CupertinoButton(
              child: const Text("Cancel"), 
              onPressed: () {
                Navigator.pop(context);
              }
            )
          ],
        ),
    );
  }

  Widget foodExperienceWidget(BuildContext context, UserViewModel vm) {

    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 32,
          ),
          const Text(
            "What type of food experiences interest you?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.black
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          CheckboxList(checkboxes: vm.userData.foodPreferences, vm: vm),
          const SizedBox(
            height: 24,
          ),
          CupertinoButton.filled(
            child: Text("Save"), 
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );

  }

  Widget dietaryRestrictionsWidget(BuildContext context, UserViewModel vm) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 32,
          ),
          const Text(
            "Do you have any dietary restrictions?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: CupertinoColors.black
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          CheckboxList(checkboxes: vm.userData.dietaryRestrictions, vm: vm),
          const SizedBox(
            height: 24,
          ),
          CupertinoButton.filled(
            child: Text("Save"), 
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget priceRadiusWidget(BuildContext context, UserViewModel vm) {

    // TODO: Make work with vm
    List<dynamic> pricePoints = [];

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(
              height: 32,
            ),
            const Text(
              "Update your preferences",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.black,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
      
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "What price points are you most interested in?",
                      style: TextStyle(
                        color: CupertinoColors.black,
                      ),
                    ),
                  ),
                  ButtonMultiSelect(
                    buttonSize: ButtonSize.medium,
                    items: [
                      ButtonMultiSelectItem<int>(label: "\$", value: 1, ),
                      ButtonMultiSelectItem<int>(label: "\$\$", value: 2, ),
                      ButtonMultiSelectItem<int>(label: "\$\$\$", value: 3, ),
                    ], 
                    onSelectedChanged: (data) {  
                      // TODO: update vm
                      pricePoints = data;
                    }, 
                    primaryColor: UserConstants.actionColor, 
                    textColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "How far would you travel for suggested food?",
                      style: TextStyle(
                        color: CupertinoColors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: CupertinoSlider(
                      value: radius, 
                      onChanged: (newRadius) {
                        setState(() {
                          radius = newRadius;
                        });
                      },
                      min: 1,
                      max: 15,
                      activeColor: UserConstants.actionColor,
                      divisions: 14,
                    ),
                  ),
                  Text(
                    "${radius.round()} mile(s)",
                    style: const TextStyle(
                      color: CupertinoColors.black,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            CupertinoButton.filled(
              child: const Text("Save"), 
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 12,
            ),
        ],
      ),
    );
  }
}
