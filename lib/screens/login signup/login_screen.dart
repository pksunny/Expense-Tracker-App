// // ignore_for_file: prefer_const_constructors

// import 'package:awesome_dropdown/awesome_dropdown.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
// import 'package:money_tracker_app/screens/login%20signup/signup_screen.dart';
// import 'package:money_tracker_app/utils/txt_style.dart';
// import 'package:money_tracker_app/widgets/custom_button.dart';
// import 'package:money_tracker_app/widgets/custom_text_field.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {

//     final formKey = GlobalKey<FormState>();

//     // SCAFFOLD //
//     final scaffoldKey = GlobalKey<ScaffoldState>();

//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();

    // @override
    // void dispose(){
    //   super.dispose();
    //   emailController.dispose();
    //   passwordController.dispose();
    // }

//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: primary,

//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Container(
//             // width: width * 0.9,
//             // height: height * 0.55,
//             margin: EdgeInsets.symmetric(horizontal: width * 0.05),
//             decoration: BoxDecoration(
//               color: Color.fromRGBO(193, 214, 233, 1),
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(15),
//                 bottomLeft: Radius.circular(15),
//               ),
//               // ignore: prefer_const_literals_to_create_immutables
//               boxShadow: [
//                 BoxShadow(
//                   spreadRadius: -10,
//                   blurRadius: 17,
//                   offset: Offset(5, -10),
//                   color: Colors.white
//                 ),
//                 BoxShadow(
//                   spreadRadius: -2,
//                   blurRadius: 10,
//                   offset: Offset(7, 7),
//                   color: Color.fromRGBO(146, 182, 216, 1)
//                 ),
//               ]
//             ),
      
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: [
                  
//                   SizedBox(height: height * 0.1,),
                  
//                   // EMAIL FIELD
//                   CustomTextField(
//                     controller: emailController, 
//                     hintText: 'Email', 
//                     validator: (value){
//                       if(value!.isEmpty){
//                         return 'Email cannot be empty';
//                       }
//                       return null;
//                     }
//                   ),
                  
//                   SizedBox(height: height * 0.05,),
              
//                   //PASSWORD FIELD
//                   CustomTextField(
//                     controller: passwordController, 
//                     hintText: 'Password',
//                     validator: (value){
//                       if(value!.isEmpty){
//                         return 'Password cannot be empty';
//                       } else if(value.length <= 6){
//                         return 'Password cannot be less than 6';
//                       }
//                       return null;
//                     }
//                   ),
                  
//                   SizedBox(height: height * 0.05,),
                  
//                   CustomButton(
//                     onTap: (){
//                       if(formKey.currentState!.validate()){
//                         Get.to(() => DashBoard());
//                       }
//                     }, 
//                     text: 'Login'
//                   ),
              
//                   SizedBox(height: height * 0.02,),
              
//                   Text("Don't have an account?", style: TxtStyle.headLineStyle4,),
              
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
              
//                       Text("Click here to ", style: TxtStyle.headLineStyle4,),
              
//                       InkWell(
//                         splashColor: Colors.blue,
//                         onTap: (){
//                           Get.to(() => SignUpScreen());
//                         },
//                         child: Text("SignUp", style: TxtStyle.headLineStyle4.copyWith(color: Colors.blue),)
//                       )
//                     ],
//                   )
                  
//                 ],
//               ),
//             ),
//           ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/screens/login%20signup/password_reset_screen.dart';
import 'package:money_tracker_app/screens/login%20signup/signup_screen.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/custom_button.dart';
import 'package:money_tracker_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // SCAFFOLD //
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // FORM VALIDATION //
  final _formKey = GlobalKey<FormState>();

  // EMAIL & PASSWORD CONTROLLER //
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

    // CIRCULAR PROGRESS INDICATOR FUNCTION //
    @override
    Widget build(BuildContext context) {
      return _uiSetup(context);
    }

    @override
    void dispose(){
      super.dispose();
      emailController.dispose();
      passwordController.dispose();
    }

  // PASSWORD HIDE & SHOW //
  bool hidePass = true;


  @override
  Widget _uiSetup(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    AuthProvider authProvider = Provider.of(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
            // width: width * 0.9,
            // height: height * 0.55,
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            decoration: BoxDecoration(
              color: Color.fromRGBO(193, 214, 233, 1),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 17,
                  offset: Offset(5, -10),
                  color: Colors.white
                ),
                BoxShadow(
                  spreadRadius: -2,
                  blurRadius: 10,
                  offset: Offset(7, 7),
                  color: Color.fromRGBO(146, 182, 216, 1)
                ),
              ]
            ),
      
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  
                  SizedBox(height: height * 0.1,),
                  
                  // EMAIL FIELD
                  CustomTextField(
                    controller: emailController, 
                    hintText: 'Email', 
                    prefixIcon: Icons.email,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Email cannot be empty';
                      }
                      if(!RegExp(r'\S+@\S+\.\S+').hasMatch(value)){
                        return 'Please enter a valid email address';
                      }
                      return null;
                    }
                  ),
                  
                  SizedBox(height: height * 0.05,),
              
                  //PASSWORD FIELD
                  CustomTextField(
                    controller: passwordController, 
                    hintText: 'Password',
                    obsecureText: hidePass,
                    suffixIcon: hidePass ? Icons.visibility_off : Icons.visibility,
                    onTap: (){
                      setState(() {
                        hidePass = !hidePass;
                      });
                    },
                    prefixIcon: Icons.lock,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Password cannot be empty';
                      } else if(value.length <= 6){
                        return 'Password cannot be less than 6';
                      }
                      return null;
                    }
                  ),

                  SizedBox(height: height * 0.01,),

                  InkWell(
                    onTap: (){
                      Get.to(() => PasswordResetScreen());
                    },
                    child: Text('Forgot password?', style: TxtStyle.headLineStyle4.copyWith(color: Colors.blue),),
                  ),
                  
                  SizedBox(height: height * 0.05,),
                  
                  CustomButton(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        authProvider.SignInWithEmail(
                          emailController.text, 
                          passwordController.text,
                        );
                      }
                    }, 
                    text: 'Login'
                  ),
              
                  SizedBox(height: height * 0.02,),
              
                  Text("Don't have an account?", style: TxtStyle.headLineStyle4,),
              
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              
                      Text("Click here to ", style: TxtStyle.headLineStyle4,),
              
                      InkWell(
                        splashColor: Colors.blue,
                        onTap: (){
                          Get.to(() => SignUpScreen());
                        },
                        child: Text("SignUp", style: TxtStyle.headLineStyle4.copyWith(color: Colors.blue),)
                      )
                    ],
                  ),

                  SizedBox(height: height * 0.05,),
                  
                ],
              ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}