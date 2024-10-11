import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/view/screens/splash_screen.dart';
import '../controller/getx_controllers/internet_connectvty_controller.dart';

class ConnectivityScreen extends StatelessWidget {
  const ConnectivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConnectivityController connectivityController = Get.find();

    return WillPopScope(
      onWillPop: () async {
        return connectivityController.isConnected.value;
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff8f9fa),
        body: Obx(() {
          if (connectivityController.isConnected.value) {
            return const SplashScreen();
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: noInternet(),
            );
          }
        }),
      ),
    );
  }

  Widget noInternet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/pngs/no_internet.png',
          color: AppColors.mainColor,
          height: 100,
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            "No Internet connection",
            style: TextStyle(fontSize: 22.px, color: AppColors.mainColor),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20.px),
          child: Text(
            "Check your connection, then refresh the page.",
            style: TextStyle(color: AppColors.mainColor),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(AppColors.mainColor),
          ),
          onPressed: () async {
            await Get.find<ConnectivityController>().checkConnectivity();
          },
          child: Text(
            "Refresh",
            style: TextStyle(color: AppColors.whiteColor),
          ),
        ),
      ],
    );
  }
}
