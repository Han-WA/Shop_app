import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_version5/providers/orders_provider.dart';
import 'package:shop_app_version5/widgets/drawer_widget.dart';
import 'package:shop_app_version5/widgets/order_item_widget.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "/order_screen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future _orderFuture;
  Future _obtainedFuture() {
    return Provider.of<OrderProvider>(context, listen: false)
        .fetchAndSetOrders();
  }

  @override
  void initState() {
    _orderFuture = _obtainedFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _orderFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return Center(child: Text("An error occured!"));
            } else {
              return Consumer<OrderProvider>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (context, i) => OrderItem(
                    orderData.orders[i],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
