import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ConfigController extends GetxController {
  final box = GetStorage();

  RxnString baseURL = RxnString();
  RxnString tableName = RxnString();

  RxnString readBaseURL = RxnString();
  RxnString readTableName = RxnString();
  RxBool error = false.obs;
  RxBool isLoading = false.obs;

  saveData() {
    isLoading.toggle();
    box.write(
        'baseURL', baseURL.value == "" ? readBaseURL.value : baseURL.value);
    box.write('tableName',
        tableName.value == "" ? readTableName.value : tableName.value);
    readData();
    baseURL.value = "";
    tableName.value = "";
    Fluttertoast.showToast(msg: "Configurations Saved");
    isLoading.toggle();
  }

  readData() {
    readBaseURL.value = box.read('baseURL');
    readTableName.value = box.read('tableName');
    print(readBaseURL.value);
    print(readTableName.value);
  }

  @override
  void onReady() {
    readData();
    super.onReady();
  }
}
