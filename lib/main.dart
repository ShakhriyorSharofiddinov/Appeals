import 'package:appeal/main_provider.dart';
import 'package:appeal/presentation/pages/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale("uz", "UZ"),
        Locale("ru", "RU"),
        Locale("en", "US"),
      ],
      path: "assets/translation",
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => MainProvider())],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(builder: (context, data, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Appeals',
        theme: ThemeData(fontFamily: "Manrope"),
        home: HomePage(),
      );
    });
  }
}
