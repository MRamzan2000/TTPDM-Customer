// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:ttpdm/controller/custom_widgets/app_colors.dart';
// import 'package:ttpdm/controller/custom_widgets/widgets.dart';
//
// class PreviousAdds extends StatelessWidget {
//   const PreviousAdds({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 2.h),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Previous ads',
//               style: TextStyle(
//                   fontSize: 20.px,
//                   color: const Color(0xff2F3542),
//                   fontWeight: FontWeight.w500,
//                   fontFamily: 'bold'),
//             ),
//             getVerticalSpace(.8.h),
//             Container(padding: EdgeInsets.all(
//               1.6.h
//             ),
//               width: MediaQuery.of(context).size.width,
//               color: AppColors.whiteColor,
//
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Image.asset('assets/pngs/addsimage.png'),
//                   getVerticalSpace(.8.h),
//                   Text('Ads Name',style: TextStyle(
//                     fontSize: 14.px,fontFamily: 'bold',
//                     fontWeight: FontWeight.w500,
//                     color: const Color(0xff191918)
//                   ),),
//                   getVerticalSpace(.5.h),
//                   Text('Lorem ipsum dolor sit amet, consectetur adipiing elit...',style: TextStyle(
//                       fontSize: 12.px,fontFamily: 'bold',
//                       fontWeight: FontWeight.w500,
//                       color: const Color(0xff6E6E6D)
//                   ),)
//
//                 ],
//               ),
//             ),
//             getVerticalSpace(1.6.h),
//             Container(padding: EdgeInsets.all(
//                 1.6.h
//             ),
//               width: MediaQuery.of(context).size.width,
//               color: AppColors.whiteColor,
//
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   getVerticalSpace(.8.h),
//                   Text('Ads Name',style: TextStyle(
//                       fontSize: 14.px,fontFamily: 'bold',
//                       fontWeight: FontWeight.w500,
//                       color: const Color(0xff191918)
//                   ),),
//                   getVerticalSpace(.5.h),
//                   Text('Lorem ipsum dolor sit amet, consectetur adipiscg elit...',style: TextStyle(
//                       fontSize: 12.px,fontFamily: 'bold',
//                       fontWeight: FontWeight.w500,
//                       color: const Color(0xff6E6E6D)
//                   ),)
//
//                 ],
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
