import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/main.dart';
import 'package:indulge/restaurant/widgets/restaurant_item_widget.dart';
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/lists/views/user_lists_view.dart';
import 'package:indulge/user/views/new_user_info_view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  static const actionColor = Color.fromRGBO(252, 162, 114, 1);


  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<UserViewModel>(context);

    return CupertinoPageScaffold(
      child: Center(
        child: SizedBox (
          width: 325,
          child: Column (
            children: [
              const SizedBox(
                height: 200,
              ),
              const Text("Welcome to"),
              const Text(
                "indulge",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Form(
                key: formKey,
                child: CupertinoFormSection.insetGrouped(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white12
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).canvasColor,
                  ),
                  children: [
                    CupertinoTextFormFieldRow(
                      placeholder: "Username",
                      key: const Key("user"),
                      validator: (String? value) {
                        return UserViewModel.validateUsername(value);
                      },
                    ),
                    CupertinoTextFormFieldRow(
                      placeholder: "Password",
                      key: const Key("pass"),
                      obscureText: true,
                      validator: (String? value) {
                        return UserViewModel.validatePassword(value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: CupertinoButton(
                  color: actionColor,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ), 
                  onPressed: () {
                    final form = formKey.currentState!;
                    if (form.validate()) {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => MainPage(userVM: vm),));
                      // TODO: Let user into app
                    }
                  }
                ),
              ),
              
              CupertinoButton(
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: actionColor,
                  ),
                ), 
                onPressed: () {
                  vm.newUser();
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => NewUserInfoView(vm: vm),));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
