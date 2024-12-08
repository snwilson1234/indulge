
import 'package:button_multiselect/button_multiselect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indulge/lists/views/user_lists_view.dart';
import 'package:indulge/user/consts/constant_data.dart' as UserConstants;
import 'package:indulge/user/view_models/user_view_model.dart';
import 'package:indulge/user/views/onboarding_end_view.dart';
import 'package:indulge/user/widgets/price_options.dart';
import 'package:indulge/user/widgets/progress_bar.dart';
import 'package:indulge/user/widgets/toggle_button.dart';
import 'package:provider/provider.dart';

class PriceAndRadiusPreferenceView extends StatefulWidget {
  final UserViewModel vm;
  const PriceAndRadiusPreferenceView({super.key, required this.vm});


  @override
  State<PriceAndRadiusPreferenceView> createState() => _PriceAndRadiusPreferenceViewState();
}

class _PriceAndRadiusPreferenceViewState extends State<PriceAndRadiusPreferenceView> {


  @override
  initState() {
    super.initState();
    // widget.vm.initPricePoints(UserConstants.pricePoints);
  }
  

  @override
  Widget build(BuildContext context) {

    final vm = widget.vm;
    
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
                    SizedBox(height: 100,),
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
                        backgroundColor: context.watch<UserViewModel>().pricePointsChosen ? 
                        const WidgetStatePropertyAll(UserConstants.actionColor) : const WidgetStatePropertyAll(Colors.white70),
                      ),
                      onPressed: !context.watch<UserViewModel>().pricePointsChosen ? null : 
                      () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => EndOfOnboardingView(vm: vm),));
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
