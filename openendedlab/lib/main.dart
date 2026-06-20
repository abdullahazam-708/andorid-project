import 'package:flutter/material.dart';

void main() {
  runApp(ProductApp());
}

class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product data app```',
      home: ProductScreen(),
    );
  }
}

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final txtCode = TextEditingController();
  final txtName = TextEditingController();
  final txtPrice = TextEditingController();
  final txtQty = TextEditingController();
  List<Map<String, dynamic>> products = [];



  void addProduct() {
    String code = txtCode.text;
    String name = txtName.text;
    double? price = double.tryParse(txtPrice.text);
    int? qty = int.tryParse(txtQty.text);


    if (code.isEmpty || name.isEmpty || price == null || qty == null) {
      showMsg("some text fields are empty ");
      return;
    }

    if (price < 0 || qty < 0) {
      showMsg("Price and Quantity cannot be negative");
      return;
    }

    bool exists = products.any((p) => p['code'] == code);
    if (exists) {
      showMsg("Product code must be unique");
      return;
    }

    setState(() {
      products.add({
        'code': code, 'name': name, 'price': price, 'qty': qty,
      });
    });


  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product data app")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: txtCode,
              decoration: InputDecoration(labelText: "Product Code"),
            ),
            TextField(
              controller: txtName,
              decoration: InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: txtPrice,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Price"),
            ),
            TextField(
              controller: txtQty,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Quantity"),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed: addProduct,
              child: Text("Add Product"),
            ),

            SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  var p = products[index];

                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text("${p['name']} (${p['code']})"),
                      subtitle: Text(
                          "Price: ${p['price']} | Qty: ${p['qty']}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}