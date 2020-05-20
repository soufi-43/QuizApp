import 'package:flutter/material.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/views/signin.dart';
import 'package:quizapp/widgets/widgets.dart';

import 'home.dart';



class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  AuthService authService = new AuthService();
  bool _isLoading =false ;


  signUp() async{

    if(_formKey.currentState.validate()){
      setState(() {
        _isLoading =true;
      });

    }

    await authService.signUpWithEmailAndPassword(email, password).then((value){


      if(value!=null){
        setState(() {
          _isLoading =false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

      }
    });

  }

  String email, password,name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        title: appBar(context),
        centerTitle: true,
      ),
      body:  _isLoading ?Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val) {
                  return val.isEmpty ? "enter a correct name" : null;
                },
                decoration: InputDecoration(
                  hintText: "Name",
                ),
                onChanged: (val) {
                  name = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                validator: (val) {
                  return val.isEmpty ? "enter a correct email" : null;
                },
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                onChanged: (val) {
                  email = val;
                },
              ),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                obscureText: true,
                validator: (val) {
                  return val.isEmpty ? "enter a password" : null;
                },
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                onChanged: (val) {
                  password = val;
                },
              ),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: (){
                  Home();

                },
                child:blueButton(context,'Sign Up'),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 15.5),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()),);
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 15.5, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
