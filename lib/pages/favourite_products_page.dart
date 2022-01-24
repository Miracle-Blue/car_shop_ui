import 'package:car_shop_ui/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'model_home/products_model.dart';

class FavProductsPage extends StatefulWidget {
  const FavProductsPage({Key? key}) : super(key: key);

  static const String id = "/favourite_products_page";

  @override
  _FavProductsPageState createState() => _FavProductsPageState();
}

class _FavProductsPageState extends State<FavProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Favourites",
          style: TextStyle(fontSize: 25, color: Colors.redAccent),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: ProductList.favProducts.map((e) => productField(e)).toList()
      ),
    );
  }

  Widget productField(Product element) {
    return Container(
      height: 230,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(element.image), fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ]),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(0.9),
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.3),
            Colors.black.withOpacity(0.2),
          ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            element.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            element.type,
                            style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Text(
                  "\$${element.cost}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: element.isLike ? Colors.white : Colors.redAccent,
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      element.isLike = !element.isLike;
                      element.isLike
                          ? ProductList.favProducts.add(element)
                          : ProductList.favProducts.remove(element);
                    });
                  },
                  icon: element.isLike
                      ? const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                    size: 22,
                  )
                      : const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
