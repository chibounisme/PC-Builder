import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:pcbuilder/models/configuration.dart';
import 'package:flutter/services.dart';

import 'package:pcbuilder/screens/welcomescreen.dart';
import 'package:pcbuilder/services/auth.dart';
import 'package:pcbuilder/services/pushNotification.dart';
import 'package:pcbuilder/utils/currencies.dart';
import 'package:provider/provider.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getIt.registerSingleton<Configuration>(Configuration());
  getIt.registerSingleton<Currencies>(Currencies());
  getIt.registerLazySingleton(() => PushNotificationService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PushNotificationService _pushNotificationService =
      getIt<PushNotificationService>();

  Future handleStartUpLogic() async {
    await _pushNotificationService.initialise();
  }

  @override
  Widget build(BuildContext context) {
    handleStartUpLogic();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return StreamProvider.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(color: Colors.white)),
              fontFamily: "Nunito"),
          home: WelcomeScreen(),
        ));
  }
}
