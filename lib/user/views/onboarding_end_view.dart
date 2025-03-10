

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/main.dart';
import 'package:indulge/restaurant/views/restaurant_view.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;
import 'package:indulge/user/view_models/user_view_model.dart';

class EndOfOnboardingView extends StatelessWidget {
  final UserViewModel vm;
  const EndOfOnboardingView({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 72,
              ),
              const Text(
                "Woohoo, you're all set!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Image(
                
                image: AssetImage(
                  'assets/young-woman-eating-ramen.png',
                )
              ),
              const SizedBox(
                height: 64,
              ),
              CupertinoButton(
                color: UserConstants.actionColor,
                child: const Text(
                  "Let's eat!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ), 
                onPressed: () {
                  vm.updateDatabase(true);
                  vm.info();
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => MainPage(userVM: vm,),));
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}




