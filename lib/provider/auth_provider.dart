
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:money_tracker_app/screens/dashboard/dashborad.dart';
import 'package:money_tracker_app/screens/login%20signup/login_screen.dart';
import 'package:money_tracker_app/screens/profile/my_profile.dart';
import 'package:money_tracker_app/widgets/common_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthProvider with ChangeNotifier{

  // EMAIL SIGN UP
  Future<void> signUpWithEmail(email, password, currency) async {
    try {

      // AUTHENTICATE USER //
      CommonDialog.showLoading();
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('user Credential => $userCredential');

      CommonDialog.hideLoading();

      // ADDING USER DATA IN DATABASE //
      try {
        CommonDialog.showLoading();
        var response =
            await FirebaseFirestore.instance.collection('usersList').add({
          'user_Id': userCredential.user!.uid,
          'email': email,
          'password': password,
          'currency': currency,
        });

        print("Firebase response ${response.id}");
        CommonDialog.hideLoading();
       
      } catch (exception) {
        CommonDialog.hideLoading();
        print("Error Saving Data at firestore $exception");
      }

      notifyListeners();

      Get.back();
      
      CommonDialog.showErrorDialog(title: 'Congrats', description: 'You Signup Successfully!');

    } on FirebaseAuthException catch (e) {
      CommonDialog.hideLoading();
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        CommonDialog.showErrorDialog(description: 'The password provided is too weak!');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CommonDialog.showErrorDialog(description: 'The account already exists for that email!');
        print('The account already exists for that email.');
      }// Displaying the usual firebase error message
    } catch(e) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog(description: "Something went wrong");
      print(e);
    }
  }


  //USER ID
  var userId;
  var email;
  var currency;

  // EMAIL LOGIN //
  Future<void> SignInWithEmail(email, password) async {

    print('$email , $password');
    try {
      CommonDialog.showLoading();
      // AUTHETICATIN USER //
      UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: email,
          password: password,
        );

      print(userCredential.user!.uid);
      // SAVING LOGGED IN USERID IN VARIABLE //
      userId = userCredential.user!.uid;
      email = userCredential.user!.email;
      currency = userCredential.user!.toString();

      print('Login user id => $userId');
      print('Login user email => $email');
      print('Login user currency => $currency');
      
      CommonDialog.hideLoading();

      notifyListeners();

      // AFTER LOGIN GOTO HOMESCREEN
      Get.off(() => DashBoard());

    } on FirebaseAuthException catch (e) {
      CommonDialog.hideLoading();
      if (e.code == 'user-not-found') {
        CommonDialog.showErrorDialog(description: 'No user found for that email');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CommonDialog.showErrorDialog(description: 'Wrong password provided for that user');
        print('Wrong password provided for that user.');
      }
    }
  }

  // GET USER DATA

  Map userProfileData = {'userListId': '', 'email': '', 'currency': ''};

  Future<void> getUserProfileData() async {

    var userListId;

    try {
      var response = await FirebaseFirestore.instance
          .collection('usersList')
          .where('user_Id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      response.docs.forEach((result) {
        print(result.data());
        print(result.id);
        userListId = result.id;
      });
      if (response.docs.length > 0) {
        userProfileData['userListId'] = userListId;
        userProfileData['email'] = response.docs[0]['email'];
        userProfileData['currency'] = response.docs[0]['currency'];
      }
      print('User Currency ${userProfileData['currency']}');
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }


  // EDIT CURRENCY FROM DATABASE //
  Future editCurrency(userListId, email, currency) async {
    print("UserList Id  $userListId");
    try {
      CommonDialog.showLoading();
      await FirebaseFirestore.instance
          .collection("usersList")
          .doc(userListId)
          .update({"currency": currency}).then((_) {
        CommonDialog.hideLoading();
        
        Get.to(() => DashBoard());

        Get.snackbar(
          'Currency', 'Currency Updated', 
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.symmetric(vertical: 20)
        );
      });
    } catch (error) {
      CommonDialog.hideLoading();
      CommonDialog.showErrorDialog();

      print(error);
    }
  }


  //  _-_-_-_-_-_-_-_- SIGN OUT _-_-_-_-_-_-_-_-
  Future signOut() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');

    try {
      return await FirebaseAuth.instance.signOut().then((value) {
        Get.offAll(LoginScreen());
      }).onError((error, stackTrace) {
        Get.snackbar('', error.toString());
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  

  //  _-_-_-_-_-_-_-_- PASSWORD RESET _-_-_-_-_-_-_-_-
  Future passwordReset(email) async {

    CommonDialog.showLoading();

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {

      CommonDialog.hideLoading();

      Get.to(() => LoginScreen());

      Get.snackbar(
        'Please check your email', "Reset link sent to you via email", 
        snackPosition: SnackPosition.TOP, 
        margin: EdgeInsets.symmetric(vertical: 20)
      );

    }).onError((error, stackTrace) {
      CommonDialog.hideLoading();

      Get.snackbar(
        'Sorry', error.toString(), 
        snackPosition: SnackPosition.TOP, 
        margin: EdgeInsets.symmetric(vertical: 20)
      );
    });
  }

}