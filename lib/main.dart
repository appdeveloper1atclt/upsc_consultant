import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

import 'package:provider/provider.dart';
import 'modules/daily_challenge/provider/pt_challenge_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PtChallengeController()),
      ],
      child: const UPSCConsultantApp(),
    ),
  );
}


class UPSCConsultantApp extends StatelessWidget {
  const UPSCConsultantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UPSC Consultant',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: appTheme(),
    );
  }
}
