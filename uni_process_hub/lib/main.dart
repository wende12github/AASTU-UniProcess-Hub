import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_process_hub/features/notification_settings/controller/notification_settings_controller.dart';
import 'package:uni_process_hub/features/queue_status/controller/queue_controller.dart';
import 'package:uni_process_hub/main_navigation.dart';
import 'package:uni_process_hub/providers/app_state.dart';
import 'core/theme/app_theme.dart';
import 'features/queue_status/controller/queue_status_controller.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDI5vBDLY1Nb63_ahuUtzPWDmIGydkiT00",

        authDomain: "uinprocess-hub.firebaseapp.com",

        projectId: "uinprocess-hub",

        storageBucket: "uinprocess-hub.firebasestorage.app",

        messagingSenderId: "844537456058",

        appId: "1:844537456058:web:e0e84fd57cd5daaeede983",

        measurementId: "G-G4PV6E9VTN",
      ),
    );
    debugPrint('FCM BG message: ${message.messageId}');
  } else {
    await Firebase.initializeApp();
    debugPrint('FCM BG message: ${message.messageId}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
  } catch (e) {
    debugPrint("Firebase init error: $e");
  }
  runApp(const UinProcessApp());
}

class UinProcessApp extends StatelessWidget {
  const UinProcessApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppTheme()),
        ChangeNotifierProvider(create: (_) => QueueStatusController()),
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => QueueController()),
        ChangeNotifierProvider(create: (_) => NotificationSettingsController()),
        // ChangeNotifierProvider(create: (_) => )
      ],
      child: Consumer<AppTheme>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AASTU ASQS',
            theme: theme.lightTheme,
            darkTheme: theme.darkTheme,
            themeMode: theme.themeMode,
            home: const MainNavigation(),
          );
        },
      ),
    );
  }
}
