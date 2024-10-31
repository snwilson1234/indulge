import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:indulge/lists/views/user_lists_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.star_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.star_fill),
              label: 'Favorites',
            ),
          ],
        ), 
        tabBuilder: (BuildContext context, int index) {
          return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              leading: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "indulge",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              //just text for now
              trailing: Text("+ 20 mi -"),
            ),
            child: CupertinoTabView(
              builder: (BuildContext context) {
                return Center(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: UserListsView(),
                    ),
                  ),
                );
              },
            )
          );
        },
      ),
    );
  }
}

// class Login extends StatelessWidget {
//   const Login({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Expanded(
//               flex: 1,
//               child: Text("Login")
//             ),
//             const Expanded(
//               flex: 2,
//               child: LoginForm(),
//             ),
//             Expanded(
//               flex: 1,
//               child: Column(
//                 children: [
//                   const Text("Don't have an account with us? Sign up below."),
//                   OutlinedButton(
//                     onPressed: () {
//                       print("pressed Sign Up");
//                     }, 
//                     child: const Text("Sign Up")
//                   ),
//                 ],
//               )
//             ),
//           ],
//       ),
//       )
//     );
//   }
// }

// class LoginForm extends StatefulWidget {
//   const LoginForm({super.key});

//   @override
//   LoginFormState createState() {
//     return LoginFormState();
//   }
// }

// class LoginFormState extends State<LoginForm> {
//   // global key that uniquely identifies the Form widget
//   // and allows validation
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             // USERNAME FIELD
//             ConstrainedBox(
//               constraints: BoxConstraints.loose(
//                 const Size(300, 50)
//               ),
//               child: TextFormField(
//                 decoration: const InputDecoration(
//                 icon: Icon(Icons.person),
//                 hintText: 'Enter your username here.',
//                 labelText: 'Username *',
                
//               ),
//                 validator: (String? value) {
//                   return (value != null) ? 'Required field' : null;
//                 }
//               ),
//             ),
//             // PASSWORD FIELD
//             ConstrainedBox(
//               constraints: BoxConstraints.loose(
//                 const Size(300, 50)
//               ),
//               child: TextFormField(
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     icon: Icon(Icons.person),
//                     hintText: 'Enter your password here.',
//                     labelText: 'Password *',
//                   ),
//                   validator: (String? value) {
//                     return (value != null) ? 'Required field' : null;
//                   }
//               ),
//             ),
//             OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 textStyle: const TextStyle(fontSize: 20)
//               ),
//               onPressed: () {
//                 print("pressed login");
//               }, 
//               child: Text("Login")
//             ),
//           ],    
//         ),
//       ),
//     );
//   }
// }
