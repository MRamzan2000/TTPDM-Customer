import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
import 'package:ttpdm/controller/custom_widgets/custom_text_styles.dart';
import 'package:ttpdm/controller/custom_widgets/widgets.dart';
import 'package:ttpdm/controller/getx_controllers/add_campaign_controller.dart';
import 'package:ttpdm/controller/getx_controllers/business_profile_controller.dart';
import 'package:ttpdm/controller/getx_controllers/get_fcm_token_send_notification_controller.dart';
import 'package:ttpdm/controller/utils/apis_constant.dart';
import 'package:ttpdm/controller/utils/my_shared_prefrence.dart';
import 'package:ttpdm/controller/utils/preference_key.dart';
import 'package:ttpdm/view/screens/bottom_navigationbar.dart';

class AddNewBusiness extends StatefulWidget {
  const AddNewBusiness({super.key});

  @override
  State<AddNewBusiness> createState() => _AddNewBusinessState();
}

class _AddNewBusinessState extends State<AddNewBusiness> {
  final AddCampaignController addCampaignController = Get.put(AddCampaignController());
  final TextEditingController bsNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController webUrlController = TextEditingController();
  final TextEditingController facebookUrlController = TextEditingController();
  final TextEditingController instagramUrlController = TextEditingController();
  final TextEditingController linkdinUrlController = TextEditingController();
  final TextEditingController tikTokUrlController = TextEditingController();

  RxString token = "".obs;
  RxString fullname = "".obs;
  RxString id = "".obs;

  bool _isValidUrl(String url) {
    final Uri uri = Uri.tryParse(url) ?? Uri();
    return uri.hasAbsolutePath && (uri.hasScheme && uri.hasAuthority);
  }

