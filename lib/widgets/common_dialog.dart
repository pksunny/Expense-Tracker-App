// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker_app/utils/txt_style.dart';

class CommonDialog {
  static showLoading({String title = "Loading..."}) {
    Get.dialog(
      Dialog(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 40,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static hideLoading() {
    Get.back();
  }

  static showErrorDialog({
    String title = "Oops Error",
    String description = "Something went wrong ",
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: primary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline6,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primary,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: -8,
                            blurRadius: 17,
                            offset: Offset(5, -10),
                            color: Colors.white),
                        BoxShadow(
                            spreadRadius: -2,
                            blurRadius: 10,
                            offset: Offset(7, 7),
                            color: Color.fromRGBO(146, 182, 216, 1)),
                      ]),
                  child: Text('Okay',
                      style: TxtStyle.headLineStyle3.copyWith(color: Colors.blueGrey)),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static showDialog({
    String title = "Oops Error",
    String description = "Something went wrong ",
    required final VoidCallback onDelete,
  }) {
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline6,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (Get.isDialogOpen!) Get.back();
                    },
                    child: const Text("No"),
                  ),
                  ElevatedButton(
                    onPressed: onDelete,
                    child: const Text("Yes"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
