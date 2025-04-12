import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/dashboard_page/dashboard_controller.dart';
import 'package:frontend/information_page/information_controller.dart';
import 'package:frontend/information_page/information_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DashboardView extends StatelessWidget {
  final DashboardController controller = Get.put(DashboardController());
  final InformationController controllerI = Get.put(InformationController());
  // final ApiService _apiService = ApiService();
  DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 24, top: 24),
                  child: Text(
                    'Requests',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 24, top: 24),
                    child: Obx(
                      () {
                        if (controller.isLoading.value) {
                          return const CircularProgressIndicator();
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.patientNames.length,
                            itemBuilder: (context, index) {
                              final patientName =
                                  controller.patientNames[index].toString();
                              final patientID =
                                  controller.patientID[index].toString();
                              bool isDisabled = controller
                                      .patientActivation[index]
                                      .toString()
                                      .toLowerCase() ==
                                  'false';
                              bool isActive = controller
                                      .patientActivation[index]
                                      .toLowerCase() ==
                                  'true';

                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      height: 0.5,
                                      width: MediaQuery.of(context).size.width,
                                      child: Divider(),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 8, bottom: 8, right: 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // ElevatedButton.icon(
                                          //   onPressed: () {
                                          //     Get.to(() => InfoView(
                                          //           patientID: patientID,
                                          //         ));
                                          //   },
                                          //   style: ElevatedButton.styleFrom(
                                          //       backgroundColor: Colors.white10,
                                          //       shadowColor: Colors.black12,
                                          //       iconColor: Colors.orange,
                                          //       iconSize: 20),
                                          //   icon: Icon(Icons.info_outline),
                                          //   label: Text(
                                          //     'Information',
                                          //     style: TextStyle(
                                          //       color: Colors.black,
                                          //       fontWeight: FontWeight.w300,
                                          //       fontSize: 12,
                                          //     ),
                                          //   ),
                                          // ),
                                          // SizedBox(width: 5),
                                          // ElevatedButton.icon(
                                          //     onPressed: () async {
                                          //       final url = Uri.parse(
                                          //           'http://127.0.0.1:8000/api/active/');
                                          //       try {
                                          //         print(patientID.trim());

                                          //         final response =
                                          //             await http.post(
                                          //           url,
                                          //           headers: {
                                          //             "Content-Type":
                                          //                 "application/json",
                                          //             "Accept":
                                          //                 "application/json",
                                          //           },
                                          //           body: jsonEncode({
                                          //             "id_number":
                                          //                 patientID.trim(),
                                          //             "isActive": 0,
                                          //           }),
                                          //         );

                                          //         print(response.body);

                                          //         if (response.statusCode ==
                                          //             200) {
                                          //           final data = jsonDecode(
                                          //               response.body);
                                          //           // Handle successful login (e.g., navigate to next screen)
                                          //           print(
                                          //               "Toggle change success: ${data['user_data']}");
                                          //         } else {
                                          //           final errorData =
                                          //               jsonDecode(
                                          //                   response.body);
                                          //           print(errorData);
                                          //         }
                                          //       } catch (e) {
                                          //         print(
                                          //             "Toggle change exception: $e");
                                          //       }
                                          //     },
                                          //     style: ElevatedButton.styleFrom(
                                          //         backgroundColor:
                                          //             Colors.white10,
                                          //         shadowColor: Colors.black12,
                                          //         iconColor: Colors.red,
                                          //         iconSize: 20),
                                          //     icon: Icon(Icons.cancel),
                                          //     label: Text(
                                          //       'Discard',
                                          //       style: TextStyle(
                                          //           color: Colors.black,
                                          //           fontWeight: FontWeight.w300,
                                          //           fontSize: 12),
                                          //     )),
                                          ElevatedButton.icon(
                                              onPressed: isDisabled
                                                  ? null
                                                  : () async {
                                                      final url = Uri.parse(
                                                          'http://127.0.0.1:8000/api/active/');
                                                      try {
                                                        print(patientID.trim());
                                                        // final isActive = controller
                                                        //         .patientActivation[index];

                                                        print(isDisabled);

                                                        final response =
                                                            await http.post(
                                                          url,
                                                          headers: {
                                                            "Content-Type":
                                                                "application/json",
                                                            "Accept":
                                                                "application/json",
                                                          },
                                                          body: jsonEncode({
                                                            "id_number":
                                                                patientID
                                                                    .trim(),
                                                            "isActive": 0,
                                                          }),
                                                        );

                                                        print(response.body);

                                                        if (response
                                                                .statusCode ==
                                                            200) {
                                                          final data =
                                                              jsonDecode(
                                                                  response
                                                                      .body);
                                                          // Handle successful login (e.g., navigate to next screen)
                                                          print(
                                                              "Toggle change success: ${data['user_data']}");
                                                          // You might want to refresh your UI here to reflect the change
                                                        } else {
                                                          final errorData =
                                                              jsonDecode(
                                                                  response
                                                                      .body);
                                                          print(errorData);
                                                        }
                                                      } catch (e) {
                                                        print(
                                                            "Toggle change exception: $e");
                                                      }
                                                    },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: isDisabled
                                                    ? Colors.grey.shade200
                                                    : Colors.white10,
                                                shadowColor: Colors.black12,
                                                iconColor: isDisabled
                                                    ? Colors.grey
                                                    : Colors.red,
                                                iconSize: 20,
                                                disabledBackgroundColor: Colors
                                                    .grey
                                                    .shade200, // Color when disabled
                                                disabledForegroundColor: Colors
                                                    .grey, // Text color when disabled
                                              ),
                                              icon: Icon(isDisabled
                                                  ? Icons.cancel_outlined
                                                  : Icons.cancel),
                                              label: Text(
                                                isDisabled
                                                    ? 'Patient Disabled'
                                                    : 'Disable',
                                                style: TextStyle(
                                                    color: isDisabled
                                                        ? Colors.grey
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12),
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          ElevatedButton.icon(
                                              onPressed: isActive
                                                  ? null
                                                  : () async {
                                                      final url = Uri.parse(
                                                          'http://127.0.0.1:8000/api/active/');
                                                      try {
                                                        print(patientID.trim());
                                                        // final isActive = controller
                                                        //         .patientActivation[index];

                                                        print(isActive);

                                                        final response =
                                                            await http.post(
                                                          url,
                                                          headers: {
                                                            "Content-Type":
                                                                "application/json",
                                                            "Accept":
                                                                "application/json",
                                                          },
                                                          body: jsonEncode({
                                                            "id_number":
                                                                patientID
                                                                    .trim(),
                                                            "isActive": 1,
                                                          }),
                                                        );

                                                        print(response.body);

                                                        if (response
                                                                .statusCode ==
                                                            200) {
                                                          final data =
                                                              jsonDecode(
                                                                  response
                                                                      .body);
                                                          // Handle successful login (e.g., navigate to next screen)
                                                          print(
                                                              "Toggle change success: ${data['user_data']}");
                                                          // You might want to refresh your UI here to reflect the change
                                                        } else {
                                                          final errorData =
                                                              jsonDecode(
                                                                  response
                                                                      .body);
                                                          print(errorData);
                                                        }
                                                      } catch (e) {
                                                        print(
                                                            "Toggle change exception: $e");
                                                      }
                                                    },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: isActive
                                                    ? Colors.grey.shade200
                                                    : Colors.white10,
                                                shadowColor: Colors.black12,
                                                iconColor: isActive
                                                    ? Colors.grey
                                                    : Colors.green,
                                                iconSize: 20,
                                                disabledBackgroundColor: Colors
                                                    .grey
                                                    .shade200, // Color when disabled
                                                disabledForegroundColor: Colors
                                                    .grey, // Text color when disabled
                                              ),
                                              icon: Icon(isActive
                                                  ? Icons.check_circle_outline
                                                  : Icons.check_circle),
                                              label: Text(
                                                isActive
                                                    ? 'Patient Active'
                                                    : 'Accept',
                                                style: TextStyle(
                                                    color: isActive
                                                        ? Colors.grey
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 12),
                                              )),
                                          SizedBox(width: 16),
                                          Text(
                                            '($patientID)',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 10),
                                          ),
                                          SizedBox(width: 5),
                                          Text(patientName),
                                          SizedBox(width: 16),
                                          CircleAvatar(
                                            child: Text(patientName[0]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