  void validateFields() {
    final List<String> errorMessages = [];

    // Logo is required
    if (addCampaignController.image.value == null) {
      errorMessages.add('Logo is required.');
    }
    if(locationController.text.isEmpty){
      errorMessages.add("Location are required! please enter location");
    }else if(targetController.text.isEmpty){
      errorMessages.add("Target Map area required! please enter Target Map area");
    }else
    if(descriptionController.text.length<50){
     errorMessages.add("Description length At least 50 character");
    }

    // Other fields are optional, but validate URLs if provided
    if (webUrlController.text.isNotEmpty && !_isValidUrl(webUrlController.text)) {
      errorMessages.add('Please enter a valid website URL.');
    }
    if (facebookUrlController.text.isNotEmpty && !_isValidUrl(facebookUrlController.text)) {
      errorMessages.add('Please enter a valid Facebook URL.');
    }
    if (instagramUrlController.text.isNotEmpty && !_isValidUrl(instagramUrlController.text)) {
      errorMessages.add('Please enter a valid Instagram URL.');
    }
    if (tikTokUrlController.text.isNotEmpty && !_isValidUrl(tikTokUrlController.text)) {
      errorMessages.add('Please enter a valid TikTok URL.');
    }
    if (linkdinUrlController.text.isNotEmpty && !_isValidUrl(linkdinUrlController.text)) {
      errorMessages.add('Please enter a valid LinkedIn URL.');
    }

    // Show errors or proceed
    if (errorMessages.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessages.join('\n')),
          duration: const Duration(seconds: 5),
        ),
      );
    } else {
      submitForm();
    }
  }

  Future<void> submitForm() async {
    await businessProfileController.submitBusinessProfile(
      name: bsNameController.text,
      phone: phoneNumberController.text,
      location: locationController.text,
      targetMapArea: targetController.text,
      description: descriptionController.text,
      gallery: addCampaignController.pickedFilesList,
      token: token.value,
      websiteUrl: webUrlController.text,
      tiktokUrl: tikTokUrlController.text,
      linkedinUrl: linkdinUrlController.text,
      instagramUrl: instagramUrlController.text,
      facebookUrl: facebookUrlController.text,
      logo: addCampaignController.image.value!,
      context: context,
      fullname: fullname.value,
    );

    // Reset form fields and picked files
    addCampaignController.image.value = null;
    addCampaignController.pickedFilesList.clear();
    addCampaignController.pickedMediaList.clear();
    bsNameController.clear();
    phoneNumberController.clear();
    locationController.clear();
    targetController.clear();
    descriptionController.clear();
    webUrlController.clear();
    facebookUrlController.clear();
    instagramUrlController.clear();
    linkdinUrlController.clear();
    tikTokUrlController.clear();

    Get.to(() => const CustomBottomNavigationBar());
  }

  final BusinessProfileController businessProfileController = Get.find(tag: 'business');
  late GetFcmTokenSendNotificationController getFcmTokenSendNotificationController;

  @override
  void initState() {
    super.initState();
    getFcmTokenSendNotificationController = Get.put(GetFcmTokenSendNotificationController(context: context));
    id.value = MySharedPreferences.getString(userId);
    token.value = MySharedPreferences.getString(authToken);
    fullname.value = MySharedPreferences.getString(userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            addCampaignController.image.value = null;
            addCampaignController.pickedMediaList.clear();
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            size: 2.4.h,
            color: const Color(0xff191918),
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Add Business Profile',
          style: CustomTextStyles.buttonTextStyle.copyWith(
            fontSize: 20.px,
            fontWeight: FontWeight.w600,
            color: AppColors.mainColor,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: validateFields,
            child: Padding(
              padding: EdgeInsets.only(right: 2.h),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 16.px,
                  color: const Color(0xff34C759),
                  fontFamily: 'bold',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
            () => businessProfileController.isLoading1.value
            ? spinkit1
            : SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.4.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getVerticalSpace(2.4.h),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            addCampaignController.pickImage(ImageSource.gallery);
                          },
                          child: ClipOval(
                            child: addCampaignController.image.value != null
                                ? Image.file(
                              addCampaignController.image.value!,
                              fit: BoxFit.cover,
                              width: 4.2.h * 2,
                              height: 4.2.h * 2,
                            )
                                : SvgPicture.asset(
                              "assets/svgs/myprofile.svg",
                              fit: BoxFit.cover,
                              width: 4.2.h * 2,
                              height: 4.2.h * 2,
                            ),
                          ),
                        ),
                        getVerticalSpace(.8.h),
                        Text(
                          'Logo',
                          style: TextStyle(
                            fontSize: 14.px,
                            color: const Color(0xff454544),
                            fontFamily: 'regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  getVerticalSpace(4.h),
                  _buildTextField('Business Name', bsNameController),
                  getVerticalSpace(1.6.h),
                  _buildTextField('Phone Number', phoneNumberController, keyboardType: TextInputType.number),
                  getVerticalSpace(1.6.h),
                  _buildTextField('Location', locationController),
                  getVerticalSpace(1.6.h),
                  _buildTextField('Target Map Area', targetController),
                  getVerticalSpace(1.6.h),
                  _buildUrlSection('What’s your website URL?', 'This could be a web page or social media page', webUrlController),
                  getVerticalSpace(1.6.h),
                  _buildUrlSection('Facebook', 'Enter your Facebook Account', facebookUrlController),
                  getVerticalSpace(1.6.h),
                  _buildUrlSection('Instagram', 'Enter your Instagram Account', instagramUrlController),
                  getVerticalSpace(1.6.h),
                  _buildUrlSection('Tiktok', 'Enter your TikTok Account', tikTokUrlController),
                  getVerticalSpace(1.6.h),
                  _buildUrlSection('Linkedin', 'Enter your LinkedIn Account', linkdinUrlController),
                  getVerticalSpace(1.6.h),
                  _buildTextField('Business description', descriptionController, maxLines: 4),
                  getVerticalSpace(1.6.h),
                  _buildGallerySection(),
                  getVerticalSpace(2.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'bold',
            color: const Color(0xff454544),
            fontSize: 14.px,
          ),
        ),
        getVerticalSpace(.8.h),
        customTextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLine: maxLines,
          bgColor: AppColors.whiteColor,
        ),
      ],
    );
  }

  Widget _buildUrlSection(String title, String subtitle, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CustomTextStyles.onBoardingHeading.copyWith(
            color: const Color(0xff191918),
            fontSize: 14.px,
            fontWeight: FontWeight.w500,
            fontFamily: 'bold',
          ),
        ),
        getVerticalSpace(.8.h),
        Text(
          subtitle,
          style: CustomTextStyles.onBoardingHeading.copyWith(
            color: const Color(0xff6E6E6D),
            fontSize: 12.px,
            fontWeight: FontWeight.w500,
            fontFamily: 'regular',
          ),
        ),
        getVerticalSpace(.8.h),
        customTextFormField(
          controller: controller,
          bgColor: AppColors.whiteColor,
        ),
      ],
    );
  }

  Widget _buildGallerySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gallery',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'bold',
                fontSize: 14.px,
                color: const Color(0xff282827),
              ),
            ),
            GestureDetector(
              onTap: () {
                addCampaignController.pickMedia();
              },
              child: Text(
                'Upload',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'bold',
                  fontSize: 14.px,
                  color: const Color(0xff007AFF),
                ),
              ),
            ),
          ],
        ),
        getVerticalSpace(1.2.h),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'You can upload your business images and videos',
            style: TextStyle(
              fontSize: 12.px,
              color: const Color(0xff7C7C7C),
              fontFamily: 'regular',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        getVerticalSpace(1.h),
        SizedBox(
          height: 50.3.h,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: addCampaignController.pickedMediaList.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2.1.h,
              crossAxisSpacing: 1.6.h,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: .5.h, vertical: .5.h),
                    height: 11.3.h,
                    width: 11.6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.h),
                      color: AppColors.whiteColor,
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                          blurRadius: 8,
                          color: Color(0xffFFE4EA),
                        ),
                      ],
                      image: DecorationImage(
                        image: addCampaignController.pickedMediaList[index]['isVideo'] == "true"
                            ? FileImage(File(addCampaignController.pickedMediaList[index]['path']!))
                            : FileImage(File(addCampaignController.pickedMediaList[index]['path']!)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 2.h,top:0,
                    child: GestureDetector(
                      onTap:(){
                        addCampaignController.removeMedia(index);
                      },
                      child: SizedBox(
                        height:3.h,width:3.h,
                          child: SvgPicture.asset("assets/svgs/crossicon.svg")),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
