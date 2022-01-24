import 'package:flutter/material.dart';
import 'favourite_products_page.dart';
import 'model_home/products_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String id = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int selectedIndex = 0;
  late var res;

  List<String> categories = [
    "All",
    "Red",
    "Blue",
    "Yellow",
    "Green",
    "Grey",
  ];

  List<Product> products = [];

  void changeCategory() {
    products.clear();
    for (var element in ProductList.products) {
      if (categories[selectedIndex] == element.category ||
          categories[selectedIndex] == "All") {
        products.add(element);
      }
    }
  }

  Future loadData() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeCategory();
    print("initState");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('AppLifecycleState: $state');
  }

  @override
  void dispose() {
    print("dispose");
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    print("deactivate");
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: appBar(),
      body: RefreshIndicator(
        onRefresh: loadData,
        child: ListView(
          children: [
            headerCategories(context),
            ...products.map((e) => productField(e)).toList(),
          ],
        ),
      ),
    );
  }

  AppBar appBar() => AppBar(
    elevation: 0,
    backgroundColor: Colors.grey.shade300,
    title: const Text(
      "Cars",
      style: TextStyle(fontSize: 25, color: Colors.redAccent),
    ),
    actions: [
      Stack(
        children: [
          IconButton(
            splashRadius: 25,
            onPressed: () async {
                await Navigator.pushNamed(context, FavProductsPage.id);
                setState(() {});
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Colors.redAccent,
            ),
          ),
          if (ProductList.favProducts.isNotEmpty)
            Positioned(
              left: 24,
              top: 8,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.redAccent,
                child: Center(
                  child: Text("${ProductList.favProducts.length}", style: const TextStyle(color: Colors.white, fontSize: 12),),
                ),
              ),
            )
        ],
      ),
      IconButton(
        splashRadius: 25,
        onPressed: () {},
        icon: const Icon(
          Icons.notifications_none_outlined,
          color: Colors.redAccent,
        ),
      ),
      IconButton(
        splashRadius: 25,
        onPressed: () {},
        icon: const Icon(
          Icons.shopping_cart_outlined,
          color: Colors.redAccent,
        ),
      ),
    ],
  );

  Widget headerCategories(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.05,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => carCategoriesField(index),
      ),
    );
  }

  Widget carCategoriesField(int index) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: ChoiceChip(
        backgroundColor: Colors.white,
        selectedColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        label: Text(
          categories[index],
          style: TextStyle(
              color: (selectedIndex == index) ? Colors.white : Colors.black),
        ),
        onSelected: (bool value) {
          setState(() {
            selectedIndex = index;
            changeCategory();
          });
        },
        selected: selectedIndex == index,
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
