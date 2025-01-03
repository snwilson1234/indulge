

import 'package:button_multiselect/button_multiselect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/common/theme.dart';
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/widgets/checkbox_list.dart';
import 'package:indulge/user/widgets/price_options.dart';
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
  }
  
  

  Map<String, String> userInfo = {
    "old_pass": "",
    "new_pass": "",
    "confirm_pass": "",
  };


  Widget build(BuildContext context) {

    final vm = widget.vm;
    return Container(
      color: CupertinoColors.black,
      child: getContentWidget(context, vm, widget.preferenceType)
    );

    
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
            const Text(
              "Change Password",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CupertinoFormSection.insetGrouped(
                    backgroundColor: CupertinoColors.transparent,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: indulgeSecondary,
                    ),
                    children: [
                      CupertinoTextFormFieldRow(
                        placeholder: "Old Password",
                        placeholderStyle: const TextStyle(
                          color: CupertinoColors.white
                        ),
                        style: const TextStyle(
                          color: Colors.white
                        ),
                        key: const Key("old"),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            userInfo["old_pass"] = value.trim();
                          });
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
                        color: Colors.white
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: indulgeSecondary,
                    ),
                    children: [
                      CupertinoTextFormFieldRow(
                        placeholder: "New Password",
                        placeholderStyle: const TextStyle(
                          color: CupertinoColors.white
                        ),
                        style: const TextStyle(
                          color: CupertinoColors.white
                        ),
                        key: const Key("new_pass"),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            userInfo["new_pass"] = value.trim();
                          });
                        },
                      ),
                      CupertinoTextFormFieldRow(
                        placeholder: "Confirm Password",
                        placeholderStyle: const TextStyle(
                          color: Colors.white
                        ),
                        style: const TextStyle(
                          color: Colors.white
                        ),
                        key: const Key("confirm_pass"),
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            userInfo["confirm_pass"] = value.trim();
                          });
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
              focusColor: indulgePrimary,
              disabledColor: indulgePrimary,
              onPressed: (userInfo["old_pass"] == "" || userInfo["new_pass"] == "" || userInfo["confirm_pass"] == "") ? null : 
              () {
                final form = formKey.currentState;
                if (form!.validate()) {
                  vm.updatePassword(userInfo["new_pass"]!);
                  vm.updateDBAccountInfo();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Change Password",
                style: TextStyle(
                  color: indulgeSecondary
                ),
              ), 
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
              vm.updateDBPreferences();
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
              vm.updateDBDietaryRestrictions();
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: PriceOptions(vm: vm)
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "How far would you travel for suggested food?",
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: CupertinoSlider(
                      value: vm.userData.radius, 
                      onChanged: (newRadius) {
                        setState(() {
                          vm.updateModelRadius(newRadius);
                        });
                      },
                      min: 1,
                      max: 15,
                      activeColor: UserConstants.actionColor,
                      divisions: 14,
                    ),
                  ),
                  Text(
                    "${vm.userData.radius.round()} mile(s)",
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            CupertinoButton.filled(
              child: const Text("Save"), 
              onPressed: !context.watch<UserViewModel>().pricePointsChosen ? null : () {
                vm.info();
                vm.updateDBAccountInfo();
                vm.updateDBPrices();
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
