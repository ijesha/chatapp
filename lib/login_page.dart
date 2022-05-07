import 'package:chatapp/auth_controller.dart';
import 'package:chatapp/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  AuthController authController = AuthController();

  clearText(){
    emailController.clear();
    passwordController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login',style: TextStyle
          (fontSize: 28, fontWeight: FontWeight.bold,),),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, // appbar color.
        foregroundColor: Colors.white,
      ),

      body:  Center(child: Card(
          elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: emailController,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email or username',
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    contentPadding: EdgeInsets.only(left: 10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                    minimumSize: Size(350, 45), shape: StadiumBorder()),
                onPressed: () async{
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                    authController.loginUser(context, emailController.text, passwordController.text);
                  }else{
                    authController.catchError(context, 'Something went wrong');
                  }
                  preferences.setString('email', emailController.text);


                },
                child: Text(
                  'Log in',
                  textScaleFactor: 1.2,
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                style: TextButton.styleFrom(
                    minimumSize: Size(350, 45), shape: StadiumBorder()),
                onPressed: () {
                  authController.signInWithGoogle(context);

                },
                child: Text(
                  'Continue with Google',
                  textScaleFactor: 1.2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Create an account or '),
                  TextButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  }, child: Text('Sign Up',style: TextStyle(
                      fontWeight: FontWeight.bold,fontSize: 16
                  ),),),
                ],
              ),
              Container(width:350, height:350,color: Colors.white,child: Image.asset('asset/images/lgn.png'),),
            ],
          ),
        ),
      ),
    );
  }
}