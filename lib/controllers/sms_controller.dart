import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:smstopia/repository/rest_repo.dart';
import 'package:telephony/telephony.dart';

class SmsController extends GetxController {
  final Telephony telephony = Telephony.instance;
  final ApiCall api;

  RxInt sentMsg = 0.obs;
  RxInt receivedMsg = 0.obs;
  RxnString sender = RxnString();
  RxnString senderMsg = RxnString();
  RxString recepientNum = "".obs;

  SmsController(this.api);

  Future intTelephony() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;
    if (result != null && result) {
      debugPrint("ok");
    } else {
      Get.snackbar(
        'Grant Access',
        'Manually Grant Access',
        backgroundColor: Colors.black,
        borderRadius: 30,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.back();
    }
  }

  listener(SendStatus status) {
    if (status == SendStatus.SENT) {
      sentMsg.value += 1;
      recepientNum.value = "";
      Get.snackbar(
        'Success',
        'Message Delivered',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  sendSMS() {
    telephony.sendSms(
        to: recepientNum.value == "" ? "+233508136075" : recepientNum.value,
        message: "Vote",
        statusListener: listener);
  }

  customSend(String? num, String? msg) {
    telephony.sendSms(
      to: num!,
      message: msg!,
      statusListener: listener,
    );
  }

  Future comdb() async {
    var res = await api.addMessage(sender.value, senderMsg.value);
    customSend(sender.value, res);
    Fluttertoast.showToast(msg: "Message Received");
  }

  listenToMessages(Function(SmsMessage?) msg) {
    telephony.listenIncomingSms(
        onNewMessage: (SmsMessage message) async {
          receivedMsg.value += 1;
          sender.value = message.address;
          senderMsg.value = message.body;
          await comdb();
          Fluttertoast.showToast(msg: "Response sent");
        },
        listenInBackground: true,
        onBackgroundMessage: msg);
  }

  @override
  void onInit() async {
    await intTelephony();
    super.onInit();
  }
}
