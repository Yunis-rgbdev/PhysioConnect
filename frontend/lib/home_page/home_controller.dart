import 'dart:convert';
import 'dart:math';

import 'package:frontend/login_page/login_controller.dart';
import 'package:frontend/user_auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserHomeDataController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  final _controllerA = Get.find<AuthController>();
  var userData = {}.obs;
  var isLoading = true.obs;
  var username = ''.obs;
  // var userID = ''.obs;
  var requestCheck = false.obs;
  bool isUserActive = false;
  
  
  @override
  void onInit() {
    super.onInit();
    fetchUserDataById();
  }

  void fetchUserDataById() async {
    final String baseUrl = 'http://127.0.0.1:8000/api';
    final userid = _controllerA.userID.value;
    final username = _controllerA.userName.value;
    print('this is userid variable from home_controller $userid');

    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/patient/${userid}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      // final data = jsonDecode(response.body);
      // username = data['name'] as String? ?? 'No Name';
      // print(username);
      // _controllerA.userID.value = data['id_number'] as String? ?? 'No ID Available';
      // print(_controllerA.userID);
      // isUserActive = data['isActive'] ?? false;
      // print(isUserActive);
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePatientStatus(String status) async {
    isLoading.value = true;

    final postUrl = Uri.parse('http://127.0.0.1:8000/api/request/');

    try {
      final response = await http.post(
        postUrl,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "patient_id": _controllerA.userID.value,
          "status": status,
        }),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      print("${_controllerA.userID}, ${_controllerA.userName}");

      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Patient status updated to $status');
      } else {
        print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      isLoading.value = false;
      print("Exception: $e");
    }
  }
}
