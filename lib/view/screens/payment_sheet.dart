// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
//
// class PaymentBottomSheet extends StatelessWidget {
//   final String sessionId;
//   final String checkoutUrl;
//
//   const PaymentBottomSheet({super.key, required this.sessionId, required this.checkoutUrl});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           ListTile(
//             title: const Text('Pay Now'),
//             onTap: () async {
//               // Create a payment method in Stripe
//               final paymentIntent = await Stripe.instance.confirmPayment(
//                 options:PaymentMethodOptions(
//                     sessionId
//                 ) ,
//                 options : sessionId,
//                 paymentIntentClientSecret: checkoutUrl,
//               );
//
//               // Handle payment confirmation
//               if (paymentIntent.status == PaymentIntentStatus.succeeded) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Payment Successful!')),
//                 );
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Payment Failed!')),
//                 );
//               }
//               Navigator.pop(context); // Close the bottom sheet
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
