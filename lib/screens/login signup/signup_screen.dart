// ignore_for_file: prefer_const_constructors

import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/provider/auth_provider.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/utils/txt_style.dart';
import 'package:money_tracker_app/widgets/custom_button.dart';
import 'package:money_tracker_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  // SCAFFOLD //
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // FORM VALIDATION //
  final _formKey = GlobalKey<FormState>();

  // EMAIL & PASSWORD CONTROLLER //
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
    void dispose(){
      super.dispose();
      emailController.dispose();
      passwordController.dispose();
      selectedItem = '';
    }

    // CIRCULAR PROGRESS INDICATOR FUNCTION //
    @override
    Widget build(BuildContext context) {
      return _uiSetup(context);
    }

    // DROP DOWN LIST

    final dropDownList = ['PKR', 'INR', 'EUR', 'AUD', 'BGP', 'USD'];
    String selectedItem = '';
    bool isBackPressedOrTouchedOutSide = true;
    bool isDropDownOpened = true;

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
                  
                  SizedBox(height: height * 0.05,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: AwesomeDropDown(
                      dropDownList: dropDownList,
                      elevation: 10,
                      dropDownBGColor: primary,
                      dropDownListTextStyle: TxtStyle.headLineStyle3,
                      dropDownTopBorderRadius: 10,
                      dropDownBorderRadius: 10,
                      dropDownBottomBorderRadius: 10,
                      selectedItemTextStyle: TxtStyle.headLineStyle3,
                      selectedItem: 'Select Currency',
                      isPanDown: true,
                      onDropDownItemClick: (item){
                        selectedItem = item;
                      },
                      dropStateChanged: (isOpened){
                        isDropDownOpened = isOpened;
                        if(!isOpened){
                          isBackPressedOrTouchedOutSide = false;
                        }
                      },
                      isBackPressedOrTouchedOutSide: isBackPressedOrTouchedOutSide,
                    ),
                  ),

                  SizedBox(height: height * 0.05,),
                  
                  CustomButton(
                    onTap: (){
                      if(_formKey.currentState!.validate()){
                        if(selectedItem.isNotEmpty){

                          print('if => $selectedItem');
                          print(emailController.text);
                          print(passwordController.text);

                          // _formKey.currentState!.save();

                          authProvider.signUpWithEmail(
                            emailController.text, 
                            passwordController.text, 
                            selectedItem,
                          );
                        } else if(selectedItem.isEmpty){
                          print('else => $selectedItem');
                          Get.snackbar('Currency', 'Currency cannot be empty',
                            margin: EdgeInsets.only(top: 20),
                          );
                        }
                      }
                    }, 
                    text: 'SignUp'
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