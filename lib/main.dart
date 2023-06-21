import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:kitap_sarayi_app/Pages/SplashVersin/slpash_version_view.dart';
import 'package:kitap_sarayi_app/Pages/login_page.dart';
import 'package:kitap_sarayi_app/Tools/basil_theme.dart';
import 'package:kitap_sarayi_app/Tools/theme_manager.dart';
import 'package:kitap_sarayi_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DeviceUtility.instance.initPackageInfo(); // PackageInfo'yu başlat

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

ThemeManager themeManager = ThemeManager();

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  void themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    const theme = BasilTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginPage(),
      },
      title: 'Kitap Sarayı',
      theme: theme.toThemeData(),
      home: const SplashVersionView(),
    );
  }
}
