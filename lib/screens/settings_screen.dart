// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smstopia/controllers/config_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final ConfigController _configController = Get.find<ConfigController>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.yellow,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.yellow),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Config SMS Server"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: ListView(
            shrinkWrap: true,
            children: [
              Obx(
                () {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Base URL:",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        color: Colors.yellow,
                        child: Text(
                          "${_configController.readBaseURL.value}",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              Obx(
                () {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Processing Variable:",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        color: Colors.blue,
                        child: Text(
                          "${_configController.readTableName.value}",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontSize: 16,
                                  ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Base URL",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => SizedBox(
                  height: 50,
                  width: Get.width * 0.8,
                  child: TextFormField(
                    initialValue: _configController.baseURL.value ?? "",
                    keyboardType: TextInputType.url,
                    onChanged: (val) {
                      _configController.baseURL.value = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Enter Base URL",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Processing Variable",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => SizedBox(
                  height: 50,
                  width: Get.width * 0.8,
                  child: TextFormField(
                    initialValue: _configController.tableName.value ?? "",
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      _configController.tableName.value = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Enter Database Table Name",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: ElevatedButton(
                    clipBehavior: Clip.hardEdge,
                    onPressed: () => _configController.saveData(),
                    child: const Text(
                      "Save Configurations",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
