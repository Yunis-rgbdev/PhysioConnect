import 'package:flutter/material.dart';
import 'package:frontend/authentication_page/authentication_controller.dart';
import 'package:get/get.dart';

class Auth2View extends StatelessWidget {
  final AuthController controllerA = Get.put(AuthController());
  Auth2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                  height: 700,
                  width: 300,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Finish signing up',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Text('Phone Number'),
                      // ),
                      // SizedBox(height: 2),
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: -2,
                            blurRadius: 15,
                            offset: Offset(0, -3), // changes position of shadow
                          ),
                        ]),
                        height: 60,
                        child: TextField(
                          controller: controllerA.phoneNumberController,
                          decoration: InputDecoration(
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(color: Colors.black38),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () => controllerA.sendAuth(),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(300, 50),
                          backgroundColor: Colors.blue[900],
                          padding: EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
