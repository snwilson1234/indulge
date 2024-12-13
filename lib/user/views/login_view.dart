import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/main.dart';
import 'package:indulge/restaurant/views/restaurant_view.dart';
import 'package:indulge/restaurant/viewmodels/restaurant_view_model.dart';
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
  final usernameController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
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
                      controller: usernameController,
                      onChanged: (value) {
                        setState(() {
                          usernameController.text = value;
                        });
                      },
                      validator: (String? value) {
                        return vm.validateUsername(usernameController.text, passwordController.text);
                      },
                    ),
                    CupertinoTextFormFieldRow(
                      placeholder: "Password",
                      key: const Key("pass"),
                      controller: passwordController,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          passwordController.text = value;
                        });
                      },
                      validator: (String? value) {
                        return vm.validatePassword(usernameController.text, passwordController.text);
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
                      vm.loadUserAccountInfo(usernameController.text, passwordController.text);
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
