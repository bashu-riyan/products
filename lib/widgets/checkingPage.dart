import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:products/auth.dart';
import 'products_page.dart';


class Check extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:  StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasError){
              return Center(child: Text("something went Wrong"),);
            }else if(snapshot.hasData){
              return ProductsPage();
            }else{
              return Google();
            }
          },
        ),
      ),
    );
  }
}
