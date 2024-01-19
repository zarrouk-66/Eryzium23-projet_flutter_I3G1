import 'package:flutter/material.dart';
import 'package:projet_flutter_i3g1/homepage.dart';
import 'package:provider/provider.dart';
import 'model_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: themeNotifier.isDark ? ThemeData(brightness: Brightness.dark,) :
                ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Colors.green,
                  primarySwatch: Colors.green
              ),
              debugShowCheckedModeBanner: false,
              home: const HomePage(),
            );
          }),
    );
  }
}

