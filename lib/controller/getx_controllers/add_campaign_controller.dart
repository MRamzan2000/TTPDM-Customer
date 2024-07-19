import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../custom_widgets/app_colors.dart';

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
  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      range.value = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
          // ignore: lines_longer_than_80_chars

          ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      DateTime startDate = args.value.startDate;
      DateTime endDate = args.value.endDate ?? args.value.startDate;

      String formattedStartDate = DateFormat('dd MMM yy').format(startDate);
      String formattedEndDate = DateFormat('dd MMM yy').format(endDate);

      range.value = '$formattedStartDate TO $formattedEndDate';
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
  var pickedMediaList = <Map<String, String>>[].obs;

  Future<void> pickMedia() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4', 'avi', 'mov', 'mkv'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        for (var file in result.files) {
          if (file.path != null) {
            final mediaFile = File(file.path!);
            final mediaSize = _getFileSize(mediaFile.lengthSync(), 2);
            final mediaType = _getFileExtension(mediaFile.path);

            final mediaInfo = {
              'path': mediaFile.path,
              'size': mediaSize,
              'type': mediaType,
              'isVideo': isVideo(mediaFile.path) ? 'true' : 'false',
            };

            pickedMediaList.add(mediaInfo);
            log('${isVideo(mediaFile.path) ? 'Video' : 'Image'} size $mediaSize');
          }
        }
      } else {
        log('Sorry, no media selected');
      }
    } catch (e) {
      log('Something went wrong: ${e.toString()}');
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
}
