import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smstopia/controllers/sms_controller.dart';
import 'package:smstopia/screens/settings_screen.dart';
import 'package:telephony/telephony.dart';

onbackgroundMsg(SmsMessage? message) {
  String? sender = message?.address;
  String? msg = message?.body;
  Get.snackbar(
    "Alert",
    "Sender: $sender \nMessage: $msg",
    backgroundColor: Colors.blue,
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
  );
}

class HomeScren extends StatelessWidget {
  HomeScren({Key? key}) : super(key: key);
  SmsController smsController = Get.find<SmsController>();
  @override
  Widget build(BuildContext context) {
    smsController.listenToMessages(onbackgroundMsg);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.yellow,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.yellow,
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "AlphaCorp SMS Server",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(() => SettingScreen(),
                              transition: Transition.rightToLeft);
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.server,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: Get.height * 0.3,
                    child: Card(
                      child: Column(
                        children: [
                          const Spacer(),
                          const Text("Messages Sent"),
                          Obx(() {
                            return Column(
                              children: [
                                Text(
                                  "${smsController.sentMsg.value}",
                                  style: const TextStyle(
                                    fontSize: 50,
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  width: Get.width * 0.8,
                                  child: TextFormField(
                                    onChanged: (val) {
                                      smsController.recepientNum.value = val;
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      hintText: "Enter Phone Number",
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: Get.height * 0.3,
                    child: Card(
                      child: Column(
                        children: [
                          const Spacer(),
                          const Text("Messages Received"),
                          Obx(() {
                            return Column(
                              children: [
                                Text(
                                  "${smsController.receivedMsg.value}",
                                  style: const TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                                Text(
                                    "Sender: ${smsController.sender.value ?? ''}"),
                                Text(
                                    "Message: ${smsController.senderMsg.value ?? ''}"),
                              ],
                            );
                          }),
                          const Spacer(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            smsController.sendSMS();
          },
          child: const FaIcon(FontAwesomeIcons.brain),
        ),
      ),
    );
  }
}
