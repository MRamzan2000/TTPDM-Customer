import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/custom_widgets/app_colors.dart';
import '../../../controller/custom_widgets/custom_text_styles.dart';
import '../../../controller/custom_widgets/widgets.dart';
import '../../../controller/extensions.dart';
import '../../../controller/getx_controllers/chat_controller.dart';
import '../../../models/chat_details_model.dart';

class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({super.key});

  @override
  State<ChatSupportScreen> createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {
  TextEditingController messageController = TextEditingController(); // Controller for text input
  ScrollController controller = ScrollController();

  late ChatController chatController;

  @override
  void initState() {
    super.initState();
    chatController = Get.put(ChatController(context: context));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await chatController.fetchChatDetails(loading: chatController.fetchChatDetail.isEmpty).then((value) {
        print("API Called");
        scrollToBottom();
      });
    });
  }

  void scrollToBottom() {
    if (controller.hasClients) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeInOut,
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToBottom();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuerySize = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        backgroundColor: const Color(0xfff8f9fa),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
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
            'Chat Support',
            style: CustomTextStyles.buttonTextStyle.copyWith(
              fontSize: 20.px,
              fontWeight: FontWeight.w600,
              color: AppColors.mainColor,
            ),
          ),
        ),
        body: Container(
          color: AppColors.blackColor.withOpacity(0.003),
          height: mediaQuerySize.height,
          width: mediaQuerySize.width,
          child: Column(
            children: [
              chatController.chatDetailLoading.value
                  ? Expanded(
                      child: Shimmer.fromColors(
                        baseColor: AppColors.baseColor,
                        highlightColor: AppColors.highlightColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.035),
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.01, vertical: mediaQuerySize.height * 0.03),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.blackColor.withOpacity(0.3)),
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : chatController.fetchChatDetail.isEmpty
                      ? Text(
                          "There is No Chat Available",
                          style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.mainColor),
                        )
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.035),
                            child: ListView.builder(
                              controller: controller,
                              itemCount: chatController.fetchChatDetail.length,
                              itemBuilder: (context, index) {
                                var message = chatController.fetchChatDetail[index];

                                bool isUser = message!.sender.toString().toLowerCase().contains('admin');
                                return message.messageType.toString().toLowerCase().contains('with')
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.01, vertical: mediaQuerySize.height * 0.03),
                                            margin: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.blackColor.withOpacity(0.3)),
                                              color: AppColors.whiteColor,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  message.status.toString().toLowerCase().contains('con')
                                                      ? Row(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment.end,
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Align(
                                                                alignment: Alignment.centerRight,
                                                                child: Text(
                                                                  'Withdraw Request',
                                                                  style: CustomTextStyles.customTitleTextStyle,
                                                                ),
                                                              ),
                                                            ),
                                                            // getHorizentalSpace(
                                                            //     mediaQuerySize.width * 0.05),
                                                            Expanded(
                                                              child: Align(
                                                                alignment: Alignment.centerRight,
                                                                child: Text(
                                                                  'Confirmed',
                                                                  style: TextStyle(
                                                                      fontSize: 13,
                                                                      fontFamily: 'regular',
                                                                      fontWeight: FontWeight.bold,
                                                                      color: AppColors.mainColor),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : Center(
                                                          child: Text(
                                                            'Withdraw Request',
                                                            style: CustomTextStyles.customTitleTextStyle,
                                                          ),
                                                        ),
                                                  const Divider(),
                                                  // Check if fields exist before displaying them
                                                  Text('Bank Name: ${message.bankName}', style: CustomTextStyles.customSubTitleTextStyle),
                                                  Text('Account Title: ${message.accountTitle}', style: CustomTextStyles.customSubTitleTextStyle),
                                                  Text('IBAN: ${message.iban}', style: CustomTextStyles.customSubTitleTextStyle),
                                                  RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: 'Amount: ',
                                                          style: CustomTextStyles.customTitleTextStyle,
                                                        ),
                                                        TextSpan(
                                                          text: '\$${message.amount}',
                                                          style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(vertical: 5.px),
                                                      child: Text(
                                                        formatDate(message.createdAt.toString()),
                                                        style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor, fontSize: 9.px),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Align(
                                        alignment: !isUser ? Alignment.centerRight : Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment: isUser ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: mediaQuerySize.height * 0.0133, horizontal: mediaQuerySize.width * 0.036),
                                              decoration: BoxDecoration(
                                                color: !isUser ? AppColors.mainColor : AppColors.whiteColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft: const Radius.circular(13),
                                                    bottomRight: const Radius.circular(13),
                                                    topRight: Radius.circular(!isUser ? 0 : 13),
                                                    topLeft: Radius.circular(!isUser ? 13 : 0)),
                                              ),
                                              child: Text(
                                                chatController.fetchChatDetail[index]!.text,
                                                style: TextStyle(color: !isUser ? AppColors.whiteColor : AppColors.blackColor, fontFamily: 'regular'),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 8, bottom: 15.px),
                                              child: Text(
                                                formatDate(message.createdAt.toString()),
                                                style: CustomTextStyles.buttonTextStyle.copyWith(color: AppColors.blackColor, fontSize: 9.px),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            ),
                          ),
                        ),
              // Text input field and send button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    getHorizentalSpace(2.w),
                    GestureDetector(
                      onTap: () {
                        chatController.fetchChatDetail.add(ChatDetailsModel(
                            id: "",
                            messageType: MessageType.MESSAGE,
                            text: messageController.text,
                            bankName: "",
                            accountTitle: "",
                            iban: "",
                            amount: 0,
                            status: Status.PENDING,
                            isRead: true,
                            sender: Sender.USER,
                            createdAt: DateTime.now()));
                        FocusScope.of(context).unfocus();
                        chatController.sendMessage(message: messageController.text);
                        messageController.clear();
                        controller.animateTo(
                          controller.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.mainColor, borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: mediaQuerySize.width * 0.08, vertical: mediaQuerySize.height * 0.017),
                          child: Icon(
                            Icons.send,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
