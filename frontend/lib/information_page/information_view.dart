import 'package:flutter/material.dart';
import 'package:frontend/information_page/information_controller.dart';
import 'package:get/get.dart';

class InfoView extends StatelessWidget {
  final InformationController controllerInfo = Get.put(InformationController());
  final String patientID;

  InfoView({super.key, required this.patientID}) {
    controllerInfo.retrievePatientInfo(patientID);
  }

  @override
  Widget build(BuildContext context) {
    final patientName = controllerInfo.patientName;
    final patientAge = controllerInfo.patientAge;
    print(patientID);

    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (controllerInfo.isLoading.value) {
            return const CircularProgressIndicator();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name: $patientName',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('ID: $patientID', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Text('Age: $patientAge', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Gender: Male', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Text('phone: 1234567890', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Text('Extra Information', style: TextStyle(fontSize: 16)),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
