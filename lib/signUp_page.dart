import 'package:chatapp/auth_controller.dart';
import 'package:chatapp/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  AuthController authController = AuthController();

  clearText(){
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blueAccent, Colors.black])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Sign Up',style: TextStyle
            (fontSize: 26, fontWeight: FontWeight.bold,),),
          centerTitle: true,
          backgroundColor: Colors.black54, // appbar color.
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Card(
            color: Colors.white,
            elevation: 10,
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
                SizedBox(height: 10,),
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
                SizedBox(height: 10,),

                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                      minimumSize: Size(350, 45),
                      shape: StadiumBorder()
                  ),
                  onPressed: () async{
                    clearText(){
                      emailController.clear();
                      passwordController.clear();
                    }
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    preferences.setString('email', emailController.text);
                    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                      authController.register(context, emailController.text, passwordController.text);
                    }else{
                      authController.catchError(context, 'Something went wrong');
                    }

                  },
                  child: Text('Sign up',textScaleFactor: 1.2,),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Do you have an account?'),
                    TextButton(onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }, child: Text('Login',style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 16, color: Colors.blueAccent,
                    ),))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}