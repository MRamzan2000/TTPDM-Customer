import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttpdm/controller/getx_controllers/internet_connectvty_controller.dart';
import 'package:ttpdm/controller/utils/push_notification.dart';
import 'package:ttpdm/view/screens/splash_screen.dart';

import 'controller/check_internet_connectivity.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await notificationServices.showNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51PWFAtRsuZrhcR6RkiVOIRrb6Nfhw9f8alHztCUuBZBSaBU6VHzlbpS2E4PaVcQF6VLDI66X5YKjnCJYkVCorioY00cQAyLk2R';
  Stripe.urlScheme = 'flutterstripe';
  Stripe.merchantIdentifier = 'any string works';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  Get.put(ConnectivityController()); // Ensure ConnectivityController is initialized

  runApp(const MyApp());
}

final NotificationServices notificationServices = NotificationServices();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    notificationServices.firebaseInit(context);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) => const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: ConnectivityWrapper(child: SplashScreen()), // Wrap your initial screen
      ),
    );
  }
}

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final ConnectivityController connectivityController = Get.find();
    return Obx(() {
      if (connectivityController.isConnected.value) {
        return child;
      } else {
        return const ConnectivityScreen();
      }
    });
  }
}

