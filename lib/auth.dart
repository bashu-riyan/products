import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:products/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
class Google extends StatelessWidget {
  const Google({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF47D15),
        body: Center(
          child: Container(
            child: Column(
mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInButton(
                  Buttons.Google,
                  elevation: 4.0,
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 8),
                  text: "Sign up with Google ",
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin();
                  },
                ),


              ],

            ),
          ),
        ),

      ),
    );
  }
}
