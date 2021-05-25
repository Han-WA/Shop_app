import 'package:flutter/material.dart';
import 'package:shop_app_version5/screens/orders_screen.dart';
import 'package:shop_app_version5/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hello Friend!"),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
            leading: Icon(Icons.shop),
            title: Text("Shop"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },
            leading: Icon(Icons.payment),
            title: Text("Orders"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
          ),
        ],
      ),
    );
  }
}
