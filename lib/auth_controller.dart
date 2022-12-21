import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youbike/login_page.dart';
import 'package:youbike/welcome_page.dart';

import 'Database/firestore_reference.dart';

class AuthController extends GetxController {
  //so we can use AuthController.instance..
  static AuthController instance = Get.find();
  //email, password, name,...
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //bind the user to the stream, our user would be notified
    _user.bindStream(auth.userChanges());
    //will be listening to any changes
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => WelcomePage(email: user.email));
    }
  }

  void register(String email, password) async {
    try {
      var user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      createUser(email, user.user?.uid);
    } catch (e) {
      Get.snackbar("About User", "User message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text("Account creation failed",
              style: TextStyle(color: Colors.white)),
          messageText:
              Text(e.toString(), style: const TextStyle(color: Colors.white)));
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About Logion", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText:
              const Text("Login failed", style: TextStyle(color: Colors.white)),
          messageText:
              Text(e.toString(), style: const TextStyle(color: Colors.white)));
    }
  }

  void logout() async {
    await auth.signOut();
  }
}

createUser(String email, String? id) async {
  DatabaseManager db = DatabaseManager();
  db.addUser(email: email, id: id);
}
