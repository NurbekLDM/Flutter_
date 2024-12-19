import 'package:flutter/material.dart';
import 'package:online_shopping/data.dart';
import 'AdminLogin.dart';
import 'package:animated_search_bar/animated_search_bar.dart';

import '../models/product.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> displayedProducts = [];
  String searchQuery = '';
  String selectedCategory = 'All';
  bool sortAscending = true;
  final List<String> Categories = ['All', 'Acer', 'MacOs', 'HP', 'Lenovo', 'VivoBook'];

  @override
  void initState() {
    super.initState();
    displayedProducts = products; // Initialize with all products
  }

  void searchProducts(String query) {
    setState(() {
      searchQuery = query;
      displayedProducts = products.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void sortProducts() {
    setState(() {
      sortAscending = !sortAscending;
      displayedProducts.sort((a, b) =>
      sortAscending ? a.price.compareTo(b.price) : b.price.compareTo(a.price));
    });
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        displayedProducts = products; // Display all products
      } else {
        displayedProducts = products.where((product) {
          return product.category == category;
        }).toList();
      }
    });
  }

  List<Widget> buildProductPairs() {
    List<Widget> productPairs = [];
    for (int i = 0; i < displayedProducts.length; i += 2) {
      var firstProduct = displayedProducts[i];
      var secondProduct = (i + 1 < displayedProducts.length)
          ? displayedProducts[i + 1]
          : null;

      productPairs.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ProductCard(firstProduct),
              ),
              if (secondProduct != null)
                Expanded(
                  child: ProductCard(secondProduct),
                ),
            ],
          ),
        ),
      );
    }
    return productPairs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Row(
          children: [
            Text('TechPro', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
            
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sort_outlined, color: Colors.white),
            onPressed: sortProducts, 
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: AnimatedSearchBar(
          label: "Qidiruv...",
          labelStyle: TextStyle(color: Colors.black),
          searchDecoration: InputDecoration(
            hintText: "Mahsulotlar, brendlar va boshqalarni qidiring",
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
          ),
          cursorColor: Colors.blueAccent,
          onChanged: searchProducts
            
            )
          ),
          
          
          Container(
            margin: const EdgeInsets.only(top: 5, right: 320),
            child:const  Text('Categories', style: TextStyle(color: Colors.black, fontSize: 30)),
          ),

        Container(
          margin: const EdgeInsets.only(top: 20),
          child:
          Wrap(
            spacing: 8.0,
            children: List<Widget>.generate(
              Categories.length,
              (int index) {
                return ChoiceChip(
                  label: Text(Categories[index]),
                  selected: selectedCategory == Categories[index],
                  onSelected: (bool selected) {
                    setState(() {
                      selectedCategory = Categories[index];
                      filterByCategory(selectedCategory);
                    });
                  },
                  showCheckmark: false,
                );
              },
            ).toList(),
          ),
        ),

          Expanded(
            child: ListView(
              children: buildProductPairs(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminLoginPage()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 34, 65, 81),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 186, 185, 185),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            Center(
              child: Image.network(
                product.imageUrl,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              product.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text('Category: ${product.category}', style: TextStyle(color: Colors.white)),
            Text('Price: \$${product.price}', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}



