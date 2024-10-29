import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:ttpdm/models/get_campaigns_by_status_model.dart';
import '../apis_services/add_campaign_apis.dart';
import '../custom_widgets/app_colors.dart';
import '../custom_widgets/widgets.dart';
class AddCampaignController extends GetxController {
  //TextEditingController
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController webUrlController = TextEditingController();
  final TextEditingController campaignDescriptionController =
      TextEditingController();
  final TextEditingController totalCampaignBudgetController =
      TextEditingController();
  //Method Calender range of Dates
  RxString range = ''.obs;
  RxString startDateCampaign = ''.obs;
  RxString endDateCampaign = ''.obs;
  RxString startFormatDate = ''.obs;
  RxString endFormatDate = ''.obs;
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      range.value = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
          // ignore: lines_longer_than_80_chars

          ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      DateTime startDate = args.value.startDate;
      DateTime endDate = args.value.endDate ?? args.value.startDate;

      startDateCampaign.value = DateFormat('dd MMM yy').format(startDate);

      endDateCampaign.value = DateFormat('dd MMM yy').format(endDate);
      log('start Date is that :${startDateCampaign.value}');
      log('end Date is that :${endDateCampaign.value}');
      startFormatDate.value = DateFormat('yyyy-MM-dd').format(startDate);
      endFormatDate.value = DateFormat('yyyy-MM-dd').format(endDate);
      log('start Date is that :${startFormatDate.value}');
      log('end Date is that :${endFormatDate.value}');

      range.value = '${startDateCampaign.value} TO ${endDateCampaign.value}';
    } else if (args.value is DateTime) {
    } else if (args.value is List<DateTime>) {
    } else {}
  }

//Dialog of Range Date picker

  void showDateRangePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            color: Colors.white,
            height: 30.h,
            width: 30.h,
            child: SfDateRangePicker(
              selectionColor: AppColors.mainColor,
              rangeSelectionColor: AppColors.mainColor,
              viewSpacing: 1.h,
              backgroundColor: Colors.white,
              todayHighlightColor: AppColors.mainColor,
              onSelectionChanged: onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 4)),
                DateTime.now().add(const Duration(days: 3)),
              ),
            ),
          ),
        );
      },
    );
  }

//create instance for Image Picker
  var pickedMediaList = <Map<String, dynamic>>[].obs;
  var pickedFilesList = <File>[].obs;

  // Method to convert Map type list to File type list and store in pickedFilesList
  void convertMediaListToFileList() {
    pickedFilesList.value = pickedMediaList.map((mediaInfo) {
      return File(mediaInfo['path']);
    }).toList();
  }

  Future<void> pickMedia() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        for (var file in result.files) {
          if (file.path != null) {
            final mediaFile = File(file.path!);
            final mediaSize = _getFileSize(mediaFile.lengthSync(), 2);
            final mimeType = lookupMimeType(mediaFile.path);

            log('Picked file: ${file.path}');
            log('File size: $mediaSize');
            log('MIME type: $mimeType');

            if (mimeType?.startsWith('image/') == true) {
              final mediaInfo = {
                'path': mediaFile.path,
                'size': mediaSize,
                'type': mimeType,
                'isVideo': 'false',
              };

              pickedMediaList.add(mediaInfo);
            } else {
              log('File is not an image: ${file.path}');
            }
          }
        }
        convertMediaListToFileList();
      } else {
        log('No media selected');
      }
    } catch (e) {
      log('Error: ${e.toString()}');
    }
  }

  String _getFileSize(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (bytes.bitLength - 1) ~/ 10;
    double size = bytes / (1 << (i * 10));
    return '${size.toStringAsFixed(size < 10 ? decimals : 0)} ${suffixes[i]}';
  }

  String _getFileExtension(String filePath) {
    return filePath.split('.').last.toLowerCase();
  }

  bool isVideo(String filePath) {
    final fileExtension = _getFileExtension(filePath);
    const videoExtensions = ['mp4', 'avi', 'mov', 'mkv'];
    return videoExtensions.contains(fileExtension);
  }

  void removeMedia(int index) {
    pickedMediaList.removeAt(index);
  }

  //picked image
  var image = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  //AddCampaign Api call methods
  RxBool isLoading = true.obs;
  RxBool addCampaignLoading = false.obs;

  Future<void> submitCampaign(
      {required String businessId,
      required String adsName,
      required String campaignDesc,
      required String campaignPlatforms,
      required String startDate,
      required String endDate,
      required String startTime,
      required String endTime,
      required String adBanner,
      required String token,
      required String cost,
      required BuildContext context // Corrected list<File> to List<File>}
      }) async {
    try {
      addCampaignLoading.value = true;
      await AddCampaignApis()
          .addCampaignApi(
              businessId: businessId,
              adsName: adsName,
              campaignDesc: campaignDesc,
              campaignPlatforms: campaignPlatforms,
              startDate: startDate,
              endDate: endDate,
              startTime: startTime,
              endTime: endTime,
              token: token,
              context: context,
              adBannerUrl: adBanner,
              cost: cost)
          .then(
        (value) {
          return addCampaignLoading.value = false;
        },
      );
    } catch (e) {
      if (context.mounted) {
        customScaffoldMessenger('Something went wrong ${e.toString()}');
        log("un expected error ${e.toString()}");
      }
      addCampaignLoading.value = false;
    }
  }

  // Define loadAsset method
  Future<ByteData> loadAsset(String path) async {
    debugPrint('Loading asset: $path');
    return await rootBundle.load(path);
  }

  Future<File> writeByteDataToFile(ByteData data, String filename) async {
    debugPrint('Writing ByteData to file: $filename');
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/$filename';

    final file = File(path);
    final buffer = data.buffer.asUint8List();
    await file.writeAsBytes(buffer);

    debugPrint('File written at: $path');
    return file;
  }

  //pay Campaign fee
  Future<void> campaignFeeSubmit({
    required BuildContext context,
    required String token,
  }) async {
    try {
      isLoading.value = true;

      AddCampaignApis().payCampaignFee(context: context, token: token).then(
        (value) {
          return isLoading.value = false;
        },
      );
    } catch (e) {
      log('Unexpected error occurred :${e.toString()}');
    }
  }

  //RequestMoreDesign
  RxBool requestLoading = false.obs;
  Future<void> requestForMoreDesign({
    required BuildContext context,
    required String token,
    required String description,
    required String businessId,
  }) async {
    try {
      requestLoading.value = true;

      AddCampaignApis()
          .getDesignRequest(
        description: description,
        token: token,
        context: context,
        businessId: businessId,
      )
          .then(
        (value) {
          return requestLoading.value = false;
        },
      );
    } catch (e) {
      log('Unexpected error occurred :${e.toString()}');
    }
  }

  //getCampaignByStatus
  Rxn<GetCampaignsByStatusModel?> approvedCampaigns =
      Rxn<GetCampaignsByStatusModel>();
  Rxn<GetCampaignsByStatusModel?> pendingCampaigns =
      Rxn<GetCampaignsByStatusModel>();
  Rxn<GetCampaignsByStatusModel?> rejectedCampaigns =
      Rxn<GetCampaignsByStatusModel>();

  Future<void> fetchCampaignByStatus(
      {required BuildContext context,
      required bool isLoad,
      required String status}) async {
    isLoading.value = isLoad;
    final data = await AddCampaignApis().getCampaignByStatus(status: status);
    if (data != null) {
      status == "approved"
          ? approvedCampaigns.value = data
          : status == "pending"
              ? pendingCampaigns.value = data
              : rejectedCampaigns.value = data;
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }
  //Cancel Campaign
}
