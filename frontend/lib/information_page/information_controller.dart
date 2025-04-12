import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<List<dynamic>> getAllPatientsData() async {
    final response = await http.get(Uri.parse('$baseUrl/patients/'));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['patients'];
    } else {
      throw Exception('Failed to load patients');
    }
  }
}

class InformationController extends GetxController {
  final ApiService _apiService = ApiService();
  var patientName = ''.obs;
  var patientID = ''.obs;
  var patientAge = ''.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> retrievePatientInfo(String searchID) async {
    isLoading.value = true;
    print('$searchID, this is searchID');

    try {
      final List<dynamic> infoListJson = await _apiService.getAllPatientsData();

      final patient = infoListJson.firstWhere(
        (patient) => patient['id_number'].toString() == searchID,
        orElse: () => null,
      );

      if (patient != null) {
        patientName.value = patient['name'] ?? 'No Name Available';
        patientID.value = patient['id_number'].toString();
        patientAge.value = patient['age']?.toString() ?? 'No Age Available';
      } else {
        patientName.value = 'Patient Not Found';
        patientID.value = '';
        patientAge.value = 'Age Not Found';
      }
    } catch (e) {
      print('Error: $e');
      patientName.value = 'Error Occurred';
      patientID.value = '';
      patientAge.value = '';
    } finally {
      isLoading.value = false;
    }
  }
}
