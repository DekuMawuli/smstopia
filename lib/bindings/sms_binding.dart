import 'package:get/get.dart';
import 'package:smstopia/controllers/config_controller.dart';
import 'package:smstopia/controllers/sms_controller.dart';
import 'package:smstopia/repository/rest_repo.dart';

class SMSBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SmsController>(() => SmsController(ApiCall()));
    Get.lazyPut<ConfigController>(() => ConfigController());
  }
}
