import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ApiCall {
  final box = GetStorage();
  Dio _dio = Dio();
  Future addMessage(String? number, String? msg) async {
    var formdata = FormData.fromMap({
      'sender': number,
      'senderMessage': msg,
    });

    Response response = await _dio.post(box.read("baseURL"), data: formdata);

    return response.data.toString();
  }
}
