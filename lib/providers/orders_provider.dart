import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shop_app_version5/providers/cart_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app_version5/widgets/cart_item_widget.dart';

class OrderModel {
  final String id;
  final double amount;
  final List<CartModel> products;
  final DateTime dateTime;

  OrderModel({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        "https://shopapp-46d5c-default-rtdb.firebaseio.com/orders.json");
    final response = await http.get(url);
    final List<OrderModel> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }

    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderModel(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartModel(
                  id: item["id"],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price']))
              .toList(),
        ),
      );
    });

    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartModel> cartProducts, double total) async {
    print("api called");
    final url = Uri.parse(
        "https://shopapp-46d5c-default-rtdb.firebaseio.com/orders.json");
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map(
              (cp) => {
                "id": cp.id,
                "title": cp.title,
                "quantity": cp.quantity,
                "price": cp.price,
              },
            )
            .toList(),
      }),
    );

    _orders.insert(
      0,
      OrderModel(
        id: json.decode(response.body)["name"],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
