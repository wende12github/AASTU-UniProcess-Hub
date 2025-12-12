import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_process_hub/features/queue_status/widgets/ui/queue_status_screen.dart';
import 'core/theme/app_theme.dart';
import 'features/queue_status/controller/queue_status_controller.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      ],
      child: Consumer<AppTheme>(
        builder: (context, theme, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AASTU ASQS',
            theme: theme.lightTheme,
            darkTheme: theme.darkTheme,
            themeMode: theme.themeMode,
            home: const QueueStatusScreen(),
          );
        },
      ),
    );
  }
}
