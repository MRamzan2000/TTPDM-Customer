import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/utils/alert_box.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';

class RequestMoreDesign extends StatefulWidget {
final  String businessId ;
final  String postId ;
   const RequestMoreDesign({super.key,required this.businessId, required this.postId,});

  @override
  State<RequestMoreDesign> createState() => _RequestMoreDesignState();
}

class _RequestMoreDesignState extends State<RequestMoreDesign> {
  RxString token = "".obs;
  RxString currentUserId = "".obs;
  RxString currentUserName = "".obs;

  @override
  void initState() {
    super.initState();
    token.value = MySharedPreferences.getString(authTokenKey);
    currentUserId.value = MySharedPreferences.getString(userIdKey);
    currentUserName.value = MySharedPreferences.getString(userNameKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Add Campaign',
          style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            getVerticalSpace(4.h),
            SizedBox(
                height: 28.h,
                width: 28.h,
                child: const Image(
                    image: AssetImage('assets/pngs/requestmore.png'))),
            getVerticalSpace(2.4.h),
            Text(
              'Request for More Designs',
              style:
                  CustomTextStyles.onBoardingHeading.copyWith(fontSize: 20.px),
            ),
            getVerticalSpace(4.h),
            GestureDetector(
              onTap: () {
                openCampaignPoster(context,
                  token:   token.value,
                 businessId: widget.businessId, currentUserId: currentUserId.value, currentUserName: currentUserName.value, posterId:widget. postId, );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 1.2.h),
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(1.h)),
                child: Text(
                  'Request',
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
