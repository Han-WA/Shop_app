import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_version5/providers/cart_provider.dart';
import 'package:shop_app_version5/providers/orders_provider.dart';
import 'package:shop_app_version5/providers/product_provider.dart';
import 'package:shop_app_version5/screens/cart_screen.dart';
import 'package:shop_app_version5/screens/edit_product_screen.dart';
import 'package:shop_app_version5/screens/orders_screen.dart';
import 'package:shop_app_version5/screens/product_detail_screen.dart';
import 'package:shop_app_version5/screens/products_overview_screen.dart';
import 'package:shop_app_version5/screens/user_products_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MyShop",
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          "/": (ctx) => ProductsOverviewScreen(),
          "/product_detail_screen": (ctx) => ProductDetailScreen(),
          "/cart_screen": (ctx) => CartScreen(),
          "/order_screen": (ctx) => OrderScreen(),
          "/user_product": (ctx) => UserProductsScreen(),
          "/edit_product": (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
