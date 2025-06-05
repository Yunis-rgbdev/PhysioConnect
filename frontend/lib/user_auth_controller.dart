import 'package:get/get.dart';

class AuthController extends GetxController {
  var userID = ''.obs;
  var userName = ''.obs;

  void setUserId(String id, String name) {
    userID.value = id;
    userName.value = name;
    print("id from main controller ${userID.value}");
  }

  String get getUserId => userID.value;
}