import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCardController extends GetxController{
  //TextEditingControllers
  final TextEditingController cardNumberController=TextEditingController();
  final TextEditingController cardHolderNameController=TextEditingController();
  final TextEditingController ccvController=TextEditingController();
  //Date and Time Picker
Rx<DateTime>selectedDate=DateTime.now().obs;
Future<void>datePicker(BuildContext context)async{
  DateTime initialDate=DateTime.now();
  DateTime firstDate=DateTime(2000,12,14);
  DateTime lastDate=DateTime(2100);
final DateTime? picked=await showDatePicker(context: context,
    firstDate: firstDate, lastDate: lastDate);
      if(picked !=null&&picked !=selectedDate.value){
        selectedDate.value=picked;
      }

}

}