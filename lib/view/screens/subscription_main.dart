import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/extensions.dart';
import 'package:ttpdm/controller/getx_controllers/add_card_controller.dart';

import '../../controller/custom_widgets/app_colors.dart';
import '../../controller/custom_widgets/custom_text_styles.dart';
import 'campaign_section/campaign_name.dart';

class Subscription  extends StatelessWidget {
   Subscription ({super.key});
final AddCardController addCardController=Get.put(AddCardController());
  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex=0.obs;
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscription ',
          style: CustomTextStyles.onBoardingHeading.copyWith(fontSize: 20.px),
        ),
        centerTitle: true,
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 2.5.h),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getVerticalSpace(4.h),
              Text('Coin Balance',style: TextStyle(
                fontSize: 12.px,
                fontFamily: 'bold',
                fontWeight: FontWeight.w700,
                color: const Color(0xff191918)
              ),),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 3.2.h,
                      child: const Image(image: AssetImage('assets/pngs/coinicon.png'))),
                  Text('1200',style: TextStyle(
                      fontSize: 32.px,
                      fontFamily: 'bold',
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff191918)
                  ),),

                ],
              ),
              getVerticalSpace(4.h),
              Align(alignment: Alignment.centerLeft,
                child: Text('Buy Credit',style: TextStyle(
                    fontSize: 14.px,
                    fontFamily: 'bold',
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff191918)
                ),),
              ),getVerticalSpace(1.6.h),
              Expanded(
                child: GridView.builder(padding: EdgeInsets.zero,
                  itemCount: 7,

                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                  mainAxisSpacing: 2.1.h,
                  crossAxisSpacing: 1.6.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(onTap: (){
                        selectedIndex.value=index;
                      },
                        child: Obx(()=>
                           Container(alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: .5.h,vertical: .5.h),
                            height: 11.3.h,
                            width: 11.6.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.h),
                              color:selectedIndex.value==index?AppColors.mainColor:
                                AppColors.whiteColor,
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  color: Color(0xffFFE4EA)
                                )
                              ]
                            ),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 3.2.h,
                                    child: const Image(image: AssetImage('assets/pngs/coinicon.png')))
                                ,Text('1200',style: TextStyle(
                                    fontSize: 14.px,
                                    fontFamily: 'bold',
                                    fontWeight: FontWeight.w500,
                                    color:selectedIndex.value==index?
                                    AppColors.whiteColor: const Color(0xff4D4F53)
                                ),),
                                getVerticalSpace(1.2.h),
                                Container(  padding: EdgeInsets.symmetric(horizontal: .5.h,vertical: .5.h),
                                  decoration: BoxDecoration(
                                    color:selectedIndex.value==index?AppColors.whiteColor: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(5.h)

                                  ),child: Text('\$12.80',style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'bold',
                                  fontSize: 12.px,
                                  color:selectedIndex.value==index?
                                  AppColors.mainColor:AppColors.whiteColor

                                ),),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },),
              ),
              customElevatedButton(
                  title: 'Recharge',
                  onTap: () {
                    openBottomSheet(context);
                  },
                  bgColor: AppColors.mainColor,
                  titleColor: AppColors.whiteColor,
                  verticalPadding: .9.h,
                  horizentalPadding: 3.h),
              getVerticalSpace(15.h),

            ],
          ),
        ),
      ),
    );
  }
  void openBottomSheet(
      BuildContext context,) {
    Get.bottomSheet(
      SizedBox(
        height: 60.h,
        width:MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(20.px),
          child:  SingleChildScrollView(
            child: Column(
              children: [

               ListTile(
                 leading: const Image(image: AssetImage('assets/pngs/addpayment.png')),
                 title: Text('Add card',style: TextStyle(fontSize: 16.px,
                 fontFamily: 'bold',color: const Color(0xff292D32),
                   fontWeight: FontWeight.w500
                 ),),
                 subtitle: Text('Streamline your checkout process by adding a new card for future transactions. Your card information is secured with advanced encryption technology.',style: TextStyle(fontSize: 12.px,
                     fontFamily: 'bold',color: const Color(0xffA9ACB4),
                     fontWeight: FontWeight.w500
                 ),) ,
               ),
                getVerticalSpace(1.h),
                const Divider(
                  color:Color(0xffCBD0DC),)
                ,getVerticalSpace(3.4.h),
                customTextFormField(
                    keyboardType: TextInputType.number
                    ,
                    title: '0000 0000 0000',
                  errorText: 'Card Number',
                  bgColor: Colors.transparent,
                  borderColor: const Color(0xffCBD0DC),
                  focusBorderColor: AppColors.mainColor,
                  prefix: '4966 |'

                ),
                getVerticalSpace(3.2.h),
                Row(children: [
                  Obx(()=>
                     Expanded(
                      child:  customTextFormField(
                        onTap: (){
                          addCardController.datePicker(context);
                        },
                        readOnly: true,
                          keyboardType: TextInputType.number
                          ,
                          title: addCardController.selectedDate.value.format(pattern: 'yyyy-MM-dd'),
                          errorText: 'Expiry Date',
                          bgColor: Colors.transparent,
                          borderColor: const Color(0xffCBD0DC),
                          focusBorderColor: AppColors.mainColor,


                      ),
                    ),
                  ),getHorizentalSpace(2.h),
                  Expanded(
                    child:  customTextFormField(
                        keyboardType: TextInputType.number
                        ,
                        title: '•••',
                        errorText: 'CVV',
                        bgColor: Colors.transparent,
                        borderColor: const Color(0xffCBD0DC),
                        focusBorderColor: AppColors.mainColor,


                    ),
                  )
                ],),
                getVerticalSpace(3.2.h),
                customTextFormField(
                    keyboardType: TextInputType.number
                    ,
                    title: 'Enter cardholder’s full name',
                    errorText: 'Cardholder’s Name',
                    bgColor: Colors.transparent,
                    borderColor: const Color(0xffCBD0DC),
                    focusBorderColor: AppColors.mainColor,

                ),
                getVerticalSpace(3.6.h),

                customElevatedButton(
                    title: 'Buy',
                    onTap: () {
                      Get.to(()=> CampaignName());
                    },
                    bgColor: AppColors.mainColor,
                    titleColor: AppColors.whiteColor,
                    verticalPadding: .9.h,
                    horizentalPadding: 5.h),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
    );
  }


}
