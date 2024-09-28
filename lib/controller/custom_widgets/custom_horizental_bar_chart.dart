
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HorizentalBarChart extends StatelessWidget {
  const HorizentalBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    RxList<Animation<Color?>> colorsList=<Animation<Color?>>[const AlwaysStoppedAnimation( Color(0xffB558F6)),const AlwaysStoppedAnimation( Color(0xff29CB97)),const AlwaysStoppedAnimation( Color(0xffFEC400)),const AlwaysStoppedAnimation( Color(0xff4072EE))].obs;
    RxList<double> valuesList=<double>[63,47,52,81].obs;

    return Scaffold(
      backgroundColor: const Color(0xfff8f9fa),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 21.h,
                    child: SvgPicture.asset(
                      'assets/svgs/verticalline.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 21.h,
                    child: SvgPicture.asset(
                      'assets/svgs/verticalline.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 21.h,
                    child: SvgPicture.asset(
                      'assets/svgs/verticalline.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 21.h,
                    child: SvgPicture.asset(
                      'assets/svgs/verticalline.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 21.h,
                    child: SvgPicture.asset(
                      'assets/svgs/verticalline.svg',
                      fit: BoxFit.cover,
                    ),
                  ),                ],
              ),
              const Divider(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 37.h,
            child: ListView.builder(
              itemCount: 4,shrinkWrap: true,padding: EdgeInsets.zero,

              itemBuilder: (context, index) {
              return Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 2.8.h),
                          height: .90.h,
                          width:valuesList[index].h,
                        
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(2.h),
                            color: const Color(0xff29CB97),
                            value: valuesList[index]/100.0,
                            minHeight: 20, // Set a fixed height or use .h for responsive height
                            valueColor:colorsList[index],
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                      Column(mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${valuesList[index]}",style: TextStyle(fontWeight: FontWeight.w400,
                            fontSize: 14.px,color: const Color(0xff31394D),
                            fontFamily: 'medium',
                          ),),
                          Text("%",style: TextStyle(fontWeight: FontWeight.w400,
                            fontSize: 16.px,color: const Color(0xff31394D),
                            fontFamily: 'medium',
                          ),),
                        ],
                      ),
                    ],
                  ),


                ],
              );
            },),
          ),
         

        ],
      ),
    );
  }
}
