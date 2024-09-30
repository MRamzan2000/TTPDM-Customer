import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/notification_controller.dart';


class NotiFicationScreen extends StatelessWidget {
  const NotiFicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 2.3.h,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Notification ',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.4.h),
        child: Obx(() {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              if (notificationController.todayNotifications.isNotEmpty) ...[
                _buildSectionTitle('Today'),
                ...notificationController.todayNotifications.map((notification) => _buildNotificationItem(notification)),
              ],
              if (notificationController.yesterdayNotifications.isNotEmpty) ...[
                _buildSectionTitle('Yesterday'),
                ...notificationController.yesterdayNotifications.map((notification) => _buildNotificationItem(notification)),
              ],
              if (notificationController.olderNotifications.isNotEmpty) ...[
                _buildSectionTitle('Older Notifications'),
                ...notificationController.olderNotifications.map((notification) => _buildNotificationItem(notification)),
              ],
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getVerticalSpace(1.4.h),
        Row(crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title, style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor)),
            getHorizentalSpace(0.5.h),
            const Expanded(child: Divider(color: Colors.grey)),
          ],
        ),
        getVerticalSpace(1.2.h),
      ],
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    final receivedTime = DateTime.parse(notification['receivedTime']);
    final formattedTime = "${receivedTime.hour}:${receivedTime.minute.toString().padLeft(2, '0')}";

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 1.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                notification['title'],
                style: TextStyle(
                    fontSize: 18.px,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'bold',
                    color: const Color(0xff15141F)),
              ),
              Text(formattedTime, style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor)),
            ],
          ),
          getVerticalSpace(0.8.h),
          Text(notification['body'], style: TextStyle(
              fontSize: 12.px,
              color: const Color(0xff454544),
              fontFamily: 'regular',
              fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
