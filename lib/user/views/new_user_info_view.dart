
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/views/food_categories_view.dart';
import 'package:indulge/user/widgets/progress_bar.dart';

class NewUserInfoView extends StatefulWidget {
  const NewUserInfoView({super.key});


  @override
  State<NewUserInfoView> createState() => _NewUserInfoViewState();
}

class _NewUserInfoViewState extends State<NewUserInfoView> {
  final formKey = GlobalKey<FormState>();
  Map<String, String> userInfo = {
    "password": "",
    "username": "",
    "email": "",
    "confirm_pass": "",
  };


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

                Expanded(
                  child: SizedBox(
                    width: 325,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoFormSection.insetGrouped(
                            header: const Text("Account Info"),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white12
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).canvasColor,
                            ),
                            children: [
                              CupertinoTextFormFieldRow(
                                placeholder: "Email Address",
                                key: const Key("email"),
                                onChanged: (value) {
                                  setState(() {
                                    userInfo["email"] = value;
                                  });
                                },
                                validator: (value) {
                                  return UserViewModel.validateEmail(value);
                                },
                              ),
                              CupertinoTextFormFieldRow(
                                placeholder: "Username",
                                key: const Key("user"),
                                onChanged: (value) {
                                  setState(() {
                                    userInfo["username"] = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          CupertinoFormSection.insetGrouped(
                            header: const Text("Password Set-Up"),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white12
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).canvasColor,
                            ),
                            children: [
                              CupertinoTextFormFieldRow(
                                placeholder: "Password",
                                key: const Key("pass"),
                                obscureText: true,
                                onChanged: (value) {
                                  setState(() {
                                    userInfo["password"] = value;
                                  });
                                },
                              ),
                              CupertinoTextFormFieldRow(
                                placeholder: "Confirm Password",
                                key: const Key("confirm_pass"),
                                obscureText: true,
                                onChanged: (value) {
                                  setState(() {
                                    userInfo["confirm_pass"] = value;
                                  });
                                },
                                validator: (value) {
                                  return UserViewModel.validatePasswordConfirmation(userInfo["confirm_pass"], userInfo["password"]);
                                },
                              ),
                            ],
                          ),
                        ],
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
                      style: ButtonStyle(
                        backgroundColor: (userInfo["password"]!.isEmpty || userInfo["confirm_pass"]!.isEmpty) ? 
                          const WidgetStatePropertyAll(Colors.white70) : const WidgetStatePropertyAll(UserConstants.actionColor),
                      ),
                      onPressed: (userInfo["password"]!.isEmpty || userInfo["confirm_pass"]!.isEmpty) ? null :
                      () {
                        final form = formKey.currentState!;
                        if (form.validate()) {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FoodCategoryPreferencesView(),));
                        }
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