import 'package:flutter/material.dart';
import 'package:nike_ecommerce/data/favorite_manager.dart';
import 'package:nike_ecommerce/data/product.dart';
import 'package:nike_ecommerce/data/repo/auth_repository.dart';
import 'package:nike_ecommerce/data/repo/banner_repository.dart';
import 'package:nike_ecommerce/data/repo/product_repository.dart';
import 'package:nike_ecommerce/theme.dart';
import 'package:nike_ecommerce/ui/root.dart';

void main() async{
  await FavoriteManager.init();
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    productRepository.getAll(ProductSort.latest).then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    bannerRepository.getAll().then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    const defaultTextStyle = TextStyle(
        fontFamily: 'BYekan', color: LightThemeColors.primaryTextColor);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: LightThemeColors.primaryTextColor,
          elevation: 0,
        ),
        hintColor: LightThemeColors.secondaryTextColor,
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: LightThemeColors.primaryTextColor.withOpacity(0.1)),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: defaultTextStyle.copyWith(color: Colors.white)),
        textTheme: TextTheme(
          labelLarge: defaultTextStyle,
          bodyMedium: defaultTextStyle,
          labelSmall: defaultTextStyle.apply(
              color: LightThemeColors.secondaryTextColor),
          titleMedium: defaultTextStyle.apply(
              color: LightThemeColors.secondaryTextColor),
          titleLarge: defaultTextStyle,
          bodySmall: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        colorScheme: const ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: Colors.white,
          surfaceVariant: Color(0xffF5F5F5),
        ),
      ),
      home: const Directionality(
          textDirection: TextDirection.rtl, child: RootScreen()),
    );
  }
}
