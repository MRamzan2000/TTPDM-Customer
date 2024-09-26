import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../check_internet_connectivity.dart';

class ConnectivityController extends GetxController {
  var isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    _startMonitoring();
  }

  void _startMonitoring() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      isConnected.value = status == InternetConnectionStatus.connected;
      if (!isConnected.value) {
        Get.offAll(() => const ConnectivityScreen(), transition: Transition.fadeIn);
      } else {
        Get.back();
      }
    });
  }

  Future<void> checkConnectivity() async {
    final hasConnection = await InternetConnectionChecker().hasConnection;
    if (hasConnection) {
      Get.snackbar(
        'Connection Status',
        'Internet Connection Available',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Connection Status',
        'No Internet Connection! Please Connect With Internet',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
