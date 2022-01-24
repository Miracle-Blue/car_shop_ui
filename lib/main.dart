import 'package:car_shop_ui/pages/favourite_products_page.dart';
import 'package:car_shop_ui/pages/home_page.dart';
import 'package:car_shop_ui/pages/pull_to_refresh.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        PullToRefresh.id: (context) => const PullToRefresh(),
        FavProductsPage.id: (context) => const FavProductsPage(),
      },
    );
  }
}
