import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firmer_city/config/router/router.dart';
import 'package:firmer_city/utils/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //remove hashbang from url
  setPathUrlStrategy();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //initialize hive
  //get app directory
  if(!kIsWeb) {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    var path = '${appDocumentsDir.path}/db';
    Hive.init(path);
  }
  await Hive.openBox('user');
  await Hive.openBox('route');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Farmer City',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      builder: FlutterSmartDialog.init(builder: (context, child) {
        // var userStream = ref.watch(loginProviderStream);
        var widget = ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 600, name: MOBILE),
            const Breakpoint(start: 601, end: 900, name: TABLET),
            const Breakpoint(start: 901, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
        );
        return widget;
      }),
      routerConfig: router(ref),
    );
  }
}
