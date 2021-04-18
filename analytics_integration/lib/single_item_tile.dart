import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class SingleItemTile extends StatefulWidget {
  final String price;
  final String itemName;
  final double quantity;
  final FirebaseAnalytics analytics;

  SingleItemTile({
    this.itemName,
    this.price,
    this.quantity,
    this.analytics,
  });

  @override
  _SingleItemTileState createState() => _SingleItemTileState();
}

class _SingleItemTileState extends State<SingleItemTile> {
  /// [addedToCart] this variable is used to to justify that product is added in
  /// cart or not
  bool addedToCart;

  @override
  void initState() {
    addedToCart = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.green,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'asset/carrot.jpg',
            height: 200,
            width: 400,
          ),
          Container(
            color: Colors.green,
            height: .5,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0) + EdgeInsets.only(left: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.price,
                      style: TextStyle(
                        color: Colors.red[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.itemName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      widget.quantity.toString() + ' kg',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      addedToCart = !addedToCart;
                    });
                    _sendCartEvent(widget.price, widget.itemName,
                        widget.quantity, addedToCart);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.green,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        addedToCart ? 'Remove from Cart' : 'Add to Cart +',
                        style: TextStyle(
                          color: Colors.red[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// to make custom event in Analytics you can create your own Map
  /// below in [name] field give your event name identifier
  /// and in [parameters] filed create your map
  Future<void> _sendCartEvent(
      String price, String itemName, double quantity, bool addedToCart) async {
    await widget.analytics.logEvent(
      name: 'item',
      parameters: <String, dynamic>{
        'price': price,
        'itemName': itemName,
        'quantity': quantity,
        'bool': addedToCart,
      },
    );
  }
}
