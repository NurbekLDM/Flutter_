import 'package:flutter/material.dart';
import '../data.dart';
import '../models/product.dart';
import 'HomePage.dart';

class AddNewProductPage extends StatefulWidget {
  @override
  _AddNewProductPageState createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  String? selectedCategory;
  bool isSubmitEnabled = false;

  final List<String> Categories = [ 'Acer', 'MacOs', 'HP', 'Lenovo', 'VivoBook'];


  // This function checks whether all required fields are filled
  void checkSubmitStatus() {
    setState(() {
      isSubmitEnabled = titleController.text.isNotEmpty &&
          priceController.text.isNotEmpty &&
          imageUrlController.text.isNotEmpty &&
          selectedCategory != null;
    });
  }

  // This function is responsible for adding a new product
  void addProduct() {
    if (isSubmitEnabled) {
      final newProduct = Product(
        title: titleController.text,
        category: selectedCategory!,
        price: double.parse(priceController.text),
        imageUrl: imageUrlController.text,
      );

      // Insert the new product at the beginning of the list
      products.insert(0, newProduct);

      // Navigate back to the Home page and clear the back stack
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    titleController.addListener(checkSubmitStatus);
    priceController.addListener(checkSubmitStatus);
    imageUrlController.addListener(checkSubmitStatus);
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Row(
          children: [
            Text('Add New Product', style: TextStyle(color: Colors.white)),
            Icon(Icons.add, color: Colors.white),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Product Title',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              dropdownColor: Colors.blueGrey[900],
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
                checkSubmitStatus();
              },
              hint: Text('Select Category', style: TextStyle(color: Colors.white)),
              items: Categories.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.white)),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // foreground
                ),
                onPressed: isSubmitEnabled ? addProduct : null,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}